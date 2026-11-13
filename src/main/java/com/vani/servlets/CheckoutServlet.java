
package com.vani.servlets;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.vani.utility.DBConnection;

@WebServlet("/checkoutServlet")
public class CheckoutServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private static final BigDecimal DELIVERY_FEE =
			new BigDecimal("40.00");

	// ============================
	// GET: Open checkout page
	// ============================

	@Override
	protected void doGet(
			HttpServletRequest request,
			HttpServletResponse response)
					throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		// Mandatory login validation
		if (session == null || session.getAttribute("userId") == null) {

			HttpSession newSession = request.getSession(true);

			newSession.setAttribute(
					"redirectAfterLogin",
					request.getContextPath() + "/checkoutServlet"
					);

			response.sendRedirect(
					request.getContextPath()
					+ "/login.html?message=loginRequired"
					);

			return;
		}

		request.getRequestDispatcher("/checkout.jsp")
		.forward(request, response);
	}


	// ============================
	// POST: Place customer order
	// ============================

	@Override
	protected void doPost(
			HttpServletRequest request,
			HttpServletResponse response)
					throws ServletException, IOException {

		// 1. Validate login session

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("userId") == null) {

			response.sendError(
					HttpServletResponse.SC_UNAUTHORIZED,
					"Please log in before placing an order."
					);

			return;
		}

		Object sessionUserId = session.getAttribute("userId");

		if (!(sessionUserId instanceof Integer)) {

			response.sendError(
					HttpServletResponse.SC_UNAUTHORIZED,
					"Invalid login session. Please log in again."
					);

			return;
		}

		int userId = (Integer) sessionUserId;


		// 2. Validate payment mode


		String paymentMode = request.getParameter("paymentMode");

		if (!"Cash on Delivery".equals(paymentMode)) {

			response.sendError(
					HttpServletResponse.SC_BAD_REQUEST,
					"UPI payment is not available yet. Please select Cash on Delivery."
					);

			return;
		}


		// 3. Validate cart item count

		int itemCount;

		String itemCountParam = request.getParameter("itemCount");

		try {

		    if (itemCountParam == null || itemCountParam.trim().isEmpty()) {
		        throw new NumberFormatException("itemCount is missing");
		    }

		    itemCount = Integer.parseInt(itemCountParam);

		} catch (NumberFormatException e) {

		    getServletContext().log(
		        "CHECKOUT ERROR: Missing or invalid itemCount. Received: "
		        + itemCountParam
		    );

		    response.sendError(
		        HttpServletResponse.SC_BAD_REQUEST,
		        "Invalid cart. Please return to your cart and try again."
		    );

		    return;
		}

		if (itemCount < 1 || itemCount > 100) {

		    response.sendError(
		        HttpServletResponse.SC_BAD_REQUEST,
		        "Invalid number of cart items."
		    );

		    return;
		}

		// 4. Read menu IDs and quantities

		List<Integer> menuIds = new ArrayList<>();
		List<Integer> quantities = new ArrayList<>();

		try {

			for (int i = 0; i < itemCount; i++) {

				String menuIdValue =
						request.getParameter("menuId_" + i);

				String quantityValue =
						request.getParameter("quantity_" + i);

				int menuId = Integer.parseInt(menuIdValue);
				int quantity = Integer.parseInt(quantityValue);

				if (menuId <= 0 || quantity <= 0 || quantity > 100) {

					throw new IllegalArgumentException(
							"Invalid menu item or quantity."
							);
				}

				menuIds.add(menuId);
				quantities.add(quantity);
			}

		} catch (Exception e) {

			response.sendError(
					HttpServletResponse.SC_BAD_REQUEST,
					"Invalid cart item information."
					);

			return;
		}


		// 5. SQL queries

		String menuQuery =
				"SELECT restaurantId, price, isAvailable " +
						"FROM menu WHERE menuId = ?";

		String insertOrder =
				"INSERT INTO `order` " +
						"(userId, restaurantId, orderDate, totalAmount, status, paymentMode) " +
						"VALUES (?, ?, ?, ?, ?, ?)";

		String insertOrderItem =
				"INSERT INTO orderitem " +
						"(orderId, menuId, quantity, totalPrice) " +
						"VALUES (?, ?, ?, ?)";


		// 6. Database transaction

		try (Connection connection = DBConnection.getConnection()) {

			connection.setAutoCommit(false);

			try {

				int restaurantId = -1;

				BigDecimal subtotal = BigDecimal.ZERO;

				List<BigDecimal> itemTotals = new ArrayList<>();


				// 7. Validate menu items and calculate totals

				try (PreparedStatement menuStatement =
						connection.prepareStatement(menuQuery)) {

					for (int i = 0; i < menuIds.size(); i++) {

						menuStatement.setInt(1, menuIds.get(i));

						try (ResultSet rs =
								menuStatement.executeQuery()) {

							if (!rs.next()) {

								throw new Exception(
										"Menu item not found: "
												+ menuIds.get(i)
										);
							}

							int currentRestaurantId =
									rs.getInt("restaurantId");

							BigDecimal price =
									BigDecimal.valueOf(
											rs.getDouble("price")
											);

							boolean available =
									rs.getBoolean("isAvailable");


							if (!available) {

								throw new Exception(
										"A selected food item is unavailable."
										);
							}


							// Allow ordering from one restaurant only

							if (restaurantId == -1) {

								restaurantId = currentRestaurantId;

							} else if (
									restaurantId != currentRestaurantId) {

								throw new Exception(
										"Please order from one restaurant at a time."
										);
							}


							// Calculate individual item total

							BigDecimal itemTotal = price.multiply(
									BigDecimal.valueOf(quantities.get(i))
									);

							itemTotals.add(itemTotal);

							subtotal = subtotal.add(itemTotal);
						}
					}
				}


				// 8. Calculate final amount

				BigDecimal grandTotal =
						subtotal.add(DELIVERY_FEE);


				// 9. Insert order into order table

				int orderId;

				try (PreparedStatement orderStatement =
						connection.prepareStatement(
								insertOrder,
								Statement.RETURN_GENERATED_KEYS
								)) {

					orderStatement.setInt(1, userId);

					orderStatement.setInt(2, restaurantId);

					orderStatement.setTimestamp(
							3,
							new Timestamp(System.currentTimeMillis())
							);

					orderStatement.setBigDecimal(4, grandTotal);

					orderStatement.setString(5, "Placed");

					orderStatement.setString(6, paymentMode);


					int affectedRows =
							orderStatement.executeUpdate();

					if (affectedRows != 1) {

						throw new Exception(
								"Order insertion failed."
								);
					}


					// Retrieve generated order ID

					try (ResultSet keys =
							orderStatement.getGeneratedKeys()) {

						if (!keys.next()) {

							throw new Exception(
									"Unable to generate order ID."
									);
						}

						orderId = keys.getInt(1);
					}
				}


				// 10. Insert order items into orderitem table

				try (PreparedStatement itemStatement =
						connection.prepareStatement(insertOrderItem)) {

					for (int i = 0; i < menuIds.size(); i++) {

						itemStatement.setInt(1, orderId);

						itemStatement.setInt(2, menuIds.get(i));

						itemStatement.setInt(3, quantities.get(i));

						itemStatement.setBigDecimal(
								4,
								itemTotals.get(i)
								);

						itemStatement.addBatch();
					}

					itemStatement.executeBatch();
				}


				// 11. Commit transaction

				connection.commit();


				// 12. Store order details in session

				session.setAttribute("lastOrderId", orderId);

				session.setAttribute(
						"lastOrderTotal",
						grandTotal
						);

				session.setAttribute(
						"lastOrderItemCount",
						itemCount
						);

				session.removeAttribute("redirectAfterLogin");


				// 13. Redirect to order confirmation page

				response.sendRedirect(
						request.getContextPath() + "/order.jsp"
						);


			} catch (Exception e) {

				// Rollback if any transaction operation fails

				try {

					connection.rollback();

				} catch (SQLException rollbackError) {

					e.addSuppressed(rollbackError);
				}

				getServletContext().log(
						"ORDER TRANSACTION FAILED",
						e
						);

				response.sendError(
						HttpServletResponse.SC_BAD_REQUEST,
						"Order could not be placed: " + e.getMessage()
						);
			}

		} catch (Exception e) {

			// Database connection or setup failure

			getServletContext().log(
					"CHECKOUT DATABASE CONNECTION ERROR",
					e
					);

			response.sendError(
					HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
					"Database connection or checkout processing failed. Check Eclipse Console."
					);
		}
	}
}

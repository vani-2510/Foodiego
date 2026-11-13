
package com.vani.daoimplementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.vani.dao.OrderDao;
import com.vani.model.Order;
import com.vani.utility.DBConnection;

public class OrderDAOImpl implements OrderDao {

    private static final String INSERT_ORDER_QUERY ="INSERT INTO `order` (`userId`, `restaurantId`, `orderDate`, `totalAmount`, `status`, `paymentMode`) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String GET_ORDER_QUERY ="SELECT * FROM `order` WHERE `orderId` = ?";
    private static final String UPDATE_ORDER_QUERY ="UPDATE `order` SET `userId` = ?, `restaurantId` = ?, `orderDate` = ?, `totalAmount` = ?, `status` = ?, `paymentMode` = ? WHERE `orderId` = ?";
    private static final String DELETE_ORDER_QUERY = "DELETE FROM `order` WHERE `orderId` = ?";
    private static final String GET_ALL_ORDERS_QUERY = "SELECT * FROM `order`";
    private static final String GET_ORDERS_BY_USER_QUERY = "SELECT * FROM `order` WHERE `userId` = ?";

    @Override
    public void addOrder(Order order) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                 connection.prepareStatement(INSERT_ORDER_QUERY)) {

            prepareStatement.setInt(1, order.getUserId());
            prepareStatement.setInt(2, order.getRestaurantId());

            if (order.getOrderDate() != null) {
                prepareStatement.setTimestamp(
                    3, new java.sql.Timestamp(order.getOrderDate().getTime()));
            } else {
                prepareStatement.setTimestamp(3, null);
            }

            prepareStatement.setFloat(4, order.getTotalAmount());
            prepareStatement.setString(5, order.getStatus());
            prepareStatement.setString(6, order.getPaymentMode());

            int res = prepareStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Order getOrder(int orderId) {

        Order order = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                 connection.prepareStatement(GET_ORDER_QUERY)) {

            prepareStatement.setInt(1, orderId);

            ResultSet res = prepareStatement.executeQuery();

            if (res.next()) {
                order = extractOrder(res);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return order;
    }

    @Override
    public void updateOrder(Order order) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                 connection.prepareStatement(UPDATE_ORDER_QUERY)) {

            prepareStatement.setInt(1, order.getUserId());
            prepareStatement.setInt(2, order.getRestaurantId());

            if (order.getOrderDate() != null) {
                prepareStatement.setTimestamp(
                    3, new java.sql.Timestamp(order.getOrderDate().getTime()));
            } else {
                prepareStatement.setTimestamp(3, null);
            }

            prepareStatement.setFloat(4, order.getTotalAmount());
            prepareStatement.setString(5, order.getStatus());
            prepareStatement.setString(6, order.getPaymentMode());
            prepareStatement.setInt(7, order.getOrderId());

            prepareStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteOrder(int orderId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                 connection.prepareStatement(DELETE_ORDER_QUERY)) {

            prepareStatement.setInt(1, orderId);
            prepareStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Order> getAllOrders() {

        ArrayList<Order> ordersList = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             Statement statement = connection.createStatement();
             ResultSet res =
                 statement.executeQuery(GET_ALL_ORDERS_QUERY)) {

            while (res.next()) {
                Order order = extractOrder(res);
                ordersList.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return ordersList;
    }

    @Override
    public List<Order> getOrdersByUser(int userId) {

        ArrayList<Order> ordersList = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                 connection.prepareStatement(GET_ORDERS_BY_USER_QUERY)) {

            prepareStatement.setInt(1, userId);

            ResultSet res = prepareStatement.executeQuery();

            while (res.next()) {
                Order order = extractOrder(res);
                ordersList.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return ordersList;
    }

    Order extractOrder(ResultSet res) throws SQLException {

        int orderId = res.getInt("orderId");
        int userId = res.getInt("userId");
        int restaurantId = res.getInt("restaurantId");

        java.util.Date orderDate = res.getTimestamp("orderDate");

        float totalAmount = res.getFloat("totalAmount");
        String status = res.getString("status");
        String paymentMode = res.getString("paymentMode");

        Order order = new Order(
            orderId,
            userId,
            restaurantId,
            orderDate,
            totalAmount,
            status,
            paymentMode
        );

        return order;
    }
}

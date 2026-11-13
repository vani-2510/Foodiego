
package com.vani.servlets;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.vani.daoimplementation.UserDAOImpl;
import com.vani.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/callRegisterServlet")
public class RegisterServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req,
			HttpServletResponse resp)
					throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String phone = req.getParameter("phone");
		String password = req.getParameter("password");
		String address = req.getParameter("address");
		String role = req.getParameter("role");

		// Validate registration fields
		if (name == null || email == null || password == null
				|| phone == null || address == null || role == null
				|| name.trim().isEmpty()
				|| email.trim().isEmpty()
				|| password.isEmpty()
				|| phone.trim().isEmpty()
				|| address.trim().isEmpty()
				|| role.trim().isEmpty()) {

			resp.sendRedirect(
					req.getContextPath() + "/register.html?error=invalid"
					);
			return;
		}

		try {

			// Hash password before storing
			String hashedPassword =
					BCrypt.hashpw(password, BCrypt.gensalt(12));

			// Create User object
			User user = new User(
					0,
					name.trim(),
					name.trim(),
					hashedPassword,
					email.trim(),
					phone.trim(),
					address.trim(),
					role.trim(),
					null,
					null
					);

			// Save user into database
			UserDAOImpl userDAO = new UserDAOImpl();

			int result = userDAO.addUser(user);

			if (result > 0) {

				// Retrieve the newly created user's ID
				User registeredUser = userDAO.getUserByEmail(email.trim());

				if (registeredUser == null) {
					resp.sendRedirect(
							req.getContextPath() + "/login.html?registered=1"
							);
					return;
				}

				// Create session for automatic login
				HttpSession session = req.getSession(true);

				session.setAttribute(
						"userId",
						registeredUser.getUserId()
						);

				session.setAttribute(
						"username",
						registeredUser.getUsername()
						);

				session.setAttribute(
						"loggedInUser",
						registeredUser.getUsername()
						);

				session.setAttribute(
						"role",
						registeredUser.getRole()
						);

				// Redirect to restaurant page
				resp.sendRedirect(
						req.getContextPath() + "/callRestaurantServlet"
						);

			} else {

				resp.sendRedirect(
						req.getContextPath() + "/register.html?error=registration"
						);
			}

		} catch (Exception e) {

			e.printStackTrace();

			resp.sendRedirect(
					req.getContextPath() + "/register.html?error=server"
					);
		}
	}
}

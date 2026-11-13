package com.vani.servlets;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.vani.dao.UserDao;
import com.vani.daoimplementation.UserDAOImpl;
import com.vani.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/callLoginServlet")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        // Read email and password from login form
        String email = req.getParameter("username");
        String password = req.getParameter("password");

        // Validate input
        if (email == null || password == null
                || email.trim().isEmpty()
                || password.isEmpty()) {

            resp.sendRedirect(
                req.getContextPath() + "/login.html?error=invalid"
            );
            return;
        }

        try {

            // Find user using email
            UserDao userDao = new UserDAOImpl();
            User user = userDao.getUserByEmail(email.trim());

            // Check whether user exists
            if (user == null || user.getPassword() == null) {

                resp.sendRedirect(
                    req.getContextPath() + "/login.html?error=invalid"
                );
                return;
            }

            // Verify entered password against stored BCrypt hash
            boolean passwordMatches =
                BCrypt.checkpw(password, user.getPassword());

            if (passwordMatches) {

                // Create session after successful authentication
                HttpSession session = req.getSession(true);

                // Store logged-in user information
                session.setAttribute("loggedInUser", user);
                session.setAttribute("userId", user.getUserId());
                session.setAttribute("username", user.getUsername());
                session.setAttribute("role", user.getRole());

                // Check whether the customer came from checkout
                String redirectUrl = (String) session.getAttribute(
                    "redirectAfterLogin"
                );

                if (redirectUrl != null) {

                    // Remove saved redirect after retrieving it
                    session.removeAttribute("redirectAfterLogin");

                    // Return customer to checkout
                    resp.sendRedirect(redirectUrl);

                } else {

                    // Normal login: open restaurant page
                    resp.sendRedirect(
                        req.getContextPath() + "/callRestaurantServlet"
                    );
                }

            } else {

                // Incorrect password
                resp.sendRedirect(
                    req.getContextPath() + "/login.html?error=invalid"
                );
            }

        } catch (IllegalArgumentException e) {

            // For example, a malformed BCrypt hash
            getServletContext().log(
                "Invalid password hash during login.", e
            );

            resp.sendRedirect(
                req.getContextPath() + "/login.html?error=invalid"
            );

        } catch (Exception e) {

            // Log unexpected errors on the server
            getServletContext().log(
                "Login failed due to a server error.", e
            );

            resp.sendRedirect(
                req.getContextPath() + "/login.html?error=server"
            );
        }
    }
}

package com.vani.servlets;

import java.io.IOException;

import com.vani.dao.UserDao;
import com.vani.daoimplementation.UserDAOImpl;
import com.vani.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/editProfileServlet")
public class EditProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final UserDao userDao = new UserDAOImpl();

    // Display edit profile page
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect(
                request.getContextPath() + "/login.html"
            );
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        User user = userDao.getUser(userId);

        if (user == null) {
            response.sendError(
                HttpServletResponse.SC_NOT_FOUND,
                "User profile not found."
            );
            return;
        }

        request.setAttribute("user", user);

        request.getRequestDispatcher("/edit-profile.jsp")
               .forward(request, response);
    }


    // Save updated profile
    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect(
                request.getContextPath() + "/login.html"
            );
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Validate inputs
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {

            response.sendRedirect(
                request.getContextPath()
                + "/editProfileServlet?error=required"
            );
            return;
        }

        name = name.trim();
        email = email.trim();
        phone = phone == null ? "" : phone.trim();
        address = address == null ? "" : address.trim();

        if (name.length() > 100 ||
            email.length() > 150 ||
            phone.length() > 20 ||
            address.length() > 500 ||
            !email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {

            response.sendRedirect(
                request.getContextPath()
                + "/editProfileServlet?error=invalid"
            );
            return;
        }

        // Get existing user
        User user = userDao.getUser(userId);

        if (user == null) {
            response.sendError(
                HttpServletResponse.SC_NOT_FOUND,
                "User not found."
            );
            return;
        }

        // Update editable fields only
        user.setName(name);
        user.setEmail(email);
        user.setPhone(phone);
        user.setAddress(address);

        boolean updated = userDao.updateProfile(user);

        if (updated) {

            // Keep username available in the current session
            session.setAttribute("username", user.getUsername());

            response.sendRedirect(
                request.getContextPath()
                + "/profile.jsp?success=updated"
            );

        } else {

            response.sendRedirect(
                request.getContextPath()
                + "/editProfileServlet?error=database"
            );
        }
    }
}

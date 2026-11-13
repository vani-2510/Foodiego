
package com.vani.servlets;

import java.io.IOException;
import java.util.List;

import com.vani.daoimplementation.MenuDAOImpl;
import com.vani.daoimplementation.RestaurantDAOImpl;
import com.vani.model.Menu;
import com.vani.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("restaurantId");

        if (id == null || id.isBlank()) {
            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Restaurant ID is required."
            );
            return;
        }

        try {
            int restaurantId = Integer.parseInt(id);

            RestaurantDAOImpl restaurantDAO =
                new RestaurantDAOImpl();

            Restaurant restaurant =
                restaurantDAO.getRestaurant(restaurantId);

            if (restaurant == null) {
                response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Restaurant not found."
                );
                return;
            }

            MenuDAOImpl menuDAO = new MenuDAOImpl();

            List<Menu> menus =
                menuDAO.getMenusByRestaurant(restaurantId);

            request.setAttribute("restaurant", restaurant);
            request.setAttribute("menus", menus);

            request.getRequestDispatcher("/menu.jsp")
                   .forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Invalid restaurant ID."
            );
        }
    }
}

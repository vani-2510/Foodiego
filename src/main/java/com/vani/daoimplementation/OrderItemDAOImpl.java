package com.vani.daoimplementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.vani.dao.OrderItemDao;
import com.vani.model.OrderItem;
import com.vani.utility.DBConnection;

public class OrderItemDAOImpl implements OrderItemDao {

    private static final String INSERT_ORDER_ITEM_QUERY ="INSERT INTO `orderitem` (`orderId`, `menuId`, `quantity`, `totalPrice`) VALUES (?, ?, ?, ?)";
    private static final String GET_ORDER_ITEM_QUERY = "SELECT * FROM `orderitem` WHERE `orderItemId` = ?";
    private static final String UPDATE_ORDER_ITEM_QUERY ="UPDATE `orderitem` SET `orderId` = ?, `menuId` = ?, `quantity` = ?, `totalPrice` = ? WHERE `orderItemId` = ?";
    private static final String DELETE_ORDER_ITEM_QUERY ="DELETE FROM `orderitem` WHERE `orderItemId` = ?";
    private static final String GET_ALL_ORDER_ITEMS_QUERY ="SELECT * FROM `orderitem`";
    private static final String GET_ORDER_ITEMS_BY_ORDER_QUERY ="SELECT * FROM `orderitem` WHERE `orderId` = ?";

    @Override
    public void addOrderItem(OrderItem item) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                 connection.prepareStatement(INSERT_ORDER_ITEM_QUERY)) {

            prepareStatement.setInt(1, item.getOrderId());
            prepareStatement.setInt(2, item.getMenuId());
            prepareStatement.setInt(3, item.getQuantity());
            prepareStatement.setInt(4, item.getTotalPrice());

            prepareStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public OrderItem getOrderItem(int orderItemId) {
        OrderItem item = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                 connection.prepareStatement(GET_ORDER_ITEM_QUERY)) {

            prepareStatement.setInt(1, orderItemId);

            try (ResultSet res = prepareStatement.executeQuery()) {
                if (res.next()) {
                    item = extractOrderItem(res);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return item;
    }

    @Override
    public void updateOrderItem(OrderItem item) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                 connection.prepareStatement(UPDATE_ORDER_ITEM_QUERY)) {

            prepareStatement.setInt(1, item.getOrderId());
            prepareStatement.setInt(2, item.getMenuId());
            prepareStatement.setInt(3, item.getQuantity());
            prepareStatement.setInt(4, item.getTotalPrice());
            prepareStatement.setInt(5, item.getOrderitemId());

            prepareStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteOrderItem(int orderItemId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                 connection.prepareStatement(DELETE_ORDER_ITEM_QUERY)) {

            prepareStatement.setInt(1, orderItemId);
            prepareStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<OrderItem> getAllOrderItems() {
        List<OrderItem> orderItemsList = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             Statement statement = connection.createStatement();
             ResultSet res =
                 statement.executeQuery(GET_ALL_ORDER_ITEMS_QUERY)) {

            while (res.next()) {
                orderItemsList.add(extractOrderItem(res));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItemsList;
    }

    @Override
    public List<OrderItem> getOrderItemsByOrder(int orderId) {
        List<OrderItem> orderItemsList = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                 connection.prepareStatement(GET_ORDER_ITEMS_BY_ORDER_QUERY)) {

            prepareStatement.setInt(1, orderId);

            try (ResultSet res = prepareStatement.executeQuery()) {
                while (res.next()) {
                    orderItemsList.add(extractOrderItem(res));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItemsList;
    }

    OrderItem extractOrderItem(ResultSet res) throws SQLException {
        int orderItemId = res.getInt("orderItemId");
        int orderId = res.getInt("orderId");
        int menuId = res.getInt("menuId");
        int quantity = res.getInt("quantity");
        int totalPrice = res.getInt("totalPrice");

        return new OrderItem(
            orderItemId, orderId, menuId, quantity, totalPrice
        );
    }
}

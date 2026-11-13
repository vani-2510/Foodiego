
package com.vani.daoimplementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.vani.dao.RestaurantDao;
import com.vani.model.Restaurant;
import com.vani.utility.DBConnection;

public class RestaurantDAOImpl implements RestaurantDao {

    private static final String INSERT_RESTAURANT_QUERY = "INSERT into `restaurant` (`name`, `address`, `phone`, `rating`, `cusineType`, `isActive`, `eta`, `adminUserId`, `imagePath`) values(?,?,?,?,?,?,?,?,?)";
    private static final String GET_RESTAURANT_QUERY = "SELECT * FROM `restaurant` WHERE `restaurantId` = ?";
    private static final String UPDATE_RESTAURANT_QUERY = "UPDATE `restaurant` SET `name` = ?, `address` = ?, `phone` = ?, `rating` = ?, `cusineType` = ?, `isActive` = ?, `eta` = ?, `adminUserId` = ?, `imagePath` = ? WHERE `restaurantId` = ?";
    private static final String DELETE_RESTAURANT_QUERY = "DELETE FROM `restaurant` WHERE `restaurantId` = ?";
    private static final String GET_ALL_RESTAURANTS_QUERY ="SELECT * FROM `restaurant`";
    @Override
    public void addRestaurant(Restaurant restaurant) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =  connection.prepareStatement(INSERT_RESTAURANT_QUERY)) {

            prepareStatement.setString(1, restaurant.getName());
            prepareStatement.setString(2, restaurant.getAddress());
            prepareStatement.setString(3, restaurant.getPhone());
            prepareStatement.setDouble(4, restaurant.getRating());
            prepareStatement.setString(5, restaurant.getCusineType());
            prepareStatement.setBoolean(6, restaurant.isActive());
            prepareStatement.setString(7, restaurant.getEta());
            prepareStatement.setString(8, restaurant.getAdminUserId());
            prepareStatement.setString(9, restaurant.getImagePath());

            int res = prepareStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Restaurant getRestaurant(int restaurantId) {

        Restaurant restaurant = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                 connection.prepareStatement(GET_RESTAURANT_QUERY)) {

            prepareStatement.setInt(1, restaurantId);

            ResultSet res = prepareStatement.executeQuery();

            if (res.next()) {
                restaurant = extractRestaurant(res);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return restaurant;
    }

    @Override
    public void updateRestaurant(Restaurant restaurant) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement = connection.prepareStatement(UPDATE_RESTAURANT_QUERY)) {

            prepareStatement.setString(1, restaurant.getName());
            prepareStatement.setString(2, restaurant.getAddress());
            prepareStatement.setString(3, restaurant.getPhone());
            prepareStatement.setDouble(4, restaurant.getRating());
            prepareStatement.setString(5, restaurant.getCusineType());
            prepareStatement.setBoolean(6, restaurant.isActive());
            prepareStatement.setString(7, restaurant.getEta());
            prepareStatement.setString(8, restaurant.getAdminUserId());
            prepareStatement.setString(9, restaurant.getImagePath());
            prepareStatement.setInt(10, restaurant.getRestaurantId());

            prepareStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteRestaurant(int restaurantId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                 connection.prepareStatement(DELETE_RESTAURANT_QUERY)) {

            prepareStatement.setInt(1, restaurantId);
            prepareStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Restaurant> getAllRestaurants() {

        List<Restaurant> restaurantsList = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             Statement statement = connection.createStatement();
             ResultSet res =
                 statement.executeQuery(GET_ALL_RESTAURANTS_QUERY)) {

            while (res.next()) {
                Restaurant restaurant = extractRestaurant(res);
                restaurantsList.add(restaurant);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return restaurantsList;
    }

    Restaurant extractRestaurant(ResultSet res) throws SQLException {

        int restaurantId = res.getInt("restaurantId");
        String name = res.getString("name");
        String address = res.getString("address");
        String phone = res.getString("phone");
        double rating = res.getDouble("rating");
        String cusineType = res.getString("cusineType");
        boolean isActive = res.getBoolean("isActive");
        String eta = res.getString("eta");
        String adminUserId = res.getString("adminUserId");
        String imagePath = res.getString("imagePath");

        Restaurant restaurant = new Restaurant(
            restaurantId, name, address, phone, rating,
            cusineType, isActive, eta, adminUserId, imagePath
        );

        return restaurant;
    }
}

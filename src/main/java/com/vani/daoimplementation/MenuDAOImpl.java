
package com.vani.daoimplementation;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.vani.dao.MenuDao;
import com.vani.model.Menu;
import com.vani.utility.DBConnection;

public class MenuDAOImpl implements MenuDao {

    private static final String INSERT_QUERY = "INSERT INTO menu (restaurantId, itemName, description, price, ratings, isAvailable, imagePath) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?)";

    private static final String GET_QUERY ="SELECT * FROM menu WHERE menuId=?";

    private static final String UPDATE_QUERY ="UPDATE menu SET restaurantId=?, itemName=?, description=?, price=?, " +
        "ratings=?, isAvailable=?, imagePath=? WHERE menuId=?";

    private static final String DELETE_QUERY = "DELETE FROM menu WHERE menuId=?";

    private static final String GET_ALL_QUERY ="SELECT * FROM menu";

    private static final String GET_BY_RESTAURANT_QUERY ="SELECT * FROM menu WHERE restaurantId=?";

    @Override
    public void addMenu(Menu m) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(INSERT_QUERY)) {

            ps.setInt(1, m.getRestaurantId());
            ps.setString(2, m.getItemName());
            ps.setString(3, m.getDescription());
            ps.setDouble(4, m.getPrice());
            ps.setDouble(5, m.getRatings());
            ps.setBoolean(6, m.isAvailable());
            ps.setString(7, m.getImagePath());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Menu getMenu(int menuId) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(GET_QUERY)) {

            ps.setInt(1, menuId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractMenu(rs);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public void updateMenu(Menu m) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(UPDATE_QUERY)) {

            ps.setInt(1, m.getRestaurantId());
            ps.setString(2, m.getItemName());
            ps.setString(3, m.getDescription());
            ps.setDouble(4, m.getPrice());
            ps.setDouble(5, m.getRatings());
            ps.setBoolean(6, m.isAvailable());
            ps.setString(7, m.getImagePath());
            ps.setInt(8, m.getMenuId());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteMenu(int menuId) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(DELETE_QUERY)) {

            ps.setInt(1, menuId);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Menu> getAllMenus() {
        List<Menu> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(GET_ALL_QUERY)) {

            while (rs.next()) {
                list.add(extractMenu(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public List<Menu> getMenusByRestaurant(int restaurantId) {
        List<Menu> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps =
                 con.prepareStatement(GET_BY_RESTAURANT_QUERY)) {

            ps.setInt(1, restaurantId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractMenu(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    private Menu extractMenu(ResultSet rs) throws SQLException {
        Menu m = new Menu();

        m.setMenuId(rs.getInt("menuId"));
        m.setRestaurantId(rs.getInt("restaurantId"));
        m.setItemName(rs.getString("itemName"));
        m.setDescription(rs.getString("description"));
        m.setPrice(rs.getInt("price"));
        m.setRatings(rs.getInt("ratings"));
        m.setAvailable(rs.getBoolean("isAvailable"));
        m.setImagePath(rs.getString("imagePath"));

        return m;
    }
}

package com.vani.daoimplementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.vani.dao.UserDao;
import com.vani.model.User;
import com.vani.utility.DBConnection;

public class UserDAOImpl implements UserDao {

	// SQL queries
	private static final String INSERT_USER_QUERY =
			"INSERT INTO `user` " +
					"(`name`, `username`, `password`, `email`, `phone`, `address`, `role`) " +
					"VALUES (?, ?, ?, ?, ?, ?, ?)";

	private static final String GET_USER_QUERY =
			"SELECT * FROM `user` WHERE `userId` = ?";

	private static final String GET_USER_BY_USERNAME_QUERY =
			"SELECT * FROM `user` WHERE `username` = ?";

	private static final String GET_USER_BY_EMAIL_QUERY =
			"SELECT * FROM `user` WHERE `email` = ?";

	private static final String UPDATE_USER_QUERY =
			"UPDATE `user` SET `name` = ?, `password` = ?, `phone` = ?, " +
					"`address` = ?, `role` = ? WHERE `userId` = ?";

	private static final String DELETE_USER_QUERY =
			"DELETE FROM `user` WHERE `userId` = ?";

	private static final String GET_ALL_USERS_QUERY =
			"SELECT * FROM `user`";


	// Add a new user
	@Override
	public int addUser(User user) {

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement pstmt =
						connection.prepareStatement(INSERT_USER_QUERY)) {

			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getUsername());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getEmail());
			pstmt.setString(5, user.getPhone());
			pstmt.setString(6, user.getAddress());
			pstmt.setString(7, user.getRole());

			return pstmt.executeUpdate();

		} catch (SQLException e) {
			System.err.println("Error adding user to database:");
			e.printStackTrace();
		}

		return 0;
	}


	// Get user by user ID
	@Override
	public User getUser(int userId) {

		User user = null;

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement pstmt =
						connection.prepareStatement(GET_USER_QUERY)) {

			pstmt.setInt(1, userId);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					user = extractUser(rs);
				}
			}

		} catch (SQLException e) {
			System.err.println("Error retrieving user by ID:");
			e.printStackTrace();
		}

		return user;
	}


	// Get user by username
	@Override
	public User getUserByUsername(String username) {

		User user = null;

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement pstmt =
						connection.prepareStatement(GET_USER_BY_USERNAME_QUERY)) {

			pstmt.setString(1, username);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					user = extractUser(rs);
				}
			}

		} catch (SQLException e) {
			System.err.println("Error retrieving user by username:");
			e.printStackTrace();
		}

		return user;
	}


	// Get user by email - used for email-based login
	@Override
	public User getUserByEmail(String email) {

		User user = null;

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement pstmt =
						connection.prepareStatement(GET_USER_BY_EMAIL_QUERY)) {

			pstmt.setString(1, email);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					user = extractUser(rs);
				}
			}

		} catch (SQLException e) {
			System.err.println("Error retrieving user by email:");
			e.printStackTrace();
		}

		return user;
	}


	// Update an existing user
	@Override
	public void updateUser(User user) {

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement pstmt =
						connection.prepareStatement(UPDATE_USER_QUERY)) {

			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getPhone());
			pstmt.setString(4, user.getAddress());
			pstmt.setString(5, user.getRole());
			pstmt.setInt(6, user.getUserId());

			int rowsUpdated = pstmt.executeUpdate();

			if (rowsUpdated == 0) {
				System.out.println("No user found to update.");
			}

		} catch (SQLException e) {
			System.err.println("Error updating user:");
			e.printStackTrace();
		}
	}


	// Delete a user
	@Override
	public void deleteUser(int userId) {

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement pstmt =
						connection.prepareStatement(DELETE_USER_QUERY)) {

			pstmt.setInt(1, userId);

			int rowsDeleted = pstmt.executeUpdate();

			if (rowsDeleted == 0) {
				System.out.println("No user found to delete.");
			}

		} catch (SQLException e) {
			System.err.println("Error deleting user:");
			e.printStackTrace();
		}
	}


	// Get all users
	@Override
	public List<User> getAllUser() {

		List<User> usersList = new ArrayList<>();

		try (Connection connection = DBConnection.getConnection();
				Statement stmt = connection.createStatement();
				ResultSet rs = stmt.executeQuery(GET_ALL_USERS_QUERY)) {

			while (rs.next()) {
				usersList.add(extractUser(rs));
			}

		} catch (SQLException e) {
			System.err.println("Error retrieving all users:");
			e.printStackTrace();
		}

		return usersList;
	}

	@Override
	public boolean updateProfile(User user) {

		String sql = "UPDATE `user` SET name = ?, email = ?, " +
				"phone = ?, address = ? WHERE userId = ?";

		try (Connection con = DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, user.getName());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPhone());
			ps.setString(4, user.getAddress());
			ps.setInt(5, user.getUserId());

			return ps.executeUpdate() == 1;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}


	// Convert a database row into a User object
	private User extractUser(ResultSet rs) throws SQLException {

		int userId = rs.getInt("userId");
		String name = rs.getString("name");
		String username = rs.getString("username");
		String password = rs.getString("password");
		String email = rs.getString("email");
		String phone = rs.getString("phone");
		String address = rs.getString("address");
		String role = rs.getString("role");

		return new User(
				userId,
				name,
				username,
				password,
				email,
				phone,
				address,
				role,
				null,
				null
				);
	}
}

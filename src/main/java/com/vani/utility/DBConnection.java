
package com.vani.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL ="jdbc:mysql://localhost:3306/online_food?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

    private static final String USERNAME = "root";

    // Enter your actual MySQL Workbench password
    private static final String PASSWORD = "YOUR SQL PASSWORD";

    public static Connection getConnection() throws SQLException {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found.", e);
        }

        Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);

        System.out.println("MySQL Connected Successfully!");

        return connection;
    }
}

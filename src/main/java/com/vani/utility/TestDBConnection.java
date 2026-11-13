package com.vani.utility;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class TestDBConnection {

    public static void main(String[] args) {

        try (Connection con = DBConnection.getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(
                 "SELECT 1 AS test, DATABASE() AS dbName")) {

            if (rs.next()) {
                System.out.println("DATABASE CONNECTION SUCCESSFUL");
                System.out.println("Test value: " + rs.getInt("test"));
                System.out.println("Database: " + rs.getString("dbName"));
            }

        } catch (Exception e) {
            System.out.println("DATABASE CONNECTION FAILED");
            e.printStackTrace();
        }
    }
}

package com.metacube.assignment;

import com.metacube.utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Assignment4 {
    public void getParentCategoriesWithChildCount() {
        String query = "SELECT c1.category_name, COUNT(c2.category_id) AS child_count " +
                       "FROM categories c1 " +
                       "LEFT JOIN categories c2 ON c1.category_id = c2.parent_category_id " +
                       "WHERE c1.parent_category_id IS NULL " +
                       "GROUP BY c1.category_id " +
                       "ORDER BY c1.category_name ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                System.out.println("Category: " + rs.getString("category_name") +
                        ", Child Categories: " + rs.getInt("child_count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
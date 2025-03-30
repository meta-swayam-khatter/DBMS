package com.metacube.assignment;

import com.metacube.utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Assignment3 {
    public int deleteUnorderedProducts() {
        String query = "DELETE FROM products WHERE product_id NOT IN " +
                       "(SELECT DISTINCT product_id FROM order_items WHERE timestamp > NOW() - INTERVAL 1 YEAR)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            int deleted = stmt.executeUpdate();
            System.out.println(deleted + " products deleted.");
            return deleted;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
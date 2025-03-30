package com.metacube.assignment;

import com.metacube.utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Assignment2 {
    public void batchInsertImages(int productId, String[] imageUrls) {
        String query = "INSERT INTO images (product_id, image_url) VALUES (?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            for (String url : imageUrls) {
                stmt.setInt(1, productId);
                stmt.setString(2, url);
                stmt.addBatch();
            }

            int[] result = stmt.executeBatch();
            System.out.println(result.length + " images inserted successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
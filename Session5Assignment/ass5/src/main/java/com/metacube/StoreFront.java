package com.metacube;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StoreFront {
    private static final String URL = "jdbc:mysql://localhost:3306/StoreFront";
    private static final String USER = "root";
    private static final String PASSWORD = "root";

    // static {
    //     try {
    //         Class.forName("com.mysql.cj.jdbc.Driver");
    //     } catch (ClassNotFoundException e) {
    //         e.printStackTrace();
    //     }
    // }

    public List<Order> getShippedOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT o.order_id, o.user_id, o.shipping_address_id, o.number_of_items, o.price, o.timestamp FROM orders o JOIN order_items oi ON o.order_id = oi.order_id WHERE o.user_id = ? AND oi.status = 'shipped' ORDER BY o.timestamp";

        try (
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                orders.add(new Order(rs.getInt("o.order_id"), rs.getInt("o.user_id"), rs.getInt("o.shipping_address_id"), rs.getInt("o.number_of_items"), rs.getFloat("o.price")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public void insertProductImages(int productId, List<String> imageUrls) {
        String query = "INSERT INTO images (product_id, image_url) VALUES (?, ?)";
        
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            for (String url : imageUrls) {
                stmt.setInt(1, productId);
                stmt.setString(2, url);
                stmt.addBatch();
            }
            stmt.executeBatch();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int deleteOldProducts() {
        String query = "DELETE FROM products WHERE id NOT IN (SELECT DISTINCT product_id FROM orders WHERE timestamp >= DATE_SUB(NOW(), INTERVAL 1 YEAR))";
        int deletedRows = 0;
        
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(query)) {
            deletedRows = stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return deletedRows;
    }

    public List<Category> getTopCategoriesWithChildCount() {
        List<Category> categories = new ArrayList<>();
        String query = "SELECT c.category_name, COUNT(sc.id) AS child_count FROM categories c LEFT JOIN categories sc ON c.category_id = sc.parent_category_id WHERE c.parent_category_id IS NULL GROUP BY c.category_id ORDER BY c.category_name";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                categories.add(new Category(rs.getInt("category_id"), rs.getString("category_name"), rs.getInt("parent_category_id")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

}

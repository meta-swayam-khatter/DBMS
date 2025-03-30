package com.metacube.assignment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.metacube.models.Order;
import com.metacube.utils.DBConnection;

public class Assignment1 {
    public List<Order> getShippedOrdersByUser(int userId) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT o.order_id, o.timestamp, o.price " +
                       "FROM orders o " +
                       "JOIN order_items oi ON o.order_id = oi.order_id " +
                       "WHERE o.user_id = ? AND oi.status = 'shipped' " +
                       "ORDER BY o.timestamp ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                orders.add(new Order(
                        rs.getInt("order_id"),
                        rs.getTimestamp("timestamp"),
                        rs.getDouble("price")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
}



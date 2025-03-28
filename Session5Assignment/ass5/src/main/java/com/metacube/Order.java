package com.metacube;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

class Order {
    private int order_id;
    private int user_id;
    private int shipping_address_id;
    private int number_of_items;
    private float price;
    private Timestamp timestamp;

    Order(int order_id, int user_id, int shipping_address_id, int number_of_items, float price) {
        this.order_id = order_id;
        this.user_id = user_id;
        this.shipping_address_id = shipping_address_id;
        this.number_of_items = number_of_items;
        this.price = price;
        this.timestamp = Timestamp.valueOf(LocalDateTime.now());
    }

    public int getOrder_id() {
        return order_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public int getShipping_address_id() {
        return shipping_address_id;
    }

    public int getNumber_of_items() {
        return number_of_items;
    }

    public float getPrice() {
        return price;
    }

    public Timestamp getTimestamp() {
        return timestamp;
    }

    // expecting a single order
    public static Order toOrder(ResultSet resultSet) throws SQLException {
        Order order = new Order(
                resultSet.getInt("order_id"),
                resultSet.getInt("user_id"),
                resultSet.getInt("shipping_id"),
                resultSet.getInt("number_of_items"),
                resultSet.getFloat("price"));
        return order;
    }

    // expecting a order list
    public static List<Order> toOrderList(ResultSet resultSet) throws SQLException {
        List<Order> orderList = new ArrayList<>();
        while (resultSet.next()) {
            orderList.add(toOrder(resultSet));
        }
        return orderList;
    }
}

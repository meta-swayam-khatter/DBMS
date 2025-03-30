package com.metacube.models;

import java.sql.Timestamp;

public class Order {
    private int orderId;
    private Timestamp orderDate;
    private double orderTotal;

    public Order(int orderId, Timestamp orderDate, double orderTotal) {
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.orderTotal = orderTotal;
    }

    public int getOrderId() { return orderId; }
    public Timestamp getOrderDate() { return orderDate; }
    public double getOrderTotal() { return orderTotal; }

    @Override
    public String toString() {
        return "Order [id=" + orderId + ", Date=" + orderDate + ", Total=" + orderTotal + "]";
    }
}
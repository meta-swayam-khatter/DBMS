package com.metacube.main;

import com.metacube.assignment.*;

public class Main {
    public static void main(String[] args) {
        Assignment1 assignment1 = new Assignment1();
        System.out.println(assignment1.getShippedOrdersByUser(1));

        Assignment2 assignment2 = new Assignment2();
        assignment2.batchInsertImages(2, new String[]{"img1.jpg", "img2.jpg", "img3.jpg", "img4.jpg", "img5.jpg"});

        Assignment3 assignment3 = new Assignment3();
        assignment3.deleteUnorderedProducts();

        Assignment4 assignment4 = new Assignment4();
        assignment4.getParentCategoriesWithChildCount();
    }
}
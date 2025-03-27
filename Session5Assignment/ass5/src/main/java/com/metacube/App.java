package com.metacube;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Hello world!
 *
 */
public class App 
{
    public static void main( String[] args ) throws SQLException
    {
        String url = "jdbc:mysql://localhost:3306/StoreFront";
        String username= "root";
        String pass = "root";
        Connection connection = DriverManager.getConnection(url, username, pass);
        System.out.println("Connected to DataBase!");
        String query = "SELECT * FROM products";
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query);
        while (resultSet.next()) {
            System.out.println(resultSet.getString("product_name"));
        }
    }
}

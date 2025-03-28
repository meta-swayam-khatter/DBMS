package com.metacube;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Category {
    private int category_id;
    private String category_name;
    private int parent_category_id;
    
    public Category(int category_id, String category_name, int parent_category_id) {
        this.category_id = category_id;
        this.category_name = category_name;
        this.parent_category_id = parent_category_id;
    }

    public int getCategory_id() {
        return category_id;
    }

    public String getCategory_name() {
        return category_name;
    }

    public int getParent_category_id() {
        return parent_category_id;
    }

    // expecting a single category
    public static Category toCategory(ResultSet resultSet) throws SQLException {
        Category category = new Category(
                resultSet.getInt("category_id"),
                resultSet.getString("category_name"),
                resultSet.getInt("parent_category_id")
        );        
        return category;
    }

    // expecting a order list
    public static List<Category> toCategoryList(ResultSet resultSet) throws SQLException {
        List<Category> categoryList = new ArrayList<>();
        while (resultSet.next()) {
            categoryList.add(toCategory(resultSet));
        }
        return categoryList;
    }
}

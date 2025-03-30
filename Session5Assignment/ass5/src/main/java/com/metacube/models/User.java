package com.metacube.models;

public class User {
    private int userId;
    private String email;
    private String role;

    public User(int userId, String email, String role) {
        this.userId = userId;
        this.email = email;
        this.role = role;
    }

    public int getUserId() { return userId; }
    public String getEmail() { return email; }
    public String getRole() { return role; }

    @Override
    public String toString() {
        return "User [id=" + userId + ", email=" + email + ", role=" + role + "]";
    }
}
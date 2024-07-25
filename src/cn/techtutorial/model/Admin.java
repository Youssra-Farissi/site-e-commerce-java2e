package cn.techtutorial.model;

public class Admin {
    private String email;
    private String password;

    // Default constructor
    public Admin() {
    }

    // Parameterized constructor with email and password
    public Admin(String email, String password) {
        this.email = email;
        this.password = password;
    }

    // Getters and setters for email and password
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
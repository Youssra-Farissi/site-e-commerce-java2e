package cn.techtutorial.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import cn.techtutorial.model.Admin;

public class AdminDao {
    private Connection connection;

    public AdminDao(Connection connection) {
        this.connection = connection;
    }

    public boolean adminLogin(String email, String password) throws SQLException {
        try (PreparedStatement statement = connection.prepareStatement("SELECT * FROM admin WHERE email = ? AND password = ?")) {
            statement.setString(1, email);
            statement.setString(2, password);

            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next(); // Returns true if there is at least one row
            }
        }
    }
}

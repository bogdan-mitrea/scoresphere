package service;

import model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserService {

    public boolean registerUser(User user) {
        try (Connection connection = DatabaseConnection.initializeDatabase()) {
            String query = "INSERT INTO users (username, password, email, favoriteTeam) VALUES (?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, user.getUsername());
            statement.setString(2, user.getPassword());
            statement.setString(3, user.getEmail());
            statement.setString(4, user.getFavoriteTeam());
            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User loginUser(String username, String password) {
        try (Connection connection = DatabaseConnection.initializeDatabase()) {
            String query = "SELECT * FROM users WHERE Username = ? AND Password = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, username);
            statement.setString(2, password);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                User user = new User();
                user.setIdUser(resultSet.getInt("idUser"));
                user.setUsername(resultSet.getString("username"));
                user.setPassword(resultSet.getString("password"));
                user.setEmail(resultSet.getString("email"));
                user.setFavoriteTeam(resultSet.getString("favoriteTeam"));
                return user;
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}

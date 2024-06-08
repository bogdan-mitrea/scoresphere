package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/scoresphere";
    private static final String USER = "root"; // Replace with your database username
    private static final String PASSWORD = "Bm15092002#"; // Replace with your database password

    public static Connection initializeDatabase() throws SQLException, ClassNotFoundException {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the connection
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}

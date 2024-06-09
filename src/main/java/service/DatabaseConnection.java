package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    String error;
    Connection con;
    private static final String URL = "jdbc:mysql://localhost:3306/scoresphere?useSSL=false";
    private static final String USER = "root"; // Replace with your database username
    private static final String PASSWORD = "Bm15092002#"; // Replace with your database password

    public static Connection initializeDatabase() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}

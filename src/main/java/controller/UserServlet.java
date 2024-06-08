package controller;

import model.User;
import service.DatabaseConnection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/user")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 102831973239L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("register".equals(action)) {
            handleRegistration(request, response);
        } else if ("login".equals(action)) {
            handleLogin(request, response);
        }
    }

    private void handleRegistration(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String favoriteTeam = request.getParameter("favoriteTeam");

        User user = new User(username, password, email, favoriteTeam);
        boolean isRegistered = registerUser(user);

        if (isRegistered) {
            response.sendRedirect("success.jsp");
        } else {
            response.sendRedirect("error.jsp");
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = authenticateUser(username, password);

        if (user != null) {
            request.getSession().setAttribute("user", user);
            response.sendRedirect("welcome.jsp");
        } else {
            response.sendRedirect("login.jsp?error=true");
        }
    }

    private boolean registerUser(User user) {
        try (Connection connection = DatabaseConnection.initializeDatabase()) {
            String query = "INSERT INTO users (username, password, email, favoriteTeam) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getFavoriteTeam());
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    private User authenticateUser(String username, String password) {
        try (Connection connection = DatabaseConnection.initializeDatabase()) {
            String query = "SELECT * FROM users WHERE Username = ? AND Password = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setFavoriteTeam(rs.getString("favoriteTeam"));
                return user;
            } else {
                return null;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return null;
        }
    }
}

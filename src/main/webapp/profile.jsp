<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="service.DatabaseConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <link rel="stylesheet" type="text/css" href="styles/main.css">
</head>
<body>
<main>
    <div class="profile-container">
        <h2>Your Profile</h2>
        <%
            loggedInUser = (User) session.getAttribute("user");
            if (loggedInUser != null) {
                Connection connection = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    connection = DatabaseConnection.initializeDatabase();
                    String sql = "SELECT * FROM users WHERE username=?";
                    pstmt = connection.prepareStatement(sql);
                    pstmt.setString(1, loggedInUser.getUsername());
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        String username = rs.getString("username");
                        String email = rs.getString("email");
                        String favoriteTeam = rs.getString("favoriteTeam");
        %>
        <table class="profile-table">
            <tr>
                <td>Username:</td>
                <td><%= username %></td>
            </tr>
            <tr>
                <td>Email:</td>
                <td><%= email %></td>
            </tr>
            <tr>
                <td>Favorite Team:</td>
                <td><%= favoriteTeam %></td>
            </tr>
            <tr>
                <td>Password:</td>
                <td><a href="changePassword.jsp">Change Password</a></td>
            </tr>
        </table>
        <%
                    } else {
                        out.println("<p>User not found.</p>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                    if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
                }
            } else {
                out.println("<p>Please <a href='login.jsp'>login</a> to view your profile.</p>");
            }
        %>
    </div>
</main>
<footer>
    Mitrea Bogdan, Eftimie Albert - 432D
</footer>
</body>
</html>

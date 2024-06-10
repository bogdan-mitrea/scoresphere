<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="service.DatabaseConnection" %>
<%@ page import="model.User" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
    <link rel="stylesheet" type="text/css" href="styles/main.css">
</head>
<body>
<main>
    <div class="change-password-result">
        <h2>Change Password</h2>
        <%
            User loggedInUser = (User) session.getAttribute("user");
            if (loggedInUser != null) {
                String newPassword = request.getParameter("newPassword");
                String confirmPassword = request.getParameter("confirmPassword");

                if (newPassword.equals(confirmPassword)) {
                    Connection connection = null;
                    PreparedStatement pstmt = null;

                    try {
                        connection = DatabaseConnection.initializeDatabase();
                        String sql = "UPDATE users SET password=? WHERE username=?";
                        pstmt = connection.prepareStatement(sql);
                        pstmt.setString(1, newPassword);
                        pstmt.setString(2, loggedInUser.getUsername());

                        int rowsUpdated = pstmt.executeUpdate();
                        if (rowsUpdated > 0) {
                            out.println("<p>Password successfully changed.</p>");
                            session.invalidate();
                        } else {
                            out.println("<p>Error changing password. Please try again.</p>");
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.println("<p>Error changing password. Please try again.</p>");
                    } finally {
                        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                        if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
                    }
                } else {
                    out.println("<p>Passwords do not match. Please try again.</p>");
                }
            } else {
                out.println("<p>Please <a href='login.jsp'>login</a> to change your password.</p>");
            }
        %>
        <a href="profile.jsp" class="back-button">Back to Profile</a>
    </div>
</main>
<footer>
    Mitrea Bogdan, Eftimie Albert - 432D
</footer>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="service.DatabaseConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
    <link rel="stylesheet" type="text/css" href="styles/main.css">
</head>
<body>
<main>
    <div class="change-password-container">
        <h2>Change Password</h2>
        <%
            loggedInUser = (User) session.getAttribute("user");
            if (loggedInUser != null) {
        %>
        <form action="changePasswordProcess.jsp" method="post">
            <label for="newPassword">New Password:</label>
            <input type="password" id="newPassword" name="newPassword" required><br><br>
            <label for="confirmPassword">Confirm New Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required><br><br>
            <button type="submit">Change Password</button>
        </form>
        <%
            } else {
                out.println("<p>Please <a href='login.jsp'>login</a> to change your password.</p>");
            }
        %>
    </div>
</main>
<footer>
    Mitrea Bogdan, Eftimie Albert - 432D
</footer>
</body>
</html>

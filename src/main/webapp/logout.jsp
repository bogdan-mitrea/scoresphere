<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Logout</title>
    <link rel="stylesheet" type="text/css" href="styles/main.css">
</head>
<body>
<main>
    <div class="logout-container">
        <%
            session.invalidate();
        %>
        <h2>You have been logged out.</h2>
        <a href="index.jsp" class="home-button">Home</a>
    </div>
</main>
<footer>
    Mitrea Bogdan, Eftimie Albert - 432D
</footer>
</body>
</html>

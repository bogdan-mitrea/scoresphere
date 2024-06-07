<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="db.JavaBean, java.util.List, java.util.Map, java.util.HashMap" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #1e272e;
            color: #ecf0f1;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 20px;
        }

        .match-card {
            background-color: #2c3e50;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
            margin-bottom: 20px;
            padding: 20px;
        }

        .match-card h2 {
            font-size: 24px;
            margin-bottom: 10px;
        }

        .match-card p {
            font-size: 16px;
            margin-bottom: 5px;
        }

        .match-card .score {
            font-size: 18px;
            font-weight: bold;
        }

        .logout {
            text-align: center;
            margin-top: 20px;
        }

        .logout a {
            color: #3498db;
            text-decoration: none;
        }

        .logout a:hover {
            color: #2980b9;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Live Football Matches</h1>
    <%
        String loggedInUser = (String) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            response.sendRedirect("login.jsp");
        } else {
            JavaBean jb = (JavaBean) session.getAttribute("jb");
            if (jb == null) {
                jb = new JavaBean();
                session.setAttribute("jb", jb);
            }
            // Retrieve football matches data
            List<Map<String, String>> matches = jb.getFootballMatches();
            if (matches != null && !matches.isEmpty()) {
                for (Map<String, String> match : matches) {
                    String homeTeam = match.get("homeTeam");
                    String awayTeam = match.get("awayTeam");
                    String score = match.get("score");
    %>
    <div class="match-card">
        <h2><%= homeTeam %> vs <%= awayTeam %></h2>
        <p class="score"><%= score %></p>
    </div>
    <%
        }
    } else {
    %>
    <p>No matches available.</p>
    <%
            }
        }
    %>
    <div class="logout">
        <a href="logout.jsp">Logout</a>
    </div>
</div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Website</title>
    <link rel="stylesheet" type="text/css" href="styles/main.css">
    <style>
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            background-color: rgba(0, 0, 0, 0.5); /* Adjust opacity as needed */
        }

        .logo-container {
            display: flex;
            align-items: center;
        }

        .logo-container img {
            width: 150px; /* Adjust as needed */
            height: auto; /* Maintain aspect ratio */
        }

        .menu {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex;
        }

        .menu li {
            margin-right: 20px;
        }

        .menu li:last-child {
            margin-right: 0;
        }

        .menu li a {
            text-decoration: none;
            color: #fff;
            font-weight: bold;
            transition: color 0.3s;
        }

        .menu li a:hover {
            color: #ff6600;
        }

        .search-bar {
            display: flex;
            align-items: center;
        }

        .search-bar input[type="text"] {
            padding: 8px;
            border: none;
            border-radius: 5px;
            margin-right: 10px;
        }

        .search-bar button {
            padding: 8px 16px;
            border: none;
            border-radius: 5px;
            background-color: #ff6600;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .search-bar button:hover {
            background-color: #cc5200;
        }
        .logout1 {
            margin-right: 10px;
            position: fixed;
            top: 10px;
            right: 220px;
            z-index: 1000;
        }
        .logout1 a {
            color: #ffffff;
            text-decoration: none;
            margin-right: 10px;
        }
    </style>
</head>
<body>
<header>
    <div class="logo-container">
        <a href="dashboard.jsp"><img src="poze/logo.png" alt="ScoreSphere"></a>
    </div>
    <nav>
        <ul class="menu">
            <li><a href="#">Premier League</a></li>
            <li><a href="#">Serie A</a></li>
            <li><a href="#">LaLiga</a></li>
            <li><a href="#">Ligue 1</a></li>
            <li><a href="#">Bundesliga</a></li>
            <li><a href="#">Liga 1</a></li>
            <li><a href="#">Euro 2024</a></li>
        </ul>
    </nav>
    <div class="search-bar">
        <input type="text" placeholder="Search for teams...">
        <button type="submit">Search</button>
    </div>
    <div class="logout1">
        <%
            String loggedInUser = (String) session.getAttribute("username");
            if (loggedInUser == null) {
        %>
        <a href="login.jsp">Login</a> | <a href="register.jsp">Register</a>
        <%
        } else {
        %>
        <a href="login.jsp">Logout</a>
        <%
            }
        %>
    </div>
</header>
<main>

</main>
<footer>

</footer>
</body>
</html>

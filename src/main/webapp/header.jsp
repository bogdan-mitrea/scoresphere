<%@ page import="model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ScoreSphere</title>
    <link rel="stylesheet" type="text/css" href="styles/main.css">
    <style>
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .logo-container {
            display: flex;
            align-items: center;
        }

        .logo-container img {
            width: 150px;
            height: auto;
        }

        .menu {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex;
            color: #ffffff;
        }

        .menu li {
            margin-right: 10px;
        }

        .menu li:last-child {
            margin-right: 0;
        }
        .menu a {
            text-decoration: none;
            color: #fff;
            font-weight: bold;
            transition: color 0.3s;
            font-size: 18px;
        }

        .menu a:hover {
            color: #0c0f10;
        }

        .menu li a {
            text-decoration: none;
            color: #fff;
            font-weight: bold;
            transition: color 0.3s;
            font-size: 18px;
        }

        .menu li a:hover {
            color: #ff6600;
        }

        .search-bar {
            position: relative;
        }

        .search-bar input[type="text"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 5px;
            border: 1px solid #cccccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 14px;
        }

        .search-bar button {
            padding: 6px 12px;
            border: none;
            border-radius: 5px;
            background-color: #ff6600;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 14px;
            position: relative;
        }

        .search-bar button:hover {
            background-color: #cc5200;
        }
        .logout1 a {
            color: #ffffff;
            text-decoration: none;
            margin-right: 10px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function(){
            $("#favoriteTeam").keyup(function(){
                var term = $(this).val();
                if (term.length > 0) {
                    $.ajax({
                        url: 'getTeams',
                        method: 'GET',
                        data: {term: term},
                        success: function(response){
                            var dropdown = $("#teamDropdown");
                            dropdown.empty();
                            for (var i = 0; i < response.length; i++) {
                                dropdown.append('<li>' + response[i] + '</li>');
                            }
                            dropdown.show();
                        }
                    });
                } else {
                    $("#teamDropdown").hide();
                }
            });

            $("#teamDropdown").on('click', 'li', function(){
                $("#favoriteTeam").val($(this).text());
                $("#teamDropdown").hide();
            });
        });
    </script>
</head>
<body>
<header>
    <div class="logo-container">
        <a href="dashboard.jsp"><img src="poze/logo.png" alt="ScoreSphere"></a>
    </div>
    <nav>
        <ul class="menu">
            <li><a href="englandStandings.jsp">Premier League</a></li>
            <li><a href="italyStandings.jsp">Serie A</a></li>
            <li><a href="spainStandings.jsp">LaLiga</a></li>
            <li><a href="franceStandings.jsp">Ligue 1</a></li>
            <li><a href="germanyStandings.jsp">Bundesliga</a></li>
            <li><a href="romaniaStandings.jsp">Liga 1</a></li>
            <li><a href="euroStandings.jsp">Euro 2024</a></li>
            <%
                User loggedInUser = (User) session.getAttribute("user");
                if (loggedInUser == null) {
            %>
            <a href="login.jsp">Login</a> | <a href="register.jsp">Register</a>
            <%
            } else {
            %>
            <a href="profile.jsp">Profile</a> | <a href="logout.jsp">Logout</a>
            <%
                }
            %>
        </ul>
    </nav>
    <div class="search-bar">
        <input type="text" id="favoriteTeam" name="favoriteTeam" autocomplete="off" placeholder="Search for teams...">
        <ul id="teamDropdown" class="dropdown-content" style="display:none; color:#0c0f10;"></ul>
        <button type="submit">Search</button>
    </div>
</header>
<main>

</main>
<footer>

</footer>
</body>
</html>

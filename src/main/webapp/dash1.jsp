<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>ScoreSphere - Dashboard</title>
    <link rel="stylesheet" href="styles/main.css">
</head>
<body>
<header>
    <h1>ScoreSphere</h1>
    <nav>
        <a href="index.jsp">Home</a>
        <a href="teams.jsp">Teams</a>
        <a href="standings.jsp">Standings</a>
        <a href="profile.jsp">Profile</a>
        <a href="login.jsp">Login</a>
    </nav>
</header>
<main>
    <section id="recent-matches">
        <h2>Recent Matches</h2>
        <!-- Dynamic content for recent matches -->
    </section>
    <section id="upcoming-matches">
        <h2>Upcoming Matches</h2>
        <!-- Dynamic content for upcoming matches -->
    </section>
    <section id="favorite-teams">
        <h2>Favorite Teams</h2>
        <!-- Dynamic content for user's favorite teams -->
    </section>
</main>
<aside>
    <input type="text" id="search" placeholder="Search...">
    <ul id="quick-links">
        <li><a href="team.jsp?teamId=1">Team 1</a></li>
        <li><a href="team.jsp?teamId=2">Team 2</a></li>
        <li><a href="standings.jsp">Standings</a></li>
    </ul>
</aside>
</body>
</html>

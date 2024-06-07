<!DOCTYPE html>
<html>
<head>
    <title>Scores - ScoreSphere</title>
    <link rel="stylesheet" type="text/css" href="styles/main.css">
</head>
<body>
<h1>Football Scores</h1>
<table>
    <thead>
    <tr>
        <th>Match</th>
        <th>Home Score</th>
        <th>Away Score</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="score" items="${scores}">
        <tr>
            <td>${score.homeTeam}</td>
            <td>${score.awayTeam}</td>
            <td>${score.homeScore}</td>
            <td>${score.awayScore}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<p><a href="addScore.jsp">Add New Score</a></p>
<p><a href="index.jsp">Home</a></p>
</body>
</html>

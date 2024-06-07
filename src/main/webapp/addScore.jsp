<!DOCTYPE html>
<html>
<head>
    <title>Add Score - ScoreSphere</title>
    <link rel="stylesheet" type="text/css" href="styles/main.css">
</head>
<body>
<h1>Add Football Score</h1>
<form action="score" method="post">
    <label for="homeTeam">Match:</label>
    <input type="text" id="homeTeam" name="homeTeam" required><br>
    <label for="awayTeam">Match:</label>
    <input type="text" id="awayTeam" name="awayTeam" required><br>
    <label for="homeScore">Home Score:</label>
    <input type="number" id="homeScore" name="homeScore" required><br>
    <label for="awayScore">Away Score:</label>
    <input type="number" id="awayScore" name="awayScore" required><br>
    <button type="submit">Add Score</button>
</form>
<p><a href="scores.jsp">View Scores</a></p>
</body>
</html>

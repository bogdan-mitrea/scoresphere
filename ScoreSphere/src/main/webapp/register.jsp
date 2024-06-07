<!DOCTYPE html>
<html>
<head>
    <title>Register - ScoreSphere</title>
    <link rel="stylesheet" type="text/css" href="styles/main.css">
</head>
<body>
<h1>Register</h1>
<form action="user" method="post">
    <input type="hidden" name="action" value="register">
    <label for="username">Username:</label>
    <input type="text" id="username" name="username" required><br>
    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required><br>
    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required><br>
    <label for="favoriteTeam">Favorite Team:</label>
    <input type="text" id="favoriteTeam" name="favoriteTeam"><br>
    <button type="submit">Register</button>
</form>
<p><a href="index.jsp">Home</a></p>
</body>
</html>

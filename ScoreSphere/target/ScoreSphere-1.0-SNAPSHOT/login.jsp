<!DOCTYPE html>
<html>
<head>
    <title>Login - ScoreSphere</title>
    <link rel="stylesheet" type="text/css" href="styles/main.css">
</head>
<body>
<h1>Login</h1>
<form action="user" method="post">
    <input type="hidden" name="action" value="login">
    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required><br>
    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required><br>
    <button type="submit">Login</button>
</form>
<p><a href="index.jsp">Home</a></p>
</body>
</html>

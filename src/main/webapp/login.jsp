<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - ScoreSphere</title>
    <link rel="stylesheet" type="text/css" href="styles/main.css">
</head>
<body>
<header>
    <h1>ScoreSphere</h1>
</header>
<main>
    <section class="login-container">
        <h2>Login</h2>
        <form action="user" method="post">
            <input type="hidden" name="action" value="login">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit" class="btn">Login</button>
        </form>
        <p><a href="index.jsp">Home</a></p>
    </section>
</main>
<footer>
    Mitrea Bogdan, Eftimie Albert - 432D
</footer>
</body>
</html>

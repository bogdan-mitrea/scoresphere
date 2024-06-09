<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - ScoreSphere</title>
    <link rel="stylesheet" type="text/css" href="styles/main.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
    <h1>ScoreSphere</h1>
</header>
<main>
    <section class="login-container">
        <h2>Register</h2>
        <form action="user" method="post">
            <input type="hidden" name="action" value="register">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" placeholder="Choose a new username" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" placeholder="Enter your email address" required>
            </div>
            <div class="form-group">
                <label for="favoriteTeam">Favorite Team:</label>
                <div class="custom-dropdown">
                    <input type="text" id="favoriteTeam" name="favoriteTeam" autocomplete="off" placeholder="Select your favorite team">
                    <ul id="teamDropdown" class="dropdown-content" style="display:none;"></ul>
                </div>
            </div>
            <button type="submit" class="btn">Register</button>
        </form>
        <p><a href="index.jsp">Home</a></p>
    </section>
</main>
<footer>
    Mitrea Bogdan, Eftimie Albert - 432D
</footer>
</body>
</html>

<!DOCTYPE html>
<html>
<head>
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
                                dropdown.append('<option value="' + response[i] + '">' + response[i] + '</option>');
                            }
                            dropdown.show();
                        }
                    });
                } else {
                    $("#teamDropdown").hide();
                }
            });

            $("#teamDropdown").on('change', function(){
                $("#favoriteTeam").val(this.value);
                $(this).hide();
            });
        });
    </script>
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
    <input type="text" id="favoriteTeam" name="favoriteTeam" autocomplete="off">
    <select id="teamDropdown" size="5" style="display:none;"></select><br>
    <button type="submit">Register</button>
</form>
<p><a href="index.jsp">Home</a></p>
</body>
</html>

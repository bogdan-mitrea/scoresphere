<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="DAO.FootballMatchDAO" %>
<%@ include file="header.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - ScoreSphere</title>
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
<main>
    <div class="container">
        <div class="matches">
        <h2>Live Football Matches</h2>
        <%
            List<Map<String, String>> matches = FootballMatchDAO.getFootballMatchesFromDatabase();
            if (matches != null && !matches.isEmpty()) {
                for (Map<String, String> match : matches) {
                    String homeTeam = match.get("homeTeam");
                    String awayTeam = match.get("awayTeam");
                    String homeScore = match.get("homeScore");
                    String awayScore = match.get("awayScore");
        %>
        <div class="match-card">
            <h3><%= homeTeam %> vs <%= awayTeam %></h3>
            <p class="score"><%= homeScore %> - <%= awayScore %></p>
        </div>
        <%
            }
        } else {
        %>
        <p>No matches available.</p>
        <%
            }
        %>
        </div>
    </div>
</main>
<footer>
    Mitrea Bogdan, Eftimie Albert - 432D
</footer>
</body>
</html>

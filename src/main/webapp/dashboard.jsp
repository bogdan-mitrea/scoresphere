<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="DAO.FootballMatchDAO" %>
<%@ include file="header.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
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
<div class="container">
    <h1>Live Football Matches</h1>
    <%
        String loggedInUser = (String) session.getAttribute("loggedInUser");
        List<Map<String, String>> matches = FootballMatchDAO.getFootballMatchesFromDatabase();
        if (loggedInUser == null) {
            if (matches != null && !matches.isEmpty()) {
                for (Map<String, String> match : matches) {
                    String homeTeam = match.get("homeTeam");
                    String awayTeam = match.get("awayTeam");
                    String homeScore = match.get("homeScore");
                    String awayScore = match.get("awayScore");
                    %>
                    <div class="match-card">
        <h2><%= homeTeam %> vs <%= awayTeam %></h2>
    <p class="score"><%= homeScore %> - <%= awayScore %></p>
</div>
<%
    }
        }   else {
%>
    <p>No matches available.</p>
    <%
        }
    %>
    <p>You are a guest.</p>
    <div class="logout">
        <a href="login.jsp">Login</a>
    </div>
    <%
        }   else {
            if (matches != null && !matches.isEmpty()) {
                for (Map<String, String> match : matches) {
                    String homeTeam = match.get("homeTeam");
                    String awayTeam = match.get("awayTeam");
                    String homeScore = match.get("homeScore");
                    String awayScore = match.get("awayScore");
    %>
    <div class="match-card">
        <h2><%= homeTeam %> vs <%= awayTeam %></h2>
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
            <div class="logout">
        <a href="login.jsp">Logout</a>
    </div>
    <%
        }
    %>

</div>
</body>
</html>

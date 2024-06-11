<%@ page import="DAO.FootballMatchDAO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="service.DatabaseConnection" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
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

            $('.team-name').click(function(){
                var idTeam = $(this).closest('.team-name').data('idTeam');
                $.ajax({
                    url: 'TeamProfileServlet?teamId=' + idTeam,
                    method: 'GET',
                    data: { idTeam: idTeam },
                    success: function(data) {
                        var team = JSON.parse(data);
                        $('#details-content').html(`
                            <strong>Team Name:</strong> ${team.teamName}<br>
                            <strong>Nationality:</strong> ${team.nationality}<br>
                            <strong>League:</strong> ${team.league}<br>
                            <strong>Team Quality:</strong> ${team.teamQuality}<br>
                            <strong>Matches Played:</strong> ${team.matchesPlayed}<br>
                            <strong>Points:</strong> ${team.points}
                        `);
                    },
                    error: function() {
                        $('#details-content').html('Error fetching team details.');
                    }
                });
            });
        });
    </script>
</head>
<body>
<main>
    <div class="dashboard-container">
        <div class="matches">
            <h2>Live Football Matches</h2>
                <%
                Connection connection = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    connection = DatabaseConnection.initializeDatabase();
                    stmt = connection.createStatement();
                    String sql = "SELECT homeTeam, awayTeam, matchDate, matchTime, homeScore, awayScore, isLive FROM scores ORDER BY matchDate , matchTime ";
                    rs = stmt.executeQuery(sql);

                    List<Map<String, Object>> liveMatches = new ArrayList<>();
                    List<Map<String, Object>> pastMatches = new ArrayList<>();
                    List<Map<String, Object>> upcomingMatches = new ArrayList<>();

                    Date now = new Date();

                    while (rs.next()) {
                        Map<String, Object> match = new HashMap<>();
                        match.put("homeTeam", rs.getString("homeTeam"));
                        match.put("awayTeam", rs.getString("awayTeam"));
                        match.put("matchDate", rs.getString("matchDate"));
                        match.put("matchTime", rs.getString("matchTime"));
                        match.put("homeScore", rs.getString("homeScore"));
                        match.put("awayScore", rs.getString("awayScore"));
                        match.put("isLive", rs.getInt("isLive"));

                        String matchDate = rs.getString("matchDate");
                        String matchTime = rs.getString("matchTime");
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Date matchDateTime = sdf.parse(matchDate + " " + matchTime);

                        if (rs.getInt("isLive") == 1) {
                            liveMatches.add(match);
                        } else if (matchDateTime.before(now)) {
                            pastMatches.add(match);
                        } else {
                            upcomingMatches.add(match);
                        }
                    }

                    // Display Live Matches
                    if (liveMatches.isEmpty()) {
                        out.println("<p>No live matches available.</p>");
                    } else {
            %>
            <div class="match-section">
                <h3>Live Matches</h3>
                <%
                    Map<String, List<Map<String, Object>>> matchesByDate = new LinkedHashMap<>();
                    for (Map<String, Object> match : liveMatches) {
                        String matchDate = (String) match.get("matchDate");
                        matchesByDate.putIfAbsent(matchDate, new ArrayList<>());
                        matchesByDate.get(matchDate).add(match);
                    }

                    for (Map.Entry<String, List<Map<String, Object>>> entry : matchesByDate.entrySet()) {
                        String matchDate = entry.getKey();
                        List<Map<String, Object>> dailyMatches = entry.getValue();
                        String[] dateParts = matchDate.split("-");
                        String formattedDate = dateParts[2] + "/" + dateParts[1] + "/" + dateParts[0];

                        out.println("<div class='match-day'>");
                        out.println("<h4>" + formattedDate + "</h4>");

                        for (Map<String, Object> match : dailyMatches) {
                            String homeTeam = (String) match.get("homeTeam");
                            String awayTeam = (String) match.get("awayTeam");
                            String homeScore = (String) match.get("homeScore");
                            String awayScore = (String) match.get("awayScore");
                            String matchTime = (String) match.get("matchTime");
                            int isLive = (int) match.get("isLive");

                            homeScore = (homeScore != null) ? homeScore : "";
                            awayScore = (awayScore != null) ? awayScore : "";

                            out.println("<div class='match-card'>");
                            out.println("<h3><span class='team-name'>" + homeTeam + "</span> " + homeScore + " - " + awayScore + " <span class='team-name'>" + awayTeam + "</span>");
                            if (isLive == 1) {
                                out.println("<span class='live-indicator'>•</span>");
                            }
                            out.println("</h3>");
                            String[] timeParts = matchTime.split(":");
                            String formattedTime = timeParts[0] + ":" + timeParts[1];
                            out.println("<p class='match-time'>" + formattedTime + "</p>");
                            out.println("</div>");
                            out.println("<hr class='match-separator'>");
                        }
                        out.println("</div>");
                    }
                %>
            </div>
                <%
                }

                // Display Past Matches
                out.println("<h3>Past Matches</h3>");
                if (pastMatches.isEmpty()) {
                    out.println("<p>No past matches available.</p>");
                } else {
            %>
            <div class="match-section">
                <%
                    Map<String, List<Map<String, Object>>> matchesByDate = new LinkedHashMap<>();
                    for (Map<String, Object> match : pastMatches) {
                        String matchDate = (String) match.get("matchDate");
                        matchesByDate.putIfAbsent(matchDate, new ArrayList<>());
                        matchesByDate.get(matchDate).add(match);
                    }

                    for (Map.Entry<String, List<Map<String, Object>>> entry : matchesByDate.entrySet()) {
                        String matchDate = entry.getKey();
                        List<Map<String, Object>> dailyMatches = entry.getValue();
                        String[] dateParts = matchDate.split("-");
                        String formattedDate = dateParts[2] + "/" + dateParts[1] + "/" + dateParts[0];

                        out.println("<div class='match-day'>");
                        out.println("<h4>" + formattedDate + "</h4>");

                        for (Map<String, Object> match : dailyMatches) {
                            String homeTeam = (String) match.get("homeTeam");
                            String awayTeam = (String) match.get("awayTeam");
                            String homeScore = (String) match.get("homeScore");
                            String awayScore = (String) match.get("awayScore");
                            String matchTime = (String) match.get("matchTime");

                            homeScore = (homeScore != null) ? homeScore : "";
                            awayScore = (awayScore != null) ? awayScore : "";

                            out.println("<div class='match-card'>");
                            out.println("<h3><span class='team-name'>" + homeTeam + "</span> " + homeScore + " - " + awayScore + " <span class='team-name'>" + awayTeam + "</span></h3>");
                            String[] timeParts = matchTime.split(":");
                            String formattedTime = timeParts[0] + ":" + timeParts[1];
                            out.println("<p class='match-time'>" + formattedTime + "</p>");
                            out.println("</div>");
                            out.println("<hr class='match-separator'>");
                        }
                        out.println("</div>");
                    }
                %>
            </div>
                <%
                }

                // Display Upcoming Matches
                out.println("<h3>Upcoming Matches</h3>");
                if (upcomingMatches.isEmpty()) {
                    out.println("<p>No upcoming matches available.</p>");
                } else {
            %>
            <div class="match-section">
<%
                Map<String, List<Map<String, Object>>> matchesByDate = new LinkedHashMap<>();
                for (Map<String, Object> match : upcomingMatches) {
                    String matchDate = (String) match.get("matchDate");
                    matchesByDate.putIfAbsent(matchDate, new ArrayList<>());
                    matchesByDate.get(matchDate).add(match);
                }

                for (Map.Entry<String, List<Map<String, Object>>> entry : matchesByDate.entrySet()) {
                    String matchDate = entry.getKey();
                    List<Map<String, Object>> dailyMatches = entry.getValue();
                    String[] dateParts = matchDate.split("-");
                    String formattedDate = dateParts[2] + "/" + dateParts[1] + "/" + dateParts[0];

                    out.println("<div class='match-day'>");
                    out.println("<h4>" + formattedDate + "</h4>");

                    for (Map<String, Object> match : dailyMatches) {
                        String homeTeam = (String) match.get("homeTeam");
                        String awayTeam = (String) match.get("awayTeam");
                        String homeScore = (String) match.get("homeScore");
                        String awayScore = (String) match.get("awayScore");
                        String matchTime = (String) match.get("matchTime");

                        homeScore = (homeScore != null) ? homeScore : "";
                        awayScore = (awayScore != null) ? awayScore : "";

                        out.println("<div class='match-card'>");
                        out.println("<h3><span class='team-name'>" + homeTeam + "</span> " + homeScore + " - " + awayScore + " <span class='team-name'>" + awayTeam + "</span></h3>");
                        String[] timeParts = matchTime.split(":");
                        String formattedTime = timeParts[0] + ":" + timeParts[1];
                        out.println("<p class='match-time'>" + formattedTime + "</p>");
                        out.println("</div>");
                        out.println("<hr class='match-separator'>");
                    }
                    out.println("</div>");
                }
%>
            </div>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                    if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                    if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
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

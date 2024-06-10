<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="service.DatabaseConnection" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Premier League Standings</title>
    <link rel="stylesheet" type="text/css" href="styles/main.css">
    <style>
        header {
            text-align: center;
            background-color: #ff6600;
            width: 100%;
            padding: 10px 0; /* Reduced padding */
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        main {
            justify-content: flex-end;
        }
        header h1 {
            margin: 0;
            font-size: 2em; /* Reduced font size */
            color: #ffffff;
        }
    </style>
</head>
<body>
<main>
    <div class="m-container">
        <h2> </h2>
        <h2>Premier League Standings</h2>
        <div class="standings-and-scores">
            <div class="standings">
                <table class="standings-table">
                    <thead>
                    <tr>
                        <th>Rank</th>
                        <th>Team Name</th>
                        <th>Matches Played</th>
                        <th>Points</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        Connection connection = null;
                        Statement stmt = null;
                        ResultSet rs = null;
                        List<Map<String, Object>> teams = new ArrayList<>();

                        try {
                            connection = DatabaseConnection.initializeDatabase();
                            stmt = connection.createStatement();
                            String sql = "SELECT teamName, matchesPlayed, points FROM teams WHERE nationality='England' ORDER BY points DESC";
                            rs = stmt.executeQuery(sql);

                            while (rs.next()) {
                                Map<String, Object> team = new HashMap<>();
                                team.put("teamName", rs.getString("teamName"));
                                team.put("matchesPlayed", rs.getInt("matchesPlayed"));
                                team.put("points", rs.getInt("points"));
                                teams.add(team);
                            }

                            int rank = 1;
                            for (Map<String, Object> team : teams) {
                                String rowClass = "";
                                if (rank <= 4) {
                                    rowClass = "top-four";
                                } else if (rank <= 6) {
                                    rowClass = "fifth-sixth";
                                } else if (rank == 7) {
                                    rowClass = "seventh";
                                } else if (rank >= 18) {
                                    rowClass = "bottom-three";
                                }
                    %>
                    <tr class="<%= rowClass %>">
                        <td><%= rank++ %></td>
                        <td><%= team.get("teamName") %></td>
                        <td><%= team.get("matchesPlayed") %></td>
                        <td><%= team.get("points") %></td>
                    </tr>
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
                    </tbody>
                </table>
            </div>
            <div class="matches">
                <h3>Live Matches</h3>
                <%
                    try {
                        connection = DatabaseConnection.initializeDatabase();
                        stmt = connection.createStatement();
                        String sql = "SELECT s.homeTeam, s.awayTeam, s.matchDate, s.matchTime, s.homeScore, s.awayScore, s.isLive " +
                                "FROM scores s " +
                                "JOIN teams t1 ON s.homeTeam = t1.teamName " +
                                "JOIN teams t2 ON s.awayTeam = t2.teamName " +
                                "WHERE t1.nationality = 'England' AND t2.nationality = 'England' " +
                                "ORDER BY s.matchDate , s.matchTime ";
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
                            out.println("<hr class='match-separator'>");
                            out.println("<hr class='match-separator'>");
                        } else {
                %>
                <div class="match-day">
                    <%
                        Map<String, List<Map<String, Object>>> matchesByDate = new LinkedHashMap<>();
                        SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");

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
                                out.println("<p class='match-time'>" + matchTime + "</p>");
                                out.println("</div>");
                                out.println("<hr class='match-separator'>");
                            }
                            out.println("</div>");
                        }
                        out.println("<hr class='match-separator'>");
                    %>
                </div>
                <%
                    }

                    // Display Past Matches
                    out.println("<h3>Past Matches</h3>");
                    if (pastMatches.isEmpty()) {
                        out.println("<p>No past matches available.</p>");
                        out.println("<hr class='match-separator'>");
                        out.println("<hr class='match-separator'>");
                    } else {
                %>
                <div class="match-day">
                    <%
                        Map<String, List<Map<String, Object>>> matchesByDate = new LinkedHashMap<>();
                        matchesByDate.clear();

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
                                out.println("<p class='match-time'>" + matchTime + "</p>");
                                out.println("</div>");
                                out.println("<hr class='match-separator'>");
                            }
                            out.println("</div>");
                        }
                        out.println("<hr class='match-separator'>");
                    %>
                </div>
                <%
                    }

                    // Display Upcoming Matches
                    out.println("<h3>Upcoming Matches</h3>");
                    if (upcomingMatches.isEmpty()) {
                        out.println("<p>No upcoming matches available.</p>");
                        out.println("<hr class='match-separator'>");
                        out.println("<hr class='match-separator'>");
                    } else {
                %>
                <div class="match-day">
                    <%
                        Map<String, List<Map<String, Object>>> matchesByDate = new LinkedHashMap<>();
                        matchesByDate.clear();

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
                                out.println("<p class='match-time'>" + matchTime + "</p>");
                                out.println("</div>");
                                out.println("<hr class='match-separator'>");
                            }
                            out.println("</div>");
                        }
                        out.println("<hr class='match-separator'>");
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
    </div>
</main>
<footer>
    Mitrea Bogdan, Eftimie Albert - 432D
</footer>
</body>
</html>
package DAO;

import service.DatabaseConnection;

import java.awt.dnd.DropTarget;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FootballMatchDAO {

    public static List<Map<String, String>> getFootballMatchesFromDatabase() {
        List<Map<String, String>> matches = new ArrayList<>();
        try (Connection conn = DatabaseConnection.initializeDatabase();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT homeTeam, awayTeam, homeScore, awayScore FROM scores")) {
            while (rs.next()) {
                Map<String, String> match = new HashMap<>();
                match.put("homeTeam", rs.getString("homeTeam"));
                match.put("awayTeam", rs.getString("awayTeam"));
                match.put("homeScore", rs.getString("homeScore"));
                match.put("awayScore", rs.getString("awayScore"));
                matches.add(match);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions appropriately, e.g., log the error, return an empty list, etc.
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return matches;
    }
}

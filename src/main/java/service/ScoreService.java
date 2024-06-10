package service;

import model.Score;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ScoreService {

    public List<Score> getScores() {
        List<Score> scores = new ArrayList<>();
        try (Connection connection = DatabaseConnection.initializeDatabase()) {
            String query = "SELECT * FROM scores";
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Score score = new Score();
                score.setIdScore(resultSet.getInt("idScore"));
                score.setHomeTeam(resultSet.getString("homeTeam"));
                score.setAwayTeam(resultSet.getString("awayTeam"));
                score.setHomeScore(resultSet.getInt("homeScore"));
                score.setAwayScore(resultSet.getInt("awayScore"));
                score.setMatchDate(LocalDate.parse(resultSet.getString("matchDate")));
                score.setMatchTime(resultSet.getTime("matchTime").toLocalTime());
                scores.add(score);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return scores;
    }

    public boolean addScore(Score score) {
        try (Connection connection = DatabaseConnection.initializeDatabase()) {
            String query = "INSERT INTO scores (homeTeam, awayTeam, homeScore, awayScore, matchDate, matchTime, isLive) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, score.getHomeTeam());
            statement.setString(2, score.getAwayTeam());
            statement.setInt(3, score.getHomeScore());
            statement.setInt(4, score.getAwayScore());
            statement.setDate(5, Date.valueOf(score.getMatchDate()));
            statement.setTime(6, Time.valueOf(score.getMatchTime()));
            statement.setBoolean(7, score.getIsLive());
            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}

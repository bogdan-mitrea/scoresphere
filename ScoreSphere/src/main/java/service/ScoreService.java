package service;

import model.Score;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ScoreService {

    public boolean addScore(Score score) {
        try (Connection connection = DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO scores (home_team, away_team, home_score, away_score) VALUES (?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, score.getHomeTeam());
            statement.setString(2, score.getAwayTeam());
            statement.setInt(3, score.getHomeScore());
            statement.setInt(4, score.getAwayScore());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Score> getScores() {
        List<Score> scores = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getConnection()) {
            String sql = "SELECT * FROM scores";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Score score = new Score();
                score.setHomeTeam(resultSet.getString("home_team"));
                score.setAwayTeam(resultSet.getString("away_team"));
                score.setHomeScore(resultSet.getInt("home_score"));
                score.setAwayScore(resultSet.getInt("away_score"));
                scores.add(score);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return scores;
    }
}

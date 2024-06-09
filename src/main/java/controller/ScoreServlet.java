package controller;

import model.Score;
import service.ScoreService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;


public class ScoreServlet extends HttpServlet {
    private ScoreService scoreService = new ScoreService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String homeTeam = request.getParameter("homeTeam");
        String awayTeam = request.getParameter("awayTeam");
        int homeScore = Integer.parseInt(request.getParameter("homeScore"));
        int awayScore = Integer.parseInt(request.getParameter("awayScore"));
        LocalDate matchDate = LocalDate.parse(request.getParameter("matchDate"));
        LocalTime matchTime = LocalTime.parse(request.getParameter("matchTime"));
        boolean isLive = Boolean.parseBoolean(request.getParameter("isLive"));

        Score score = new Score();
        score.setHomeTeam(homeTeam);
        score.setAwayTeam(awayTeam);
        score.setHomeScore(homeScore);
        score.setAwayScore(awayScore);
        score.setMatchDate(matchDate);
        score.setMatchTime(matchTime);
        score.setIsLive(isLive);

        if (scoreService.addScore(score)) {
            response.sendRedirect("scores.jsp");
        } else {
            response.sendRedirect("addScore.jsp?error=true");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Score> scores = scoreService.getScores();
        request.setAttribute("scores", scores);
        request.getRequestDispatcher("scores.jsp").forward(request, response);
    }
}

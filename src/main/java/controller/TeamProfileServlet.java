package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.json.JSONObject;

import model.Team;
import service.DatabaseConnection;

@WebServlet("/TeamProfileServlet")
public class TeamProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idTeam = Integer.parseInt(request.getParameter("idTeam"));
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        PreparedStatement pstmt = null;
        ResultSet rs = null;
        JSONObject team = new JSONObject();

        try {
            Connection connection = DatabaseConnection.initializeDatabase();
            String sql = "SELECT * FROM teams WHERE idTeam = ?";
            pstmt = connection.prepareStatement(sql);
            pstmt.setInt(1, idTeam);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                team.put("teamName", rs.getString("teamName"));
                team.put("nationality", rs.getString("nationality"));
                team.put("teamQuality", rs.getString("teamQuality"));
                team.put("matchesPlayed", rs.getString("matchesPlayed"));
                team.put("points", rs.getString("points"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        out.print(team.toString());
        out.flush();
    }
}

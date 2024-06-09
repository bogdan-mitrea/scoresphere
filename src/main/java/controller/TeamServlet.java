package controller;

import service.DatabaseConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class TeamServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String term = request.getParameter("term");
        List<String> teams = getTeams(term);

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.println("[");
        for (int i = 0; i < teams.size(); i++) {
            out.println("\"" + teams.get(i) + "\"");
            if (i < teams.size() - 1) {
                out.println(",");
            }
        }
        out.println("]");
        out.close();
    }

    private List<String> getTeams(String term) {
        List<String> teams = new ArrayList<>();
        try {
            Connection connection = DatabaseConnection.initializeDatabase();
            String query = "SELECT TeamName FROM teams WHERE TeamName LIKE ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, term + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                teams.add(rs.getString("TeamName"));
            }
            rs.close();
            ps.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return teams;
    }
}

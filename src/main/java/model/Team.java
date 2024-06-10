package model;

public class Team {
    private int idTeam;
    private String teamName;
    private String nationality;
    private String league;
    private int teamQuality;
    private int matchesPlayed;
    private int points;
    private String group;

    public Team() {}

    public int getIdTeam() {
        return idTeam;
    }
    public void setIdTeam(int idTeam) {
        this.idTeam = idTeam;
    }
    public String getTeamName() {
        return teamName;
    }
    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }
    public String getNationality() {
        return nationality;
    }
    public void setNationality(String nationality) {
        this.nationality = nationality;
    }
    public String getLeague() {
        return league;
    }
    public void setLeague(String league) {
        this.league = league;
    }
    public int getTeamQuality() {
        return teamQuality;
    }
    public void setTeamQuality(int teamQuality) {
        this.teamQuality = teamQuality;
    }
    public int getMatchesPlayed() {
        return matchesPlayed;
    }
    public void setMatchesPlayed(int matchesPlayed) {
        this.matchesPlayed = matchesPlayed;
    }
    public int getPoints() {
        return points;
    }
    public void setPoints(int points) {
        this.points = points;
    }
    public String getGroup() {
        return group;
    }
    public void setGroup(String group) {
        this.group = group;
    }
}

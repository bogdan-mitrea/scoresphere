package model;

public class User {
    private int idUser;
    private String username;
    private String password;
    private String email;
    private String favoriteTeam;

    public User() {}

    public User(String username, String password, String email, String favoriteTeam) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.favoriteTeam = favoriteTeam;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFavoriteTeam() {
        return favoriteTeam;
    }

    public void setFavoriteTeam(String favoriteTeam) {
        this.favoriteTeam = favoriteTeam;
    }
}

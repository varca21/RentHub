package it.renthub.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBSource {
    private String ip;
    private String dbName;
    private String username;
    private String password;
    private String porta;

    public DBSource(String ip, String porta, String dbName, String user, String password) {
        this.ip = ip;
        this.dbName = dbName;
        this.username = user;
        this.password = password;
        this.porta=porta;
    }

    public Connection getConnection() throws SQLException {
        Connection connection = DriverManager.getConnection("jdbc:postgresql://" + ip + ":" + porta + "/" + dbName, username, password);
        return connection;
    }

}

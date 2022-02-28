package it.renthub.model;

import it.renthub.model.dao.UtenteDao;
import it.renthub.model.dao.jdbc.UtenteDaoJdbc;

import javax.sql.DataSource;

public class DBManager {

    private static DBManager instance = null;
    static DBSource dataSource;

    static {
        try {
            Class.forName("org.postgresql.Driver");
            //TODO prendere dati da file
            dataSource = new DBSource("jdbc:postgresql://localhost:5432/RentHub_db", "postgres", "admin");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Problema di connessione al database.");
        }
    }

    public static DBManager getInstance() {
        if (instance == null)
            instance = new DBManager();

        return instance;
    }

    private DBManager() {
    }

    public static DBSource getDataSource() {
        return dataSource;
    }

    public UtenteDao getUtenteDao() {
        return new UtenteDaoJdbc(dataSource);
    }

}


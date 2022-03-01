package it.renthub.model;

import it.renthub.model.dao.UtenteDao;
import it.renthub.model.dao.jdbc.UtenteDaoJdbc;

public class DBManager {

    private static DBManager instance = null;
    static DBSource dataSource;

    static {
        try {
            Class.forName("org.postgresql.Driver");
            dataSource = new DBSource(Config.IP, Config.PORTA, Config.DBNAME, Config.USER, Config.PASSWORD);
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


package it.renthub.model.dao.jdbc;

import it.renthub.Logger;
import it.renthub.model.DBManager;
import it.renthub.model.DBSource;
import it.renthub.model.bean.Annuncio;
import it.renthub.model.bean.Recensione;
import it.renthub.model.bean.Utente;
import it.renthub.model.dao.RecensioneDao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RecensioneDaoJdbc implements RecensioneDao {
    private DBSource dbSource;

    public RecensioneDaoJdbc(DBSource dbSource) {
        this.dbSource = dbSource;
    }

    @Override
    public void save(Recensione r) {
        try {
            Connection conn = dbSource.getConnection();
            String query = "INSERT INTO recensione VALUES(?,?,?,?)";
            PreparedStatement st = conn.prepareStatement(query);

            st.setString(1, r.getUtente().getIdUtente());
            st.setInt(2, r.getAnnuncio().getIdAnnuncio());
            st.setString(3, r.getTitolo());
            st.setString(4, r.getDescrizione());
            st.executeUpdate();
        } catch (SQLException e) {
            Logger.LOG("Problema nell'inserimento della recensione " + r.getUtente().getIdUtente() + " " + r.getAnnuncio().getIdAnnuncio() + "\n" + e.toString());
        }
    }

    @Override
    public List<Recensione> findByUtente(Utente u) {
        List<Recensione> recensioni = new ArrayList<>();
        try {
            Connection conn = dbSource.getConnection();
            String query = "SELECT * FROM recensione where id_utente=?";
            PreparedStatement st = conn.prepareStatement(query);
            st.setString(1, u.getIdUtente());
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Recensione recensione = new Recensione();
                Annuncio a = DBManager.getInstance().getAnnuncioDao().findById(rs.getInt("id_annuncio"));
                String titolo = rs.getString("titolo");
                String descrizione = rs.getString("descrizione");

                recensione.setUtente(u);
                recensione.setAnnuncio(a);
                recensione.setTitolo(titolo);
                recensione.setDescrizione(descrizione);

                recensioni.add(recensione);
            }
        } catch (SQLException e) {
            Logger.LOG("Errore nella ricerca delle recensioni per l'utente " + u.getIdUtente() + "\n" + e.toString());
        }
        return recensioni;
    }

    @Override
    public List<Recensione> findByAnnuncio(Annuncio annuncio) {
        List<Recensione> recensioni = new ArrayList<>();
        try {
            Connection conn = dbSource.getConnection();
            String query = "SELECT * FROM recensione where id_annuncio=?";
            PreparedStatement st = conn.prepareStatement(query);
            st.setInt(1, annuncio.getIdAnnuncio());
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Recensione recensione = new Recensione();
                Utente utente = DBManager.getInstance().getUtenteDao().findById(rs.getString("id_utente"));
                String titolo = rs.getString("titolo");
                String descrizione = rs.getString("descrizione");

                recensione.setUtente(utente);
                recensione.setAnnuncio(annuncio);
                recensione.setTitolo(titolo);
                recensione.setDescrizione(descrizione);

                recensioni.add(recensione);
            }
        } catch (SQLException e) {
            Logger.LOG("Errore nella ricerca delle recensioni per l'annuncio " + annuncio.getIdAnnuncio() + "\n" + e.toString());
        }
        return recensioni;
    }

    @Override
    public Recensione find(Annuncio a, Utente u) {
        Recensione r=null;
        try {
            Connection conn = dbSource.getConnection();
            String query = "SELECT * FROM recensione where id_annuncio=? AND  id_utente=?";
            PreparedStatement st = conn.prepareStatement(query);
            st.setInt(1, a.getIdAnnuncio());
            st.setString(2,u.getIdUtente());
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                String titolo = rs.getString("titolo");
                String descrizione = rs.getString("descrizione");

                r=new Recensione();
                r.setUtente(u);
                r.setAnnuncio(a);
                r.setTitolo(titolo);
                r.setDescrizione(descrizione);



            }
        } catch (SQLException e) {
            Logger.LOG("Errore nella ricerca delle recensioni per l'annuncio " + a.getIdAnnuncio() + "e utente "+u.getIdUtente()+ "\n" + e.toString());
        }
        return r;
    }

    @Override
    public List<Recensione> findAll() {
        List<Recensione> recensioni = new ArrayList<>();
        try {
            Connection conn = dbSource.getConnection();
            String query = "SELECT * FROM recensione";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);
            while (rs.next()) {
                Recensione recensione = new Recensione();
                Annuncio annuncio = DBManager.getInstance().getAnnuncioDao().findById(rs.getInt("id_annuncio"));
                Utente utente = DBManager.getInstance().getUtenteDao().findById(rs.getString("id_utente"));
                String titolo = rs.getString("titolo");
                String descrizione = rs.getString("descrizione");

                recensione.setUtente(utente);
                recensione.setAnnuncio(annuncio);
                recensione.setTitolo(titolo);
                recensione.setDescrizione(descrizione);

                recensioni.add(recensione);
            }
        } catch (SQLException e) {
            Logger.LOG("Errore nella ricerca delle recensioni  " + e.toString());
        }
        return recensioni;
    }

    @Override
    public void update(Recensione r) {
        try {
            Connection conn = dbSource.getConnection();
            String query = "UPDATE recensione SET " +" titolo=?" + ", descrizione=? WHERE id_utente=? AND id_annuncio=?";
            PreparedStatement st = conn.prepareStatement(query);
            st.setString(1, r.getTitolo());
            st.setString(2, r.getDescrizione());
            st.setString(3, r.getUtente().getIdUtente());
            st.setInt(4, r.getAnnuncio().getIdAnnuncio());
            st.executeUpdate();
        } catch (SQLException e) {
            Logger.LOG("Problema nell'aggiornamento della recensione dell'utente " + r.getUtente().getIdUtente() + " " + " per l'annuncio " + r.getAnnuncio().getIdAnnuncio() + "\n" + e.toString());
        }
    }

    @Override
    public void delete(Recensione r) {

    }
}

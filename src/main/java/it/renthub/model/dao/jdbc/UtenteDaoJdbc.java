package it.renthub.model.dao.jdbc;

import it.renthub.Logger;
import it.renthub.model.DBSource;
import it.renthub.model.bean.Utente;
import it.renthub.model.dao.UtenteDao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UtenteDaoJdbc implements UtenteDao {

    private DBSource dbSource;

    public UtenteDaoJdbc(DBSource dbSource) {
        this.dbSource = dbSource;
    }

    @Override
    public void save(Utente u) {
        try {
            Connection conn = dbSource.getConnection();
            String query = "INSERT INTO utente VALUES(?,?,?,?,?,?,?,?,false)";
            PreparedStatement st = conn.prepareStatement(query);
            st.setString(1, u.getIdUtente());
            st.setString(2, u.getNome());
            st.setString(3, u.getCognome());
            st.setString(5, u.getNumTelefono() + "");
            st.setString(6, u.getEmail());
            st.setString(7, u.getPassword());
            st.setString(8, u.getRuolo());
            if (u.getDataNascita() != null)
                st.setDate(4, new Date(u.getDataNascita().getTime()));
            else
                st.setDate(4, null);
            st.executeUpdate();
        } catch (SQLException e) {
            Logger.LOG("Problema nell'inserimento dell'utente " + u.getIdUtente() + "\n" + e.toString());
        }
    }

    @Override
    public Utente findById(String idUtente) {
        Utente u = null;
        try {
            Connection conn = dbSource.getConnection();
            String query = "SELECT * FROM utente WHERE id_utente=?";
            PreparedStatement st = conn.prepareStatement(query);
            st.setString(1, idUtente);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                String nome = rs.getString("nome");
                String cognome = rs.getString("cognome");
                Date dataNascita = rs.getDate("data_di_nascita");
                String numTel = rs.getString("num_telefono");
                String email = rs.getString("email");
                String password = rs.getString("password");
                String ruolo = rs.getString("ruolo");
                Boolean bannato = rs.getBoolean("bannato");

                u = new Utente();
                u.setIdUtente(idUtente);
                u.setNome(nome);
                u.setCognome(cognome);
                u.setDataNascita(dataNascita);
                u.setNumTelefono(numTel);
                u.setEmail(email);
                u.setPassword(password);
                u.setRuolo(ruolo);
                u.setBannato(bannato);

            }
        } catch (SQLException e) {
            Logger.LOG("Errore nella ricerca dell'utente " + idUtente + "\n" + e.toString());
        }
        return u;
    }

    @Override
    public Utente findByEmail(String email) {
        Utente u = null;
        try {
            Connection conn = dbSource.getConnection();
            String query = "SELECT * FROM utente WHERE email=?";
            PreparedStatement st = conn.prepareStatement(query);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                String idUtente = rs.getString("id_utente");
                String nome = rs.getString("nome");
                String cognome = rs.getString("cognome");
                Date dataNascita = rs.getDate("data_di_nascita");
                String numTel = rs.getString("num_telefono");
                String password = rs.getString("password");
                String ruolo = rs.getString("ruolo");
                Boolean bannato = rs.getBoolean("bannato");

                u = new Utente();
                u.setIdUtente(idUtente);
                u.setNome(nome);
                u.setCognome(cognome);
                u.setDataNascita(dataNascita);
                u.setNumTelefono(numTel);
                u.setEmail(email);
                u.setPassword(password);
                u.setRuolo(ruolo);
                u.setBannato(bannato);

            }
        } catch (SQLException e) {
            Logger.LOG("Errore nella ricerca dell'utente " + email + "\n" + e.toString());
        }
        return u;
    }

    @Override
    public List<Utente> findAll() {
        List<Utente> utenti = new ArrayList<>();
        try {
            Connection conn = dbSource.getConnection();
            String query = "SELECT * FROM utente";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);
            while (rs.next()) {
                Utente u = new Utente();
                String idUtente = rs.getString("id_utente");
                String nome = rs.getString("nome");
                String cognome = rs.getString("cognome");
                Date dataNascita = rs.getDate("data_di_nascita");
                String numTel = (rs.getString("num_telefono"));
                String email = rs.getString("email");
                String password = rs.getString("password");
                String ruolo = rs.getString("ruolo");
                Boolean bannato = rs.getBoolean("bannato");

                u.setIdUtente(idUtente);
                u.setNome(nome);
                u.setCognome(cognome);
                u.setDataNascita(dataNascita);
                u.setNumTelefono(numTel);
                u.setEmail(email);
                u.setPassword(password);
                u.setRuolo(ruolo);
                u.setBannato(bannato);
                utenti.add(u);
            }
        } catch (SQLException e) {
            Logger.LOG("Errore nella ricerca degli utenti" + "\n" + e.toString());
        }
        return utenti;
    }

    //TODO update utente
    @Override
    public void update(Utente u) {
        try {
            Connection conn = dbSource.getConnection();
            String query = "UPDATE utente " + "SET nome=?" + ", cognome=?" + ", data_di_nascita=?" + ", num_telefono=?" + ", email=?" + ", password=?" + ", ruolo=?" + ", bannato=?" + " WHERE id_utente=?";
            PreparedStatement st = conn.prepareStatement(query);
            st.setString(1, u.getNome());
            st.setString(2, u.getCognome());
            st.setString(4, u.getNumTelefono() + "");
            st.setString(5, u.getEmail());
            st.setString(6, u.getPassword());
            st.setString(7, u.getRuolo());
            st.setBoolean(8, u.getBannato());
            st.setString(9, u.getIdUtente());
            if (u.getDataNascita() != null)
                st.setDate(3, new Date(u.getDataNascita().getTime()));
            else
                st.setDate(3, null);
            st.executeUpdate();
        } catch (SQLException e) {
            Logger.LOG("Problema nell'aggiornamento dell'utente " + "\n" + u.getIdUtente() + e.toString());
        }
    }

    //TODO delete utente
    @Override
    public void delete(Utente u) {

    }
}

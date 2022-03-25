package it.renthub.model.dao.jdbc;

import it.renthub.Logger;
import it.renthub.model.DBManager;
import it.renthub.model.DBSource;
import it.renthub.model.bean.Annuncio;
import it.renthub.model.bean.Posizione;
import it.renthub.model.bean.Tipologia;
import it.renthub.model.bean.Utente;
import it.renthub.model.dao.AnnuncioDao;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class AnnuncioDaoJdbc implements AnnuncioDao {
    private DBSource dbSource;

    public AnnuncioDaoJdbc(DBSource dbSource) {
        this.dbSource = dbSource;
    }

    @Override
    public void save(Annuncio annuncio) {
        try {
            Connection conn = dbSource.getConnection();
            String query = "INSERT INTO annuncio (id_utente,citta,indirizzo,cap,descrizione,prezzo,metri_quadri,titolo,foto,tipologia,affitto,data) VALUES(?,?,?,?,?,?,?,?,?,CAST(? AS tipologia),?,?)";
            PreparedStatement st = conn.prepareStatement(query);
            st.setString(1, annuncio.getUtente().getIdUtente());
            st.setString(2, annuncio.getPosizione().getCitta());
            st.setString(3, annuncio.getPosizione().getIndirizzo());
            st.setInt(4, annuncio.getPosizione().getCap());
            st.setString(5, annuncio.getDescrizione());
            st.setDouble(6, annuncio.getPrezzo());
            st.setInt(7, annuncio.getMetriQuadri());
            st.setString(8, annuncio.getTitolo());
            st.setString(9, annuncio.getFoto());
            st.setString(10, annuncio.getTipologia().toString());
            st.setBoolean(11, annuncio.isAffitto());
            st.setDate(12, new java.sql.Date(System.currentTimeMillis()));

            st.executeUpdate();
            conn.close();
            Logger.LOG("Inserito nuovo annuncio "+annuncio.getTitolo());
        } catch (SQLException e) {
            Logger.LOG("Problema nell'inserimento dell'annuncio " + annuncio.getIdAnnuncio() + " dell'utente " + annuncio.getUtente().getIdUtente() + "\n" + e.toString());
        }
    }

    @Override
    public Annuncio findById(int idAnnuncio) {
        Annuncio a = null;
        try {
            Connection conn = dbSource.getConnection();
            String query = "SELECT * FROM annuncio WHERE id_annuncio=?";
            PreparedStatement st = conn.prepareStatement(query);
            st.setInt(1, idAnnuncio);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Utente u = DBManager.getInstance().getUtenteDao().findById(rs.getString("id_utente"));

                Posizione posizione = new Posizione();
                posizione.setCap(rs.getInt("cap"));
                posizione.setCitta(rs.getString("citta"));
                posizione.setIndirizzo(rs.getString("indirizzo"));
                String descrizione = rs.getString("descrizione");
                String titolo = rs.getString("titolo");
                String foto = rs.getString("foto");
                Double prezzo = rs.getDouble("prezzo");
                Double prezzoScontato = rs.getDouble("prezzoscontato");
                int metriQuadri = rs.getInt("metri_quadri");
                Tipologia tipologia = Tipologia.valueOf(rs.getString("Tipologia"));
                Boolean isAffitto = rs.getBoolean("affitto");
                Date data = rs.getDate("data");

                a = new Annuncio();
                a.setUtente(u);
                a.setIdAnnuncio(idAnnuncio);
                a.setPosizione(posizione);
                a.setDescrizione(descrizione);
                a.setTitolo(titolo);
                a.setFoto(foto);
                a.setPrezzo(prezzo);
                a.setPrezzoScontato(prezzoScontato);
                a.setMetriQuadri(metriQuadri);
                a.setTipologia(tipologia);
                a.setAffitto(isAffitto);
                a.setData(data);
            }
            conn.close();
        } catch (SQLException e) {
            Logger.LOG("Errore nella ricerca dell' annuncio " + idAnnuncio + "\n" + e.toString());
        }
        return a;

    }

    @Override
    public List<Annuncio> findByUtente(Utente u) {
        List<Annuncio> annunci = new ArrayList<>();
        try {
            Connection conn = dbSource.getConnection();
            String query = "SELECT * FROM annuncio where id_utente=?";
            PreparedStatement st = conn.prepareStatement(query);
            st.setString(1, u.getIdUtente());
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Annuncio annuncio = new Annuncio();

                int idAnnuncio = rs.getInt("id_annuncio");
                Posizione posizione = new Posizione();
                posizione.setCap(rs.getInt("cap"));
                posizione.setCitta(rs.getString("citta"));
                posizione.setIndirizzo(rs.getString("indirizzo"));
                String descrizione = rs.getString("descrizione");
                String titolo = rs.getString("titolo");
                String foto = rs.getString("foto");
                Double prezzo = rs.getDouble("prezzo");
                Double prezzoScontato = rs.getDouble("prezzoscontato");
                int metriQuadri = rs.getInt("metri_quadri");
                Tipologia tipologia = Tipologia.valueOf(rs.getString("Tipologia"));
                Boolean isAffitto = rs.getBoolean("affitto");
                Date data = rs.getDate("data");

                annuncio.setUtente(u);
                annuncio.setIdAnnuncio(idAnnuncio);
                annuncio.setPosizione(posizione);
                annuncio.setDescrizione(descrizione);
                annuncio.setTitolo(titolo);
                annuncio.setFoto(foto);
                annuncio.setPrezzo(prezzo);
                annuncio.setPrezzoScontato(prezzoScontato);
                annuncio.setMetriQuadri(metriQuadri);
                annuncio.setTipologia(tipologia);
                annuncio.setAffitto(isAffitto);
                annuncio.setData(data);

                annunci.add(annuncio);
            }
            conn.close();
        } catch (SQLException e) {
            Logger.LOG("Errore nella ricerca degli annunci per l'utente " + u.getIdUtente() + "\n" + e.toString());
        }
        if (annunci.isEmpty())
            throw new RuntimeException("Impossibile trovare annunci dell'utente " + u.getIdUtente());

        return annunci;


    }

    @Override
    public List<Annuncio> findAll() {
        List<Annuncio> annunci = new ArrayList<>();
        try {
            Connection conn = dbSource.getConnection();
            String query = "SELECT * FROM annuncio";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);
            while (rs.next()) {
                Annuncio annuncio = new Annuncio();

                int idAnnuncio = rs.getInt("id_annuncio");
                Utente u = DBManager.getInstance().getUtenteDao().findById("id_utente");
                Posizione posizione = new Posizione();
                posizione.setCap(rs.getInt("cap"));
                posizione.setCitta(rs.getString("citta"));
                posizione.setIndirizzo(rs.getString("indirizzo"));
                String descrizione = rs.getString("descrizione");
                String titolo = rs.getString("titolo");
                String foto = rs.getString("foto");
                Double prezzo = rs.getDouble("prezzo");
                Double prezzoScontato = rs.getDouble("prezzoscontato");
                int metriQuadri = rs.getInt("metri_quadri");
                Tipologia tipologia = Tipologia.valueOf(rs.getString("Tipologia"));
                Boolean isAffitto = rs.getBoolean("affitto");
                Date data = rs.getDate("data");

                annuncio.setUtente(u);
                annuncio.setIdAnnuncio(idAnnuncio);
                annuncio.setPosizione(posizione);
                annuncio.setDescrizione(descrizione);
                annuncio.setTitolo(titolo);
                annuncio.setFoto(foto);
                annuncio.setPrezzo(prezzo);
                annuncio.setPrezzoScontato(prezzoScontato);
                annuncio.setMetriQuadri(metriQuadri);
                annuncio.setTipologia(tipologia);
                annuncio.setAffitto(isAffitto);
                annuncio.setData(data);

                annunci.add(annuncio);
            }
            conn.close();
        } catch (SQLException e) {
            Logger.LOG("Errore nella ricerca degli annunci \n" + e.toString());
        }
        return annunci;
    }

    @Override
    public void update(Annuncio a) {
        try {
            Connection conn = dbSource.getConnection();
            String query = "UPDATE annuncio" + " SET indirizzo=?" + ", citta=?" + ", cap=?" + ", descrizione=?" + ", prezzo=?" + ",prezzoscontato=?"
                    + ", metri_quadri=?" + ", titolo=?" + ", foto=?" + ", tipologia=CAST(? AS tipologia)" + ", affitto=?" + " WHERE id_annuncio=?";
            PreparedStatement st = conn.prepareStatement(query);
            st.setString(1, a.getPosizione().getIndirizzo());
            st.setString(2, a.getPosizione().getCitta());
            st.setInt(3, a.getPosizione().getCap());
            st.setString(4, a.getDescrizione());
            st.setDouble(5, a.getPrezzo());
            st.setDouble(6, a.getPrezzoScontato());
            st.setInt(7, a.getMetriQuadri());
            st.setString(8, a.getTitolo());
            st.setString(9, a.getFoto());
            st.setString(10, a.getTipologia().toString());
            st.setBoolean(11, a.isAffitto());
            st.setInt(12, a.getIdAnnuncio());

            st.executeUpdate();
            conn.close();
            Logger.LOG("Annuncio "+a.getIdAnnuncio()+" modificato");
        } catch (SQLException e) {
            Logger.LOG("Problema nell'aggiornamento dell' annuncio " + a.getIdAnnuncio() + "\n" + e.toString());
        }
    }

    @Override
    public void delete(Annuncio a) {
        try{
            Connection conn=dbSource.getConnection();
            String query2 = "DELETE FROM annuncio WHERE id_annuncio=?";
            PreparedStatement st=conn.prepareStatement(query2);
            st.setInt(1,a.getIdAnnuncio());
            st.executeUpdate();
            conn.close();
            Logger.LOG("Annuncio "+a.getIdAnnuncio()+" eliminato");
        }catch (Exception e){
            Logger.LOG("Problema nell'eliminazione dell'annuncio " + a.getIdAnnuncio()+e.toString());
        }
    }

    @Override
    public Long getNextId() throws SQLException {
        Connection conn = dbSource.getConnection();
        String query2 = "select  last_value  from annuncio_idannuncio_seq";
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery(query2);
        while (rs.next()) {
            conn.close();
            return rs.getLong(1) + 1;
        }
        conn.close();
        return null;
    }

}

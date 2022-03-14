package it.renthub.model.dao.jdbc;

import it.renthub.Logger;
import it.renthub.model.DBManager;
import it.renthub.model.DBSource;
import it.renthub.model.bean.Annuncio;
import it.renthub.model.bean.Posizione;
import it.renthub.model.bean.Utente;
import it.renthub.model.dao.AnnuncioDao;

import java.sql.*;
import java.util.ArrayList;
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
            String query = "INSERT INTO annuncio (id_utente,latitudine,longitudine,descrizione,prezzo,metri_quadri,titolo,foto) VALUES(?,?,?,?,?,?,?,?)";
            PreparedStatement st = conn.prepareStatement(query);

            st.setString(1, annuncio.getUtente().getIdUtente());
            st.setInt(2, annuncio.getPosizione().getLatitudine());
            st.setInt(3, annuncio.getPosizione().getLongitudine());
            st.setString(4, annuncio.getDescrizione());
            st.setDouble(5, annuncio.getPrezzo());
            st.setInt(6, annuncio.getMetriQuadri());
            st.setString(7, annuncio.getTitolo());
            st.setString(8, annuncio.getFoto());
            st.executeUpdate();
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
                posizione.setLatitudine(rs.getInt("latitudine"));
                posizione.setLongitudine(rs.getInt("longitudine"));
                String descrizione = rs.getString("descrizione");
                String titolo = rs.getString("titolo");
                String foto = rs.getString("foto");
                Double prezzo = rs.getDouble("prezzo");
                int metriQuadri = rs.getInt("metri_quadri");

                a = new Annuncio();
                a.setUtente(u);
                a.setIdAnnuncio(idAnnuncio);
                a.setPosizione(posizione);
                a.setDescrizione(descrizione);
                a.setTitolo(titolo);
                a.setFoto(foto);
                a.setPrezzo(prezzo);
                a.setMetriQuadri(metriQuadri);
            }
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
                posizione.setLatitudine(rs.getInt("latitudine"));
                posizione.setLongitudine(rs.getInt("longitudine"));
                String descrizione = rs.getString("descrizione");
                String titolo = rs.getString("titolo");
                String foto = rs.getString("foto");
                Double prezzo = rs.getDouble("prezzo");
                int metriQuadri = rs.getInt("metri_quadri");


                annuncio.setUtente(u);
                annuncio.setIdAnnuncio(idAnnuncio);
                annuncio.setPosizione(posizione);
                annuncio.setDescrizione(descrizione);
                annuncio.setTitolo(titolo);
                annuncio.setFoto(foto);
                annuncio.setPrezzo(prezzo);
                annuncio.setMetriQuadri(metriQuadri);

                annunci.add(annuncio);
            }
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
                posizione.setLatitudine(rs.getInt("latitudine"));
                posizione.setLongitudine(rs.getInt("longitudine"));
                String descrizione = rs.getString("descrizione");
                String titolo = rs.getString("titolo");
                String foto = rs.getString("foto");
                Double prezzo = rs.getDouble("prezzo");
                int metriQuadri = rs.getInt("metri_quadri");


                annuncio.setUtente(u);
                annuncio.setIdAnnuncio(idAnnuncio);
                annuncio.setPosizione(posizione);
                annuncio.setDescrizione(descrizione);
                annuncio.setTitolo(titolo);
                annuncio.setFoto(foto);
                annuncio.setPrezzo(prezzo);
                annuncio.setMetriQuadri(metriQuadri);

                annunci.add(annuncio);
            }
        } catch (SQLException e) {
            Logger.LOG("Errore nella ricerca degli annunci \n" + e.toString());
        }
        return annunci;
    }

    @Override
    public void update(Annuncio a) {
        try {
            Connection conn = dbSource.getConnection();
            String query = "UPDATE annuncio" + " SET latitudine=?" + ", longitudine=?" + ", descrizione=?" + ", prezzo=?"
                    + ", metri_quadri=?" + ", titolo=?" + ", foto=?" + " WHERE id_annuncio=?";
            PreparedStatement st = conn.prepareStatement(query);
            st.setInt(1, a.getPosizione().getLatitudine());
            st.setInt(2, a.getPosizione().getLongitudine());
            st.setString(3, a.getDescrizione());
            st.setDouble(4, a.getPrezzo());
            st.setInt(5, a.getMetriQuadri());
            st.setString(6, a.getTitolo());
            st.setString(7, a.getFoto());
            st.setInt(8, a.getIdAnnuncio());

            st.executeUpdate();
        } catch (SQLException e) {
            Logger.LOG("Problema nell'aggiornamento della recensione dell' annuncio " + a.getIdAnnuncio() + "\n" + e.toString());
        }
    }

    @Override
    public void delete(Annuncio a) {

    }
}

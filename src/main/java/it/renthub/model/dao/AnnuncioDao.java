package it.renthub.model.dao;

import it.renthub.model.bean.Annuncio;
import it.renthub.model.bean.Tipologia;
import it.renthub.model.bean.Utente;

import java.sql.SQLException;
import java.util.List;

public interface AnnuncioDao {
    public void save(Annuncio annuncio);

    public Annuncio findById(int idAnnuncio);

    public List<Annuncio> findByUtente(Utente u);

    public List<Annuncio> findByCitta(String citta);

    public List<Annuncio> findByTipologia(Tipologia t);

    public List<Annuncio> findByTipologiaCitta(Tipologia t, String citta);

    public List<Annuncio> findAll();

    public void update(Annuncio a);

    public void delete(Annuncio a);

    public Long getNextId() throws SQLException;

}

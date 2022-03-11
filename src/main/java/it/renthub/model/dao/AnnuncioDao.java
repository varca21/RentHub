package it.renthub.model.dao;

import it.renthub.model.bean.Annuncio;
import it.renthub.model.bean.Utente;

import java.util.List;

public interface AnnuncioDao {
    public void save(Annuncio annuncio);

    public Annuncio findById(int idAnnuncio);

    public List<Annuncio> findByUtente(Utente u);

    public List<Annuncio> findAll();

    public void update(Annuncio a);

    public void delete(Annuncio a);

}

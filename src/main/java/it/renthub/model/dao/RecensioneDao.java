package it.renthub.model.dao;

import it.renthub.model.bean.Annuncio;
import it.renthub.model.bean.Recensione;
import it.renthub.model.bean.Utente;

import java.util.List;

public interface RecensioneDao {
    public void save(Recensione r);

    public List<Recensione> findByUtente(Utente u);

    public List<Recensione> findByAnnuncio(Annuncio annuncio);

    public Recensione find (Annuncio a, Utente u);

    public List<Recensione> findAll();

    public void update(Recensione r);

    public void delete(Recensione r);
}

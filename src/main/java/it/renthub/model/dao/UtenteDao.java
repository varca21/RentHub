package it.renthub.model.dao;

import it.renthub.model.bean.Utente;

import java.util.List;

public interface UtenteDao {

    public void save(Utente u);

    public Utente findByPrimaryKey(String idUtente); //trova un Utente con un dato ID

    public List<Utente> findAll();

    public void update(Utente u); //modifiche su Utente già esistente

    public void delete(Utente u);
}

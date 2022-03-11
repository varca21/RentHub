package it.renthub.model.bean;

import java.util.Objects;

public class Recensione {
    Utente utente;
    Annuncio annuncio;
    String titolo;
    String descrizione;

    public Utente getUtente() {
        return utente;
    }

    public void setUtente(Utente utente) {
        this.utente = utente;
    }

    public Annuncio getAnnuncio() {
        return annuncio;
    }

    public void setAnnuncio(Annuncio annuncio) {
        this.annuncio = annuncio;
    }

    public String getTitolo() {
        return titolo;
    }

    public void setTitolo(String titolo) {
        this.titolo = titolo;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Recensione that = (Recensione) o;
        return Objects.equals(utente, that.utente) && Objects.equals(annuncio, that.annuncio) && Objects.equals(titolo, that.titolo) && Objects.equals(descrizione, that.descrizione);
    }

    @Override
    public String toString() {
        return "Recensione{" +
                "utente=" + utente +
                ", annuncio=" + annuncio +
                ", titolo='" + titolo + '\'' +
                ", descrizione='" + descrizione + '\'' +
                '}';
    }
}

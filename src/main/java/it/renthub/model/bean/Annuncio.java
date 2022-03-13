package it.renthub.model.bean;

import java.util.Objects;

public class Annuncio {
    int idAnnuncio;
    Utente utente;
    Posizione posizione;
    String descrizione;
    String titolo;
    String foto;
    double prezzo;
    int metriQuadri;


    public Utente getUtente() {
        return utente;
    }

    public void setUtente(Utente utente) {
        this.utente = utente;
    }

    public Posizione getPosizione() {
        return posizione;
    }

    public void setPosizione(Posizione posizione) {
        this.posizione = posizione;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    public String getTitolo() {
        return titolo;
    }

    public void setTitolo(String titolo) {
        this.titolo = titolo;
    }

    public String getFoto() {
        return foto;
    }

    public void setFoto(String foto) {
        this.foto = foto;
    }

    public double getPrezzo() {
        return prezzo;
    }

    public void setPrezzo(double prezzo) {
        this.prezzo = prezzo;
    }

    public int getMetriQuadri() {
        return metriQuadri;
    }

    public void setMetriQuadri(int metriQuadri) {
        this.metriQuadri = metriQuadri;
    }

    public int getIdAnnuncio() {
        return idAnnuncio;
    }

    public void setIdAnnuncio(int idAnnuncio) {
        this.idAnnuncio = idAnnuncio;
    }

    @Override
    public String toString() {
        return "Annuncio{" +
                "id annuncio=" + idAnnuncio +
                ", utente=" + utente +
                ", posizione=" + posizione +
                ", descrizione='" + descrizione + '\'' +
                ", titolo='" + titolo + '\'' +
                ", foto='" + foto + '\'' +
                ", prezzo=" + prezzo +
                ", metriQuadri=" + metriQuadri +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Annuncio annuncio = (Annuncio) o;
        return idAnnuncio == annuncio.idAnnuncio && Double.compare(annuncio.prezzo, prezzo) == 0 && Double.compare(annuncio.metriQuadri, metriQuadri) == 0 && Objects.equals(utente, annuncio.utente) && Objects.equals(posizione, annuncio.posizione) && Objects.equals(descrizione, annuncio.descrizione) && Objects.equals(titolo, annuncio.titolo) && Objects.equals(foto, annuncio.foto);
    }

}
package it.renthub.model.bean;

import java.util.*;

public class Annuncio {
    int idAnnuncio;
    Utente utente;
    Posizione posizione;
    String descrizione;
    String titolo;
    String foto;

    String fotoCopertina;

    int prezzo;
    int prezzoScontato;
    int metriQuadri;
    Tipologia tipologia;
    boolean affitto;
    Date data;

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
        StringTokenizer st = new StringTokenizer(foto, ",");
        if (st.hasMoreTokens())
            fotoCopertina = "/immagini/annunci/" + this.getIdAnnuncio() + "/" + st.nextToken();

    }

    public int getPrezzo() {
        return prezzo;
    }

    public void setPrezzo(int prezzo) {
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

    public boolean isAffitto() {
        return affitto;
    }

    public void setAffitto(boolean affitto) {
        this.affitto = affitto;
    }

    public Tipologia getTipologia() {
        return tipologia;
    }

    public void setTipologia(Tipologia tipologia) {
        this.tipologia = tipologia;
    }

    public Date getData() {
        return data;
    }

    public void setData(Date data) {
        this.data = data;
    }

    public int getPrezzoScontato() {
        return prezzoScontato;
    }

    public void setPrezzoScontato(int prezzoScontato) {
        if (prezzoScontato == this.prezzo)
            this.prezzoScontato = 0;
        else
            this.prezzoScontato = prezzoScontato;
    }

    public String getFotoCopertina() {
        return fotoCopertina;
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
                ", prezzo scontato=" + prezzoScontato +
                ", metriQuadri=" + metriQuadri +
                ", tipologia=" + tipologia +
                ", affitto=" + affitto +
                " data=" + data +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Annuncio annuncio = (Annuncio) o;
        return idAnnuncio == annuncio.idAnnuncio && Double.compare(annuncio.prezzo, prezzo) == 0 && Double.compare(annuncio.prezzoScontato, prezzoScontato) == 0 && metriQuadri == annuncio.metriQuadri && affitto == annuncio.affitto && Objects.equals(utente, annuncio.utente) && Objects.equals(posizione, annuncio.posizione) && Objects.equals(descrizione, annuncio.descrizione) && Objects.equals(titolo, annuncio.titolo) && Objects.equals(foto, annuncio.foto) && tipologia == annuncio.tipologia && annuncio.getData().compareTo(data) == 0;
    }


}

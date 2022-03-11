package it.renthub.model.bean;

public class Posizione {
    int latitudine;
    int longitudine;

    public int getLatitudine() {
        return latitudine;
    }

    public void setLatitudine(int latitudine) {
        this.latitudine = latitudine;
    }

    public int getLongitudine() {
        return longitudine;
    }

    public void setLongitudine(int longitudine) {
        this.longitudine = longitudine;
    }

    @Override
    public String toString() {
        return "Posizione{" +
                "latitudine=" + latitudine +
                ", longitudine=" + longitudine +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Posizione posizione = (Posizione) o;
        return latitudine == posizione.latitudine && longitudine == posizione.longitudine;
    }


}

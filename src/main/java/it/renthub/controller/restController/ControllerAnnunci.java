package it.renthub.controller.restController;

import it.renthub.model.DBManager;
import it.renthub.model.bean.Annuncio;
import it.renthub.model.bean.Posizione;
import it.renthub.model.bean.Tipologia;
import it.renthub.model.bean.Utente;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@RestController
@RequestMapping("/rest/annunci")
public class ControllerAnnunci {

    @GetMapping("/tipologie")
    List<String> tipologieAnnunci() {
        return Stream.of(Tipologia.values()).map(Tipologia::name).collect(Collectors.toList());
    }

    @PostMapping("/nuovo")
    void aggiungiAnnuncio(@RequestBody Map<String, String> parametri, HttpSession sessione) {
        System.out.println("entro");
        Annuncio nuovoAnnuncio = new Annuncio();
        nuovoAnnuncio.setTitolo(parametri.get("titolo"));
        nuovoAnnuncio.setDescrizione(parametri.get("descrizione"));
        nuovoAnnuncio.setMetriQuadri(Integer.parseInt(parametri.get("metriQuadri")));
        nuovoAnnuncio.setPrezzo(Double.parseDouble(parametri.get("prezzo")));
        nuovoAnnuncio.setUtente(utenteCorrente(sessione));
        nuovoAnnuncio.setTipologia(Tipologia.valueOf(parametri.get("tipologia")));
        Posizione nuovaPosizione = new Posizione();
        nuovaPosizione.setCitta(parametri.get("citta"));
        nuovaPosizione.setIndirizzo(parametri.get("indirizzo"));
        nuovaPosizione.setCap(Integer.parseInt(parametri.get("cap")));
        nuovoAnnuncio.setPosizione(nuovaPosizione);

        if (parametri.get("affitto").equals("affitto"))
            nuovoAnnuncio.setAffitto(true);
        else if (parametri.get("affitto").equals("vendita"))
            nuovoAnnuncio.setAffitto(false);
        else throw new RuntimeException("tipologia di vendita non valida");

        if (utenteCorrente(sessione) == null)
            throw new RuntimeException("utente non loggato");
        if (nuovoAnnuncio.getTitolo() == null)
            throw new RuntimeException("inserire titolo");
        if (nuovoAnnuncio.getDescrizione() == null)
            throw new RuntimeException("inserire descrizione");
        if (nuovoAnnuncio.getTipologia() == null)
            throw new RuntimeException("inserire tiplogia");
        if (nuovaPosizione.getCitta() == null)
            throw new RuntimeException("inserire citta");
        if (nuovaPosizione.getCap() == 0)
            throw new RuntimeException("inserire cap");
        if (nuovaPosizione.getIndirizzo() == null)
            throw new RuntimeException("inserire indirizzo");


        DBManager.getInstance().getAnnuncioDao().save(nuovoAnnuncio);

    }


    private Utente utenteCorrente(HttpSession sessione) {
        return (Utente) sessione.getAttribute("utenteLoggato");
    }
}

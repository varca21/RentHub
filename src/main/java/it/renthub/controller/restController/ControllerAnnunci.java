package it.renthub.controller.restController;

import it.renthub.model.DBManager;
import it.renthub.model.bean.Annuncio;
import it.renthub.model.bean.Posizione;
import it.renthub.model.bean.Tipologia;
import it.renthub.model.bean.Utente;
import org.springframework.http.MediaType;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@RestController
@RequestMapping("/rest/annunci")
public class ControllerAnnunci {

    @GetMapping("/tipologie")
    List<String> tipologieAnnunci() {
        return Stream.of(Tipologia.values()).map(Tipologia::name).collect(Collectors.toList());
    }

    @PostMapping(value = "/nuovo", consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE})
    void aggiungiAnnuncio(@RequestPart String titolo, @RequestPart String descrizione, @RequestPart String metriQuadri, @RequestPart String prezzo,
                          @RequestPart String tipologia, @RequestPart String citta, @RequestPart String indirizzo,
                          @RequestPart String affitto, @RequestPart String cap, @RequestPart MultipartFile[] foto, HttpSession sessione) throws SQLException, IOException, IOException, SQLException {

        Annuncio nuovoAnnuncio = new Annuncio();
        nuovoAnnuncio.setTitolo(titolo);
        nuovoAnnuncio.setDescrizione(descrizione);
        nuovoAnnuncio.setMetriQuadri(Integer.parseInt(metriQuadri));
        nuovoAnnuncio.setPrezzo(Double.parseDouble(prezzo));
        nuovoAnnuncio.setUtente(utenteCorrente(sessione));
        nuovoAnnuncio.setTipologia(Tipologia.valueOf(tipologia));
        Posizione nuovaPosizione = new Posizione();
        nuovaPosizione.setCitta(citta);
        nuovaPosizione.setIndirizzo(indirizzo);
        nuovaPosizione.setCap(Integer.parseInt(cap));
        nuovoAnnuncio.setPosizione(nuovaPosizione);

        if (affitto.equals("affitto"))
            nuovoAnnuncio.setAffitto(true);
        else if (affitto.equals("vendita"))
            nuovoAnnuncio.setAffitto(false);
        else throw new RuntimeException("tipologia di vendita non valida");

        long nextId = DBManager.getInstance().getAnnuncioDao().getNextId();
        //gestione foto
        for (MultipartFile file : foto) {
            if (StringUtils.isEmpty(nuovoAnnuncio.getFoto())) {
                nuovoAnnuncio.setFoto(file.getOriginalFilename());
            } else {
                nuovoAnnuncio.setFoto(nuovoAnnuncio.getFoto() + "," + file.getOriginalFilename());
            }

            File temp = new File("src/main/webapp/immagini/annunci/" + nextId);
            if (!temp.exists()) {
                temp.mkdirs();
            }
            Path filepath = Paths.get("src/main/webapp/immagini/annunci/" + nextId, file.getOriginalFilename());
            file.transferTo(filepath);
        }


        //controllo errori
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

    @PostMapping(value = "/modifica/{id}")
    void modificaAnnuncio(@RequestPart String titolo, @RequestPart String descrizione, @RequestPart String metriQuadri,
                          @RequestPart String tipologia, @RequestPart String citta, @RequestPart String indirizzo,
                          @RequestPart String cap, HttpSession sessione, @RequestPart String prezzo, @RequestPart String prezzoScontato, @PathVariable("id") String id) {


        Annuncio annuncio = DBManager.getInstance().getAnnuncioDao().findById(Integer.parseInt(id));

        annuncio.setTitolo(titolo);
        annuncio.setDescrizione(descrizione);
        annuncio.setMetriQuadri(Integer.parseInt(metriQuadri));
        annuncio.setTipologia(Tipologia.valueOf(tipologia));
        annuncio.getPosizione().setCitta(citta);
        annuncio.getPosizione().setCap(Integer.parseInt(cap));
        annuncio.getPosizione().setIndirizzo(indirizzo);
        annuncio.setPrezzo(Double.parseDouble(prezzo));
        annuncio.setPrezzoScontato(Double.parseDouble(prezzoScontato));

        //controllo errori
        if (utenteCorrente(sessione) == null)
            throw new RuntimeException("utente non loggato");
        if (annuncio.getTitolo() == null)
            throw new RuntimeException("inserire titolo");
        if (annuncio.getDescrizione() == null)
            throw new RuntimeException("inserire descrizione");
        if (annuncio.getTipologia() == null)
            throw new RuntimeException("inserire tiplogia");
        if (annuncio.getPosizione().getCitta() == null)
            throw new RuntimeException("inserire citta");
        if (annuncio.getPosizione().getCap() == 0)
            throw new RuntimeException("inserire cap");
        if (annuncio.getPosizione().getIndirizzo() == null)
            throw new RuntimeException("inserire indirizzo");


        DBManager.getInstance().getAnnuncioDao().update(annuncio);

    }

    @GetMapping("/cancella")
    void cancellaAnnuncio(@RequestParam int id, HttpSession sessione) {
        Utente utenteCorrente = utenteCorrente(sessione);
        Annuncio annuncio = DBManager.getInstance().getAnnuncioDao().findById(id);
        if (!utenteCorrente.getRuolo().equals("AMMINISTRATORE") && !utenteCorrente.getIdUtente().equals(annuncio.getUtente().getIdUtente()))
            throw new RuntimeException("Utente non abilitato, " + utenteCorrente.getIdUtente() + " " + annuncio.getUtente().getIdUtente());
        if (annuncio == null)
            throw new RuntimeException("Annuncio non esistente");
        DBManager.getInstance().getAnnuncioDao().delete(annuncio);
    }

    @GetMapping("/cercaannuncio")
    List<Annuncio> cercaAnnuncio(@RequestParam(required = false) String testo, @RequestParam(required = false) String tipologia, @RequestParam(required = false) String citta, @RequestParam(required = false) String indirizzo, @RequestParam(required = false) String tipoVendita) {
        List<Annuncio> ris = null;
        if (citta == null) {
            if (tipologia != null)
                ris = DBManager.getInstance().getAnnuncioDao().findByTipologia(Tipologia.valueOf(tipologia));
            else
                ris = DBManager.getInstance().getAnnuncioDao().findAll();
        } else {
            if (tipologia == null)
                ris = DBManager.getInstance().getAnnuncioDao().findByCitta(citta);
            else
                ris = DBManager.getInstance().getAnnuncioDao().findByTipologiaCitta(Tipologia.valueOf(tipologia), citta);
        }

        if (StringUtils.isEmpty(indirizzo))
            ris.removeIf(x -> !x.getPosizione().getIndirizzo().toLowerCase(Locale.ROOT).contains(indirizzo));

        if (StringUtils.isEmpty(testo))
            ris.removeIf(x -> !x.getTitolo().toLowerCase(Locale.ROOT).contains(testo.toLowerCase(Locale.ROOT)));

        if(!StringUtils.isEmpty(tipoVendita)) {
            if (tipoVendita.equals("vendita"))
                ris.removeIf(x -> x.isAffitto());
            if (tipoVendita.equals("affitto"))
                ris.removeIf(x -> !x.isAffitto());
        }


        return ris;
    }

    private Utente utenteCorrente(HttpSession sessione) {
        return (Utente) sessione.getAttribute("utenteLoggato");
    }
}

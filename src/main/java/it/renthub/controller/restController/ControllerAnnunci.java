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
import java.util.List;
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


    private Utente utenteCorrente(HttpSession sessione) {
        return (Utente) sessione.getAttribute("utenteLoggato");
    }
}

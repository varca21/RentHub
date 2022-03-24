package it.renthub.controller.restController;

import it.renthub.model.DBManager;
import it.renthub.model.bean.Annuncio;
import it.renthub.model.bean.Recensione;
import it.renthub.model.bean.Utente;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/rest/recensioni")
public class ControllerRecensioni {

    @GetMapping("/nuova")
    void aggiungiRecensione(@RequestParam String idUtente, @RequestParam String idAnnuncio, @RequestParam String recensione) {
        Utente u = DBManager.getInstance().getUtenteDao().findById(idUtente);
        Annuncio a = DBManager.getInstance().getAnnuncioDao().findById(Integer.parseInt(idAnnuncio));
        Recensione r = new Recensione();
        r.setDescrizione(recensione);
        r.setUtente(u);
        r.setAnnuncio(a);
        r.setTitolo("");

        DBManager.getInstance().getRecensioneDao().save(r);
    }
}

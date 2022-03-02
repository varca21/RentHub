package it.renthub.controller.restController;

import it.renthub.model.DBManager;
import it.renthub.model.bean.Utente;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/rest/utenti")
public class ControllerUtenti {

    @GetMapping("/")
    List<Utente> getUtenti() {
        return DBManager.getInstance().getUtenteDao().findAll();
    }

    @GetMapping("/ricerca")
    Utente ricercaUtente(@RequestParam String id) {
        return DBManager.getInstance().getUtenteDao().findByPrimaryKey(id);
    }

    @PostMapping("/registrazione")
    Boolean registrazione(@RequestParam String id, @RequestParam String nome, @RequestParam String cognome, @RequestParam String dataNascita, @RequestParam String numTel, @RequestParam String email, @RequestParam String password) throws ParseException {
        if (DBManager.getInstance().getUtenteDao().findByPrimaryKey(id) != null)
            return false;

        Utente u = new Utente();
        u.setIdUtente(id);
        u.setNome(nome);
        u.setCognome(cognome);
        Date d = new SimpleDateFormat("yyyy-MM-dd").parse(dataNascita);
        u.setDataNascita(d);
        u.setNumTelefono(numTel);
        u.setEmail(email);
        u.setPassword(password);
        u.setRuolo("COMPRATORE"); //TODO da modificare
        DBManager.getInstance().getUtenteDao().save(u);

        return true;
    }

}


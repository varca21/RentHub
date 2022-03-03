package it.renthub.controller.restController;

import it.renthub.model.DBManager;
import it.renthub.model.bean.Utente;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/rest/utenti")
public class ControllerUtenti {

    @GetMapping("/")
    List<Utente> getUtenti() {
        return DBManager.getInstance().getUtenteDao().findAll();
    }

    @GetMapping("/ricerca")
    Utente ricercaUtente(@RequestParam String id) {
        return DBManager.getInstance().getUtenteDao().findById(id);
    }

    @PostMapping("/registrazione")
    Boolean registrazione(@RequestBody Map<String, String> userData) throws ParseException {

        if (DBManager.getInstance().getUtenteDao().findById(userData.get("id")) != null)
            throw new RuntimeException("ID "+userData.get("id")+" già presente");



        if (DBManager.getInstance().getUtenteDao().findByEmail(userData.get("email")) != null)
            throw new RuntimeException("Email "+userData.get("email")+" già presente");

        Utente u = new Utente();
        u.setIdUtente(userData.get("id"));
        u.setNome(userData.get("nome"));
        u.setCognome(userData.get("cognome"));
        Date d = new SimpleDateFormat("yyyy-MM-dd").parse(userData.get("dataNascita"));
        u.setDataNascita(d);
        u.setNumTelefono(userData.get("numTel"));
        u.setEmail(userData.get("email"));
        u.setPassword(userData.get("password"));
        u.setRuolo("COMPRATORE"); //TODO da modificare
        DBManager.getInstance().getUtenteDao().save(u);

        return true;
    }

}


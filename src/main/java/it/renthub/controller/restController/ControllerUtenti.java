package it.renthub.controller.restController;

import it.renthub.Logger;
import it.renthub.model.DBManager;
import it.renthub.model.bean.Annuncio;
import it.renthub.model.bean.Utente;
import it.renthub.util.email.GestoreEmail;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
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

    @GetMapping("/utenteCorrente")
    Utente utenteCorrente(HttpSession sessione) {
        return (Utente) sessione.getAttribute("utenteLoggato");
    }

    @PostMapping("/registrazione")
    Boolean registrazione(@RequestBody Map<String, String> userData) throws ParseException {

        if (DBManager.getInstance().getUtenteDao().findById(userData.get("id")) != null) {
            Logger.LOG("registrazione di account con id già esistente, id: " + userData.get("id"));
            throw new RuntimeException("ID presente");
        }


        if (DBManager.getInstance().getUtenteDao().findByEmail(userData.get("email")) != null) {
            Logger.LOG("registrazione di account con email già esistente, email: " + userData.get("email"));
            throw new RuntimeException("Email presente");
        }

        Utente u = new Utente();
        u.setIdUtente(userData.get("id"));
        u.setNome(userData.get("nome"));
        u.setCognome(userData.get("cognome"));
        u.setNumTelefono(userData.get("numTel"));
        u.setEmail(userData.get("email"));
        u.setPassword(userData.get("password"));
        u.setRuolo("COMPRATORE"); //TODO da modificare

        Date d;
        try {
            d = new SimpleDateFormat("yyyy-MM-dd").parse(userData.get("dataNascita"));
        } catch (Exception parseException) {
            d = null;
        }

        u.setDataNascita(d);
        DBManager.getInstance().getUtenteDao().save(u);
        Logger.LOG("utente " + u.getIdUtente() + " registrato con successo");
        return true;
    }

    @PostMapping("/aggiornaUtente")
    Boolean aggiornaUtente(HttpSession sessione, @RequestBody Map<String, String> parametri) throws ParseException {

        Utente u = DBManager.getInstance().getUtenteDao().findById(parametri.get("id"));
        if (u == null)
            u = DBManager.getInstance().getUtenteDao().findByEmail(parametri.get("id"));
        if (u == null)
            throw new RuntimeException("Account non esistente");

        u.setIdUtente(parametri.get("id"));
        u.setNome(parametri.get("nome"));
        u.setCognome(parametri.get("cognome"));
        u.setNumTelefono(parametri.get("numTel"));
        u.setEmail(parametri.get("email"));
        u.setRuolo("COMPRATORE"); //TODO da modificare

        Date d;
        try {
            d = new SimpleDateFormat("yyyy-MM-dd").parse(parametri.get("dataNascita"));
        } catch (Exception parseException) {
            d = null;
        }

        u.setDataNascita(d);
        DBManager.getInstance().getUtenteDao().update(u);
        sessione.setAttribute("utenteLoggato", u);

        Logger.LOG("utente " + u.getIdUtente() + " aggiornato con successo");
        return true;
    }


    @PostMapping("/login")
    public Boolean login(@RequestBody Map<String, String> parametri, HttpSession sessione) {

        Utente u = DBManager.getInstance().getUtenteDao().findById(parametri.get("id"));
        if (u == null)
            u = DBManager.getInstance().getUtenteDao().findByEmail(parametri.get("id"));
        if (u == null) {
            Logger.LOG("Account " + parametri.get("id") + " non esiste");
            throw new RuntimeException("Account non esistente");
        }

        if (!u.getPassword().equals(parametri.get("password"))) {
            Logger.LOG("Password errata per l'utente " + u.getIdUtente());
            throw new RuntimeException("Password errata");

        }

        sessione.setAttribute("utenteLoggato", u);

        return true;
    }

    @GetMapping("/logout")
    public void logout(HttpSession sessione) {
        sessione.invalidate();
    }

    @GetMapping("/bannautente")
    public Boolean bannaUtente(HttpSession sessione, @RequestParam String id, @RequestParam Boolean flag) {
        if (isUtenteCorrenteAmministratore(sessione)) {
            Utente u = DBManager.getInstance().getUtenteDao().findById(id);
            if (u != null) {
                u.setBannato(flag);
                DBManager.getInstance().getUtenteDao().update(u);
                if (utenteCorrente(sessione).equals(u))
                    sessione.setAttribute("utenteLoggato", u);
                Logger.LOG("Utente " + id + " bannato! " + flag);
            } else {
                Logger.LOG("Impossibile bannare l' utente " + id + ", non esiste!");
                throw new RuntimeException("L'utente non esiste");
            }
        }
        return false;
    }

    @GetMapping("/cancella")
    void cancellaAnnuncio(@RequestParam String id, HttpSession sessione) {
        Utente utenteCorrente = utenteCorrente(sessione);
        Utente daEliminare = DBManager.getInstance().getUtenteDao().findById(id);
        if (!utenteCorrente.getRuolo().equals("AMMINISTRATORE"))
            throw new RuntimeException("Utente non abilitato a cancellare utenti :" + utenteCorrente.getIdUtente());
        if (daEliminare == null)
            throw new RuntimeException("L'utente " + id + " non esiste");
        DBManager.getInstance().getUtenteDao().delete(daEliminare);
    }

    @GetMapping("/promuoviamministratore")
    public Boolean promuoviAmministratore(HttpSession sessione, @RequestParam String id, @RequestParam Boolean flag) {
        if (isUtenteCorrenteAmministratore(sessione)) {
            Utente u = DBManager.getInstance().getUtenteDao().findById(id);
            if (u != null) {
                if (flag)
                    u.setRuolo("AMMINISTRATORE");
                else
                    u.setRuolo("COMPRATORE");
                DBManager.getInstance().getUtenteDao().update(u);
                if (utenteCorrente(sessione).equals(u))
                    sessione.setAttribute("utenteLoggato", u);
                Logger.LOG("Utente " + id + " promosso amministratore! " + flag);
            } else {
                Logger.LOG("Impossibile promuovere l' utente " + id + ", non esiste!");
                throw new RuntimeException("L'utente non esiste");
            }
        }
        return false;
    }

    @GetMapping("/contattautente")
    public void contattaUtente(@RequestParam String destinatario, @RequestParam int idAnnuncio, @RequestParam String messaggio, HttpSession sessione) {
        if (utenteCorrente(sessione) == null)
            throw new RuntimeException("Utente non loggato!");

        Annuncio annuncio = DBManager.getInstance().getAnnuncioDao().findById(idAnnuncio);

        if (annuncio == null)
            throw new RuntimeException("Annuncio non esistente");

        GestoreEmail.inviaMail(destinatario, utenteCorrente(sessione), messaggio, annuncio);
    }

    private boolean isUtenteCorrenteBannato(HttpSession sessione) {
        if (utenteCorrente(sessione) != null && utenteCorrente(sessione).getBannato())
            return true;
        return false;
    }

    private boolean isUtenteCorrenteAmministratore(HttpSession sessione) {
        if (utenteCorrente(sessione) != null && utenteCorrente(sessione).getRuolo().equals("AMMINISTRATORE") && !utenteCorrente(sessione).getBannato())
            return true;
        return false;
    }


}


package it.renthub.controller.webController;

import it.renthub.model.DBManager;
import it.renthub.model.bean.Utente;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
public class WebController {

    @GetMapping("/")
    public String homepage(HttpSession sessione) {
        if (isUtenteCorrenteBannato(sessione))
            return "bannato";
        return "homepage";
    }

    @GetMapping("/amministrazione")
    public String amministrazione(HttpSession sessione) {
        if (isUtenteCorrenteBannato(sessione))
            return "bannato";
        if (isUtenteCorrenteAmministratore(sessione)) {
            sessione.setAttribute("utenti", DBManager.getInstance().getUtenteDao().findAll());
            return "amministrazione";
        }

        return homepage(sessione);
    }

    private boolean isUtenteCorrenteBannato(HttpSession sessione) {
        Utente utenteLoggato = (Utente) sessione.getAttribute("utenteLoggato");
        if (utenteLoggato != null && utenteLoggato.getBannato())
            return true;
        return false;
    }

    private boolean isUtenteCorrenteAmministratore(HttpSession sessione) {
        Utente utenteLoggato = (Utente) sessione.getAttribute("utenteLoggato");
        if (utenteLoggato != null && utenteLoggato.getRuolo().equals("AMMINISTRATORE"))
            return true;
        return false;
    }


}

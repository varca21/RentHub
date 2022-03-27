package it.renthub.controller.webController;

import it.renthub.model.DBManager;
import it.renthub.model.bean.Annuncio;
import it.renthub.model.bean.Tipologia;
import it.renthub.model.bean.Utente;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

@Controller
public class
WebController {

    @GetMapping("/")
    public String homepage(HttpSession sessione) {
        if (isUtenteCorrenteBannato(sessione))
            return "bannato";
        sessione.setAttribute("tipologie", Tipologia.values());
        return "homepage";
    }

    @GetMapping("/amministrazione")
    public String amministrazione(HttpSession sessione) {
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
        if (utenteLoggato != null && !(isUtenteCorrenteBannato(sessione)) && utenteLoggato.getRuolo().equals("AMMINISTRATORE"))
            return true;
        return false;
    }

    @GetMapping("/annuncio/{idAnnuncio}")
    public String annuncio(@PathVariable String idAnnuncio, HttpSession sessione) {
        Annuncio a = DBManager.getInstance().getAnnuncioDao().findById(Integer.parseInt(idAnnuncio));
            if(a==null)
                return "annuncionontrovato";
            
        List<String> immagini = new ArrayList<>();
        StringTokenizer st = new StringTokenizer(a.getFoto(), ",");

        while (st.hasMoreTokens())
            immagini.add("/immagini/annunci/" + a.getIdAnnuncio() + "/" + st.nextToken());


        if (a != null) {
            sessione.setAttribute("annuncio", a);
            sessione.setAttribute("immagini", immagini);
            sessione.setAttribute("recensioni", DBManager.getInstance().getRecensioneDao().findByAnnuncio(a));
        }


        return "paginaProdotto";
    }

}

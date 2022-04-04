package it.renthub.controller.webController;

import it.renthub.model.DBManager;
import it.renthub.model.bean.Annuncio;
import it.renthub.model.bean.Tipologia;
import it.renthub.model.bean.Utente;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
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

    @GetMapping("/annuncio/{idAnnuncio}")
    public String annuncio(@PathVariable String idAnnuncio, HttpSession sessione) {
        if (isUtenteCorrenteBannato(sessione))
            return "bannato";


        Annuncio a = DBManager.getInstance().getAnnuncioDao().findById(Integer.parseInt(idAnnuncio));
        if (a == null)
            return "annuncionontrovato";

        List<String> immagini = new ArrayList<>();
        StringTokenizer st = new StringTokenizer(a.getFoto(), ",");

        while (st.hasMoreTokens())
            immagini.add("/immagini/annunci/" + a.getIdAnnuncio() + "/" + st.nextToken());


        if (a != null) {
            sessione.setAttribute("tipologie", Tipologia.values());
            sessione.setAttribute("annuncio", a);
            sessione.setAttribute("immagini", immagini);
            sessione.setAttribute("recensioni", DBManager.getInstance().getRecensioneDao().findByAnnuncio(a));
        }


        return "paginaAnnuncio";
    }


    @GetMapping("/cercaAnnuncio")
    public String cercaAnnuncio(@RequestParam(required = false) String testo, @RequestParam(required = false) String tipologia, @RequestParam(required = false) String citta, @RequestParam(required = false) String indirizzo, @RequestParam(required = false) String tipoVendita, HttpSession sessione) {
        if (isUtenteCorrenteBannato(sessione))
            return "bannato";

        List<Annuncio> ris = null;
        sessione.setAttribute("tipologie", Tipologia.values());
        if (StringUtils.isEmpty(citta)) {
            if (!StringUtils.isEmpty(tipologia))
                ris = DBManager.getInstance().getAnnuncioDao().findByTipologia(Tipologia.valueOf(tipologia));
            else
                ris = DBManager.getInstance().getAnnuncioDao().findAll();
        } else {
            if (StringUtils.isEmpty(tipologia))
                ris = DBManager.getInstance().getAnnuncioDao().findByCitta(citta);
            else
                ris = DBManager.getInstance().getAnnuncioDao().findByTipologiaCitta(Tipologia.valueOf(tipologia), citta);
        }

        if (!StringUtils.isEmpty(indirizzo))
            ris.removeIf(x -> !x.getPosizione().getIndirizzo().toLowerCase(Locale.ROOT).contains(indirizzo));

        if (!StringUtils.isEmpty(testo))
            ris.removeIf(x -> !x.getTitolo().toLowerCase(Locale.ROOT).contains(testo.toLowerCase(Locale.ROOT)));

        if (!StringUtils.isEmpty(tipoVendita)) {
            if (tipoVendita.toLowerCase(Locale.ROOT).equals("vendita"))
                ris.removeIf(x -> x.isAffitto());
            if (tipoVendita.toLowerCase(Locale.ROOT).equals("affitto"))
                ris.removeIf(x -> !x.isAffitto());
        }

        if (ris == null)
            return "annuncionontrovato";


        sessione.setAttribute("risultatiRicerca", ris);

        return ("risultatiricerca");


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
}

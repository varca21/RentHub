package it.renthub;

import it.renthub.model.DBManager;
import it.renthub.model.bean.Annuncio;
import it.renthub.model.bean.Posizione;
import it.renthub.model.bean.Tipologia;
import it.renthub.model.bean.Utente;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@SpringBootTest
class RentHubApplicationTests {

    @Test
    void contextLoads() {
    }

    @Test
    void test() {
        List<Utente> utenti = DBManager.getInstance().getUtenteDao().findAll();
        for (Utente it : utenti) {
            System.out.println(it);
        }

    }

    @Test
    void test2() throws ParseException {
        Utente u = new Utente();
        u.setIdUtente("42");
        u.setNome("francesco");
        u.setCognome("curcio");
        u.setPassword("compra");
        u.setEmail("varca");
        u.setRuolo("COMPRATORE");
        u.setDataNascita(new SimpleDateFormat("yy/MM/dd").parse("2010/10/9"));
        DBManager.getInstance().getUtenteDao().save(u);
    }

    @Test
    void test222(){
        Annuncio a = DBManager.getInstance().getAnnuncioDao().findById(10);
        a.setAffitto(true);
        DBManager.getInstance().getAnnuncioDao().update(a);
        System.out.println(DBManager.getInstance().getAnnuncioDao().findById(10));
    }

}

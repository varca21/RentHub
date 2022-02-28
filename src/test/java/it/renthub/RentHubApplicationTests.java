package it.renthub;

import it.renthub.model.DBManager;
import it.renthub.model.bean.Utente;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

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
    void test2() {
        Utente u = new Utente();
        u.setIdUtente("2423433432432");
        u.setNome("francesco");
        u.setCognome("curcio");
        u.setPassword("compra");
        u.setEmail("varca");
        u.setRuolo("COMPRATORE");
        DBManager.getInstance().getUtenteDao().save(u);
    }

}

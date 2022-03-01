package it.renthub.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;

@Service
@PropertySource(value = "classpath:/database.properties")
public class Config {

    public static String IP;
    public static String USER;
    public static String PASSWORD;
    public static String DBNAME;
    public static String PORTA;

    @Autowired
    public Config(@Value("${url}") String URL, @Value("${dbname}") String DBNAME, @Value("${user}") String USER, @Value("${password}") String PASSWORD, @Value("${porta}") String PORTA) {
        this.IP = URL;
        this.USER = USER;
        this.PASSWORD = PASSWORD;
        this.DBNAME = DBNAME;
        this.PORTA = PORTA;
    }


}

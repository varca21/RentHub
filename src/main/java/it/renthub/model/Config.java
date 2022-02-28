package it.renthub.model;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

@Component
@PropertySource(value = "classpath:/database.properties")
public class Config {

    public static String url;
    public static String db;
    public static String password;

    @Value("${url}")
    public static void setUrl(String url) {
        Config.url = url;
    }

    @Value("${db}")
    public static void setDb(String db) {
        Config.db = db;
    }

    @Value("${password}")
    public static void setPassword(String password) {
        Config.password = password;
    }
}

package it.renthub.util.email;

import it.renthub.Logger;
import it.renthub.model.bean.Annuncio;
import it.renthub.model.bean.Utente;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import java.util.Properties;

public class GestoreEmail {


    private static String SMTP_HOST_NAME = "smtp.gmail.com";
    private static String SMTP_AUTH_USER = "renthub2022@gmail.com";
    private static final String SMTP_AUTH_PWD = "anrdygfrnllmnpcn";

    private static Properties prop = new Properties();


    public static Session session = Session.getInstance(prop, new Authenticator() {
        @Override
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(SMTP_AUTH_USER, SMTP_AUTH_PWD);
        }
    });


    static {
        System.out.println("entroooo");
        prop.put("mail.smtp.host", SMTP_HOST_NAME);
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true");
    }

    public static void inviaMail(String destinatario, Utente mittente, String messaggio, Annuncio annuncio) {
        TrustManager[] trustAllCerts = new TrustManager[]{
                new X509TrustManager() {
                    public java.security.cert.X509Certificate[] getAcceptedIssuers() {
                        return null;
                    }
                    public void checkClientTrusted(
                            java.security.cert.X509Certificate[] certs, String authType) {
                    }
                    public void checkServerTrusted(
                            java.security.cert.X509Certificate[] certs, String authType) {
                    }
                }};

        try {
            SSLContext sc = SSLContext.getInstance("SSL");
            sc.init(null, trustAllCerts, new java.security.SecureRandom());
            HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
        } catch (Exception e) {
            Logger.LOG("PROBLEMA NELL'INVIO DELLE MAIL, PROBLEMA CON I CERTIFICATI SSL");
        }





        try {
            Message message = new MimeMessage(session);
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            message.setSubject(mittente.getIdUtente() + " sta cercando di contattarti su RentHub!");
            message.setText("hai ricevuto un messaggio da " + mittente.getIdUtente() + " in merito all'annuncio : " + annuncio.getTitolo() + " : \n \n"
                    + messaggio + "\n \n" + "puoi contattare "+mittente.getIdUtente()+" all'indirizzo email: " + mittente.getEmail());
            Transport.send(message);
            Logger.LOG("Inviata mail da " + mittente.getIdUtente() + " a " + destinatario);
        } catch (MessagingException e) {
            Logger.LOG("Problema nell'invio della mail di " + mittente.getIdUtente() + " a " + destinatario + " : \n" + e.toString());
        }
    }
}

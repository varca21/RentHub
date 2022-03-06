package it.renthub;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;


public class Logger {
    public static BufferedWriter bw;
    private static String path = "src/main/resources/log.txt";

    static {
        try {
            File file = new File(path);
            FileWriter fw = new FileWriter(file, true);
            bw = new BufferedWriter(fw);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void LOG(String log) {
        System.out.println(log);
        try {
            bw.write(LocalDateTime.now() + ":" + log + "\n");
            bw.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}

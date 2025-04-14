package utils;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBUtil {
    // Database credentials
    private static String url;
    private static String username;
    private static String password;

    //import db credentials form env file and load driver
    static {
        try (InputStream input = DBUtil.class.getClassLoader().getResourceAsStream("db.properties")) {
            // Load the config file
            Properties config = new Properties();
            if (input != null) {
                config.load(input);
                url = config.getProperty("db.url");
                username = config.getProperty("db.username");
                password = config.getProperty("db.password");
                String driver = config.getProperty("db.driver");
                Class.forName(driver);
            } else {
                throw new IOException("Configuration file 'db.properties' not found in the classpath");
            }
        } catch (IOException | ClassNotFoundException err) {
            err.printStackTrace();
        }
    }
    /* Create JDBC connection */
    public static Connection getConnection() {
        try {
            System.out.println("Connecting to database...");
            return DriverManager.getConnection(url, username, password);
        } catch (SQLException err) {
            err.printStackTrace();
        }
        return null;
    }

//    public static void main(String[] args) {
//        DBConnectionUtil util = new DBConnectionUtil();
//
//        Connection conn = util.getConnection();
//        if (conn != null) {
//            System.out.println("Connection established"+ conn);
//        }
//    }
}

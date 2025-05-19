package utils;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;
import org.apache.commons.dbcp2.BasicDataSource;

public class DBUtil {
    private static BasicDataSource dataSource;
    private static boolean initialized = false;

    static {
        initialize();
    }

    private static void initialize() {
        if (initialized) return;
        
        System.out.println("DBUtil: Starting database initialization");
        try (InputStream input = DBUtil.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (input == null) {
                String error = "DBUtil: Configuration file 'db.properties' not found in the classpath";
                System.err.println(error);
                throw new RuntimeException(error);
            }

            Properties config = new Properties();
            config.load(input);
            
            String url = config.getProperty("db.url");
            String username = config.getProperty("db.username");
            String password = config.getProperty("db.password");
            String driver = config.getProperty("db.driver");

            System.out.println("DBUtil: Loaded configuration:");
            System.out.println("DBUtil: URL: " + url);
            System.out.println("DBUtil: Username: " + username);
            System.out.println("DBUtil: Driver: " + driver);

            if (url == null || username == null || password == null || driver == null) {
                String error = "DBUtil: Missing required database configuration properties";
                System.err.println(error);
                throw new RuntimeException(error);
            }

            // Initialize connection pool
            dataSource = new BasicDataSource();
            dataSource.setUrl(url);
            dataSource.setUsername(username);
            dataSource.setPassword(password);
            dataSource.setDriverClassName(driver);

            // Set connection pool properties
            dataSource.setInitialSize(Integer.parseInt(config.getProperty("db.pool.initialSize", "5")));
            dataSource.setMinIdle(Integer.parseInt(config.getProperty("db.pool.minIdle", "5")));
            dataSource.setMaxIdle(Integer.parseInt(config.getProperty("db.pool.maxIdle", "10")));
            dataSource.setMaxTotal(Integer.parseInt(config.getProperty("db.pool.maxActive", "20")));
            dataSource.setMaxWaitMillis(Long.parseLong(config.getProperty("db.pool.maxWait", "10000")));
            dataSource.setTestOnBorrow(Boolean.parseBoolean(config.getProperty("db.pool.testOnBorrow", "true")));
            dataSource.setTestWhileIdle(Boolean.parseBoolean(config.getProperty("db.pool.testWhileIdle", "true")));
            dataSource.setTimeBetweenEvictionRunsMillis(Long.parseLong(config.getProperty("db.pool.timeBetweenEvictionRunsMillis", "30000")));
            dataSource.setMinEvictableIdleTimeMillis(Long.parseLong(config.getProperty("db.pool.minEvictableIdleTimeMillis", "60000")));
            dataSource.setValidationQuery(config.getProperty("db.pool.validationQuery", "SELECT 1"));

            initialized = true;
            System.out.println("DBUtil: Database connection pool initialized successfully");
            
        } catch (IOException e) {
            String error = "DBUtil: Failed to initialize database connection: " + e.getMessage();
            System.err.println(error);
            e.printStackTrace();
            throw new RuntimeException(error, e);
        }
    }

    public static Connection getConnection() throws SQLException {
        if (!initialized) {
            System.out.println("DBUtil: Database not initialized, initializing now...");
            initialize();
        }
        
        try {
            System.out.println("DBUtil: Getting connection from pool...");
            Connection conn = dataSource.getConnection();
            if (conn == null) {
                String error = "DBUtil: Failed to get database connection from pool";
                System.err.println(error);
                throw new SQLException(error);
            }
            System.out.println("DBUtil: Successfully got connection from pool");
            return conn;
        } catch (SQLException e) {
            String error = "DBUtil: Database connection error: " + e.getMessage();
            System.err.println(error);
            e.printStackTrace();
            throw e;
        }
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

package config;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

@WebListener
public class DatabaseContextListener implements ServletContextListener {
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        
        try {
            // Load database properties
            Properties dbProps = new Properties();
            InputStream input = DatabaseContextListener.class.getClassLoader().getResourceAsStream("db.properties");
            
            if (input == null) {
                throw new RuntimeException("Could not find db.properties in classpath");
            }
            
            dbProps.load(input);
            input.close();
            
            // Get database properties
            String url = dbProps.getProperty("db.url");
            String username = dbProps.getProperty("db.username");
            String password = dbProps.getProperty("db.password");
            String driver = dbProps.getProperty("db.driver");
            
            // Validate properties
            if (url == null || username == null || password == null || driver == null) {
                throw new RuntimeException("Missing required database properties in db.properties");
            }
            
            // Register JDBC driver
            Class.forName(driver);
            
            // Create database connection
            Connection conn = DriverManager.getConnection(url, username, password);
            
            // Store connection in ServletContext
            context.setAttribute("DBConnection", conn);
            
            System.out.println("DatabaseContextListener: Database connection initialized successfully!");
            
        } catch (Exception e) {
            String errorMsg = "DatabaseContextListener: Failed to initialize database connection: " + e.getMessage();
            System.err.println(errorMsg);
            e.printStackTrace();
            throw new RuntimeException(errorMsg, e);
        }
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try {
            ServletContext context = sce.getServletContext();
            Connection conn = (Connection) context.getAttribute("DBConnection");
            if (conn != null && !conn.isClosed()) {
                conn.close();
                System.out.println("DatabaseContextListener: Database connection closed successfully!");
            }
        } catch (Exception e) {
            System.err.println("DatabaseContextListener: Error closing database connection: " + e.getMessage());
            e.printStackTrace();
        }
    }
} 
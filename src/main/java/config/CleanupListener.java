package config;

import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;

@WebListener
public class CleanupListener implements ServletContextListener {

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try {
            // Unregister JDBC drivers manually
            Enumeration<java.sql.Driver> drivers = DriverManager.getDrivers();
            while (drivers.hasMoreElements()) {
                java.sql.Driver driver = drivers.nextElement();
                DriverManager.deregisterDriver(driver);
            }

            // Shutdown the cleanup thread
            System.out.println("App shutting down — Listener destroyed.");
            AbandonedConnectionCleanupThread.checkedShutdown();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("App started — Listener initialized.");
    }
}

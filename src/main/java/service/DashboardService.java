package service;

import dao.DashboardDAO;
import model.DashboardStats;
import java.sql.SQLException;

public class DashboardService {
    private DashboardDAO dashboardDAO;

    public DashboardService() {
        this.dashboardDAO = new DashboardDAO();
    }

    public DashboardStats getDashboardStats() {
        try {
            return dashboardDAO.getDashboardStats();
        } catch (SQLException e) {
            e.printStackTrace();
            // Return empty stats in case of error
            return new DashboardStats();
        }
    }
} 
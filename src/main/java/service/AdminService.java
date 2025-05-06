package service;

import dao.IAdminDAO;
import model.Admin;
import org.mindrot.jbcrypt.BCrypt;
import utils.StatusCode;

import java.util.List;
import java.util.UUID;

public class AdminService implements IAdminService {
    private final IAdminDAO adminDAO;

    public AdminService(IAdminDAO adminDAO) {
        this.adminDAO = adminDAO;
    }

    public StatusCode registerAdmin(String name, String email, String password) {
        // Check if email already exists
        if (adminDAO.getAdminByEmail(email) != null) {
            return StatusCode.EMAIL_ALREADY_EXISTS;
        }

        // Create admin from registration data
        Admin admin = new Admin();
        admin.setAdminId(UUID.randomUUID());
        admin.setEmail(email);
        admin.setPasswordHash(BCrypt.hashpw(password, BCrypt.gensalt()));
        admin.setRole("ADMIN");
        admin.setActive(true);
        admin.setLastLogin(null);
        admin.setPfp(null);

        return adminDAO.addAdmin(admin);
    }

    @Override
    public Admin login(String email, String password) {
        Admin admin = adminDAO.getAdminByEmail(email);
        if (admin != null && BCrypt.checkpw(password, admin.getPasswordHash())) {
            return admin;  // Login successful
        }
        return null;  // Invalid credentials
    }

    @Override
    public void updateLastLogin(String adminId) {
        Admin admin = adminDAO.getAdminById(UUID.fromString(adminId));
        if (admin != null) {
            admin.setLastLogin(new java.sql.Date(System.currentTimeMillis()));
            adminDAO.updateAdmin(admin);
        }
    }

    @Override
    public Admin getAdminById(String adminId) {
        return adminDAO.getAdminById(UUID.fromString(adminId));
    }

    @Override
    public List<Admin> getAllAdmins() {
        return adminDAO.getAllAdmins();
    }

    @Override
    public void changeRole(String adminId, String newRole) {
        Admin admin = adminDAO.getAdminById(UUID.fromString(adminId));
        if (admin != null) {
            admin.setRole(newRole);
            adminDAO.updateAdmin(admin);
        }
    }
} 
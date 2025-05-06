package service;

import model.Admin;

import java.util.List;

public interface IAdminService {
    Admin login(String email, String password);
    void updateLastLogin(String adminId);
    Admin getAdminById(String adminId);
    List<Admin> getAllAdmins();
    void changeRole(String adminId, String newRole);
}


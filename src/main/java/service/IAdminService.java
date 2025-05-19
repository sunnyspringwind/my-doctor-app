package service;

import model.Admin;
import utils.StatusCode;

import java.util.List;

public interface IAdminService {
    StatusCode registerAdmin(String name, String email, String password);
    Admin login(String email, String password);
    void updateLastLogin(String adminId);
    Admin getAdminById(String adminId);
    List<Admin> getAllAdmins();
    void changeRole(String adminId, String newRole);
}


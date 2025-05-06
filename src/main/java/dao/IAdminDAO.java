package dao;

import model.Admin;
import utils.StatusCode;

import java.util.List;
import java.util.UUID;

public interface IAdminDAO {
    StatusCode addAdmin(Admin admin);
    Admin getAdminById(UUID adminId);
    Admin getAdminByEmail(String email);
    List<Admin> getAllAdmins();
    boolean updateAdmin(Admin admin);
    boolean updateAdminPassword(UUID adminId, String oldPassword, String newPassword);
    boolean deleteAdmin(UUID adminId);
} 
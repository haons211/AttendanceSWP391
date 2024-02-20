/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import models.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author Admin
 */
public class ApplicationDAO extends DBContext {

    public List<TypeApplication> GetAllTypeAllications() {
        List<TypeApplication> list = new ArrayList<>();
        String sql = "select * from type_application";
        try (Connection con = super.getConnection(); PreparedStatement st = con.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                TypeApplication t = new TypeApplication(rs.getInt("type_id"), rs.getString("name"));
                list.add(t);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public void insertApplication(Application application) {
        String sql = "INSERT INTO Application (sender_id, type_id, receiver_id, file, title, content, status, create_date, complete_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = super.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
            st.setInt(1, application.getSender_id());
            st.setInt(2, application.getType_id());
            st.setInt(3, application.getReceiver_id());
            st.setString(4, application.getFile());
            st.setString(5, application.getTitle());
            st.setString(6, application.getContent());
            st.setString(7, application.getStatus());
            st.setDate(8, new java.sql.Date(application.getCreate_date().getTime()));
            if (application.getComplete_date() != null) {
                st.setDate(9, new java.sql.Date(application.getComplete_date().getTime()));
            } else {
                st.setNull(9, java.sql.Types.DATE);
            }
            st.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }


    public int GetEmployeeIDbyUserID(AccountDTO accountDto0) {

        int employeeId = -1;
        String sql = "SELECT employee_id FROM employee WHERE user_id = ?";
        Connection con = null;
        try {
            con = super.getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, accountDto0.getUserID());
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                employeeId = rs.getInt("employee_id");
            }
        } catch (Exception e) {
            System.out.println(e);
            throw new RuntimeException("Error when getting employee ID", e);
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return employeeId;
    }

    public List<ManagerDTO> GetAllManagers() {
        List<ManagerDTO> list = new ArrayList<>();
        String sql = "select * from employee e join users u on e.user_id=u.user_id where role_id=3";
        try (Connection con = super.getConnection(); PreparedStatement st = con.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                ManagerDTO d = new ManagerDTO(rs.getInt("employee_id"), rs.getString("name"), rs.getInt("role_id"));
                list.add(d);
            }
        } catch (SQLException e) {
            System.out.println("Error while accessing the database: " + e.getMessage());
        } catch (Exception e) {
            System.out.println("Unexpected error: " + e.getMessage());
        }
        return list;
    }

    public List<ApplicationDTO> getAllApplicationbySenderId(int sender_id) {
        List<ApplicationDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM application a JOIN type_application t ON a.type_id = t.type_id WHERE a.sender_id=?";
        Connection con = null;
        try {
            con = super.getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, sender_id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ApplicationDTO app = new ApplicationDTO();
                app.setApplication_id(rs.getInt("application_id"));
                app.setType_name(rs.getString("name"));
                app.setTitle(rs.getString("title"));
                app.setCreate_date(rs.getDate("create_date"));
                app.setStatus(rs.getString("status"));
                app.setContent(rs.getString("content"));
                app.setComplete_date(rs.getDate("complete_date"));
                list.add(app);
            }
        } catch (SQLException e) {
            System.out.println(e);
            throw new RuntimeException("Error when getting all applications by sender ID", e);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return list;
    }


    public List<ApplicationDTO> getAllApplicationbyReceiverId(int receiver_id) {

        return null;

    }



    public ApplicationDTO getApplicationById(int applicationId) throws ClassNotFoundException {
        String sql = "SELECT " +
                "    a.application_id, " +
                "    ta.name AS type_name, " +
                "    a.title, " +
                "    e1.name AS sender_name, " +
                "    e2.name AS receiver_name, " +
                "    a.create_date, " +
                "    a.status, " +
                "    a.content, " +
                "    a.file, " +
                "    a.complete_date " +
                "FROM " +
                "    application AS a " +
                "    INNER JOIN type_application AS ta ON a.type_id = ta.type_id " +
                "    INNER JOIN employee AS e1 ON a.sender_id = e1.employee_id " +
                "    INNER JOIN employee AS e2 ON a.receiver_id = e2.employee_id " +
                "WHERE " +
                "    a.application_id=?";
        ApplicationDTO applicationDTO = null;
        try (Connection con = super.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
            st.setInt(1, applicationId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    applicationDTO = new ApplicationDTO();
                    applicationDTO.setApplication_id(rs.getInt("application_id"));
                    applicationDTO.setType_name(rs.getString("type_name")); // Sửa tên cột truy vấn từ "name" thành "type_name"
                    applicationDTO.setTitle(rs.getString("title"));
                    applicationDTO.setSender_name(rs.getString("sender_name")); // Thêm phương thức để lấy sender_name
                    applicationDTO.setReceiver_name(rs.getString("receiver_name")); // Thêm phương thức để lấy receiver_name
                    applicationDTO.setCreate_date(rs.getDate("create_date"));
                    applicationDTO.setStatus(rs.getString("status"));
                    applicationDTO.setContent(rs.getString("content"));
                    applicationDTO.setFile(rs.getString("file"));
                    applicationDTO.setComplete_date(rs.getDate("complete_date"));
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi xảy ra khi thực thi truy vấn SQL: " + e.getMessage());
            e.printStackTrace();
        }
        return applicationDTO;
    }

    public static void main(String[] args) {
        try {
            ApplicationDAO applicationDAO = new ApplicationDAO();
            int applicationIdToRetrieve = 1;
            ApplicationDTO applicationDTO = applicationDAO.getApplicationById(applicationIdToRetrieve);

            if (applicationDTO != null) {
                System.out.println("Thông tin ứng dụng có ID " + applicationIdToRetrieve + ":");
                System.out.println("Type Name: " + applicationDTO.getType_name());
                System.out.println("Title: " + applicationDTO.getTitle());
                System.out.println("Create Date: " + applicationDTO.getCreate_date());
                System.out.println("Status: " + applicationDTO.getStatus());
                System.out.println("Content: " + applicationDTO.getContent());
                System.out.println("File: " + applicationDTO.getFile());
                System.out.println("Complete Date: " + applicationDTO.getComplete_date());
            } else {
                System.out.println("Không tìm thấy ứng dụng có ID " + applicationIdToRetrieve);
            }
        } catch (ClassNotFoundException e) {
            System.out.println("Không thể tìm thấy lớp cần thiết: " + e.getMessage());
        }
    }

    public void DeleteApplication(int applicationId) {
        String sql = "DELETE FROM application WHERE application_id = ?";
        try (Connection con = super.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
            // Set the application_id parameter
            st.setInt(1, applicationId);
            // Execute the delete statement
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error deleting application: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

}




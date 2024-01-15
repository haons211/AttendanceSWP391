/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import models.AccountDTO;
import models.AccountDTO;
import models.Application;
import models.ManagerDTO;
import models.TypeApplication;


/**
 *
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
        String sql = "INSERT INTO Application (sender_id, type_id, receiver_id, file, reason, status, create_date, complete_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = super.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
            st.setInt(1, application.getSender_id());
            st.setInt(2, application.getType_id());
            st.setInt(3, application.getReceiver_id());
            st.setString(4, application.getFile());
            st.setString(5, application.getReason());
            st.setString(6, application.getStatus());
            st.setDate(7, new java.sql.Date(application.getCreate_date().getTime()));
            if (application.getComplete_date() != null) {
                st.setDate(8, new java.sql.Date(application.getComplete_date().getTime()));
            } else {
                st.setNull(8, java.sql.Types.DATE);
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
        try (Connection con = super.getConnection(); 
             PreparedStatement st = con.prepareStatement(sql); 
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                ManagerDTO d= new ManagerDTO(rs.getInt("employee_id"), rs.getString("name"), rs.getInt("role_id"));
                list.add(d);
            }
        } catch (SQLException e) {
            System.out.println("Error while accessing the database: " + e.getMessage());
        } catch (Exception e) {
            System.out.println("Unexpected error: " + e.getMessage());
        }
        return list;
    }



}

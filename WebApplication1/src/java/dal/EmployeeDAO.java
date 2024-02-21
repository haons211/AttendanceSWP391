/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package truong.dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Employee;

/**
 *
 * @author Dan
 */
public class EmployeeDAO extends DBContext {

    public void addEmployee(String name,
            String phoneNumber,
            String address,
            String email,
            String gender,
            String image,
            String birthDate,
            String hireDate,
            int userId
    ) throws ClassNotFoundException {

        try {

            String sql = "INSERT INTO employee "
                    + "(name, phoneNumber, address, email, gender, image, birth_date, hire_date, user_id) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stm = connection.prepareStatement(sql);

            stm.setString(1, name);
            stm.setString(2, phoneNumber);
            stm.setString(3, address);
            stm.setString(4, email);
            stm.setString(5, gender);
            stm.setString(6, image);
            stm.setString(7, birthDate);
            stm.setString(8, hireDate);
            stm.setInt(9, userId);

            stm.executeUpdate();

        } catch (SQLException e) {

        }
    }

    public List<Employee> getAllEmployees() {
        List<Employee> list = new ArrayList<>();
        String sql = "select * from employee";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Employee(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getBoolean(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getInt(10)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public Employee getEmployeeById(int id) {
        String sql = "select * from employee where employee_id = ?";
        Employee employee = new Employee();
        try {

            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            stm.setInt(1, id);

            while (rs.next()) {
                employee = new Employee(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getBoolean(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getInt(10)
                );
            }
        } catch (Exception e) {
        }
        return employee;
    }

    public void updateEmployee(Employee employee) throws ClassNotFoundException {
        try {
            String sql = ""
                    + "UPDATE employee SET name=?, "
                    + "phoneNumber=?, address=?, email=?, "
                    + "gender=?, "
                    + "image=?, "
                    + "birth_date=?, hire_date=?,"
                    + " WHERE employee_id=?";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, employee.getName());
            stm.setString(2, employee.getPhoneNumber());
            stm.setString(3, employee.getAddress());
            stm.setString(4, employee.getEmail());
            stm.setString(5, employee.isGender());
            stm.setString(6, employee.getImage());
            stm.setString(7, employee.getBirthDate());
            stm.setString(8, employee.getHireDate());
            stm.setInt(9, employee.getUserId());
            stm.setInt(10, employee.getEmployeeId());

            stm.executeUpdate();

        } catch (SQLException e) {
            Logger.getLogger(EmployeeDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public void deleteEmployee(int id) throws ClassNotFoundException {
        try {
            String sql = "  DELETE FROM employee WHERE employee_id =?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(EmployeeDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public List<Employee> getAllEmployees(String search) {
        List<Employee> list = new ArrayList<>();
        String sql = "  select *  from employee where name like ? order by employee_id asc";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Employee(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getBoolean(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getInt(10)
                )
                );
            }
        } catch (Exception e) {
        }
        return list;
    }
    
}

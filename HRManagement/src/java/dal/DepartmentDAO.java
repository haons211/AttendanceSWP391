/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import models.Department;

/**
 *
 * @author ThuyVy
 */
public class DepartmentDAO {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public int getNumberOfDepartments() {
        int numberOfDepartments = 0;
        String query = "SELECT COUNT(*) FROM department";

        try {
            // Connect to the database
            con = new DBContext().getConnection();

            // Prepare the query
            ps = con.prepareStatement(query);

            // Execute the query
            rs = ps.executeQuery();

            // Process the query result
            if (rs.next()) {
                numberOfDepartments = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
        return numberOfDepartments;
    }

    public ArrayList<Department> getAllDepartments(String search) {
        ArrayList<Department> list = new ArrayList<>();
        String query = "SELECT department_id, name FROM department WHERE name LIKE ? ORDER BY department_id ASC";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, "%" + search + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Department(rs.getInt("department_id"), rs.getString("name")));
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
        return list;
    }

    public boolean isDepartmentIdExists(int id) {
        String query = "SELECT COUNT(*) FROM department WHERE department_id = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
        return false;
    }

    public void addDepartment(int id, String name) {
        if (isDepartmentIdExists(id)) {
            System.out.println("Department with ID " + id + " already exists.");
            return;
        }
        String query = "INSERT INTO department (department_id, name) VALUES (?, ?)";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            ps.setString(2, name);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
    }

    public String updateDepartment(int id, String name) {
        String query = "UPDATE department SET name = ? WHERE department_id = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, name);
            ps.setInt(2, id);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                return "Update successfully!";
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
        return "Update failed";
    }

    public void deleteDepartment(int id) {
        String query = "DELETE FROM department WHERE department_id = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
    }

    public Department getDepartmentById(int departmentID) {
        String query = "SELECT * FROM department WHERE department_id = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, departmentID);
            rs = ps.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("department_id");
                String name = rs.getString("name");
                return new Department(id, name);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
        return null;
    }

    // Other methods for department operations

    private void closeResources() {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

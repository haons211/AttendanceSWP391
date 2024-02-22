/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import context.DBContext;
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
        String query = "SELECT department_id, name, dep_code FROM department WHERE name LIKE ? ORDER BY department_id ASC";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, "%" + search + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Department(rs.getInt("department_id"), rs.getString("name"), rs.getString("dep_code")));
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

    public boolean isDepartmentCodeExists(String code) {
        String query = "SELECT COUNT(*) FROM department WHERE BINARY dep_code = ?";
        try {
            con = DBContext.getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, code);
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
    
    public boolean isDepartmentCodeExists(String code, int departmentIdToExclude) {
    String query = "SELECT COUNT(*) FROM department WHERE BINARY dep_code = ? AND department_id != ?";
    try {
        con = DBContext.getConnection();
        ps = con.prepareStatement(query);
        ps.setString(1, code);
        ps.setInt(2, departmentIdToExclude);
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


    public void addDepartment(String code, String name) {
        if (isDepartmentCodeExists(code)) {
            System.out.println("Department with Code " + code + " already exists.");
            return;
        }
        String query = "INSERT INTO department (name, dep_code) VALUES (?, ?)";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, code);
            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                // Get the auto-generated department_id (if it's an auto-increment column)
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int department_id = generatedKeys.getInt(1);
                        System.out.println("Department added with ID: " + department_id);
                    } else {
                        System.out.println("Department added, but couldn't retrieve department_id.");
                    }
                }
            } else {
                System.out.println("Failed to add department.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
    }


public void updateDepartment(int id, String name, String code) {
        String query = "UPDATE department SET name = ?, dep_code = ? WHERE department_id = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, code);
            ps.setInt(3, id);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Update successfully!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
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
                String code = rs.getString("dep_code");
                
                return new Department(id, name,code);
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

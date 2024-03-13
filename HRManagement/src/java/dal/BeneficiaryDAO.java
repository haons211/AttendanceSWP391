/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Dependents;

/**
 *
 * @author andep
 */
public class BeneficiaryDAO {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

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
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<Dependents> getBeneficiaryByEmployeeID(int employeeId,
            String name, String relationship, Date fromDate, Date toDate) {
        ArrayList<Dependents> beneficiaries = new ArrayList<>();
        String query = "SELECT * FROM dependents WHERE employee_id = ? ";

        // Add condition to filter by name
        if (name != null && !name.isEmpty()) {
            query += "AND name LIKE ? ";
        }

        // Add condition to filter by relationship
        if (relationship != null && !relationship.isEmpty()) {
            query += "AND relationship LIKE ? ";
        }

        // Add condition to filter by date
        if (fromDate != null && toDate != null) {
            query += "AND date_of_birth BETWEEN ? AND ? ";
        }

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, employeeId);

            int paramIndex = 2;

            // Set corresponding parameter if there is a name filtering condition
            if (name != null && !name.isEmpty()) {
                ps.setString(paramIndex++, "%" + name + "%");
            }

            // Set corresponding parameter if there is a relationship filtering condition
            if (relationship != null && !relationship.isEmpty()) {
                ps.setString(paramIndex++, "%" + relationship + "%");
            }

            // Set corresponding parameter if there is a date filtering condition
            if (fromDate != null && toDate != null) {
                ps.setDate(paramIndex++, new java.sql.Date(fromDate.getTime()));
                ps.setDate(paramIndex++, new java.sql.Date(toDate.getTime()));
            }
            rs = ps.executeQuery();

            while (rs.next()) {
                // Create a new Dependents object and add it to the list of beneficiaries
                Dependents dependent = new Dependents(rs.getInt("dependent_id"),
                        rs.getInt("employee_id"),
                        rs.getString("name"),
                        rs.getBoolean("gender"),
                        rs.getString("date_of_birth"),
                        rs.getString("relationship")
                );

                beneficiaries.add(dependent);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        } finally {
            // Close resources
            closeResources();
        }

        return beneficiaries;
    }

    public void deleteBeneficiary(int id) {
        String query = "DELETE FROM dependents WHERE dependent_id = ?";
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

    public void addBeneficiary(int id_employee, String name, boolean gender, String dob, String relationship) {
        String query = "INSERT INTO dependents (employee_id, name, gender, date_of_birth, relationship) VALUES (?, ?, ?, ?, ?)";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, id_employee);
            ps.setString(2, name);
            ps.setBoolean(3, gender); // Sử dụng giá trị boolean trực tiếp
            ps.setString(4, dob);
            ps.setString(5, relationship);

            ps.executeUpdate();
            System.out.println("Beneficiary added successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        } finally {
            closeResources();
        }
    }

    public void updateBeneficiary(int dependentId, int employeeId, String name, boolean gender, String dateOfBirth, String relationship) {
        String query = "UPDATE dependents SET employee_id = ?, name = ?, gender = ?, date_of_birth = ?, relationship = ? WHERE dependent_id = ?";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, employeeId);
            ps.setString(2, name);
            ps.setBoolean(3, gender);
            ps.setString(4, dateOfBirth);
            ps.setString(5, relationship);
            ps.setInt(6, dependentId);

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Beneficiary updated successfully.");
            } else {
                System.out.println("Failed to update beneficiary.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        } finally {
            closeResources();
        }
    }

    public Dependents getBeneficiaryByID(int id) {
        Dependents beneficiary = null;
        String query = "SELECT * FROM dependents WHERE dependent_id = ?";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                beneficiary = new Dependents(
                        rs.getInt("dependent_id"),
                        rs.getInt("employee_id"),
                        rs.getString("name"),
                        rs.getBoolean("gender"),
                        rs.getString("date_of_birth"),
                        rs.getString("relationship")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        } finally {
            closeResources();
        }

        return beneficiary;
    }

}

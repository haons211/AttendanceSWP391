/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import models.Company;
import models.Department;
import models.Employee;

/**
 *
 * @author Dan
 */
public class CompanyDAO {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public void updateCompany(Company company, int companyID) {
        String query = "UPDATE company "
                + "SET company_name = ?, "
                + "address = ?, "
                + "email = ?, "
                + "phone_number = ?, "
                + "fax = ?, "
                + "website = ?, "
                + "employee_id = ?, "
                + "department_id = ? "
                + "WHERE company_id = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, company.getCompanyName());
            ps.setString(2, company.getAddress());
            ps.setString(3, company.getEmail());
            ps.setString(4, company.getPhoneNumber());
            ps.setString(5, company.getFax());
            ps.setString(6, company.getWebsite());
            ps.setInt(7, company.getContactPerson());
            ps.setInt(8, company.getDepartment());
            ps.setInt(9, companyID);

            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
    }

    public Company getCompanyByID(int id) {
        String query = "SELECT * FROM company WHERE company_id = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                id = rs.getInt(1);
                String name = rs.getString(2);
                String address = rs.getString(3);
                String email = rs.getString(4);
                String phoneNumber = rs.getString(5);
                String fax = rs.getString(6);
                String website = rs.getString(7);
                int employee_id = rs.getInt(8);
                int deparment_id = rs.getInt(9);

                return new Company(id, name, address, email, phoneNumber, fax, website, employee_id, deparment_id);
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

    public Department getDepartmentByName(String departmentName) {
        String query = "SELECT * FROM department WHERE name = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, departmentName);
            rs = ps.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("department_id");
                String name = rs.getString("name");
                String code = rs.getString("dep_code");

                return new Department(id, name, code);
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

    public Employee getEmployeeByName(String name) throws ClassNotFoundException {
        String query = "SELECT * FROM employee WHERE name = ?";
        Employee employee = null;
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, name);
            rs = ps.executeQuery();
            if (rs.next()) {
                int employeeId = rs.getInt("employee_id");
                name = rs.getString("name");
                String phoneNumber = rs.getString("phoneNumber");
                String address = rs.getString("address");
                String email = rs.getString("email");
                boolean gender = rs.getBoolean("gender");
                String image = rs.getString("image");
                String birthDate = rs.getString("birth_date");
                String hireDate = rs.getString("hire_date");
                int userId = rs.getInt("user_id");
                double salary = rs.getDouble(11);
                employee = new Employee(employeeId, name, phoneNumber, address, email, gender, image, birthDate, hireDate, userId, salary);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
        return employee;
    }

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

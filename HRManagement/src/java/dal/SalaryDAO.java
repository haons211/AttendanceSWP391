/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import models.EmployeeSalary;
import context.DBContext;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.Salary;

/**
 *
 * @author Dan
 */
public class SalaryDAO {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public void addSalary(
            Salary salary
    ) throws SQLException {
        String query = "INSERT INTO salary (employee_id, department_id, "
                + "attendance_id, basic_salary, allowance, "
                + "tax, bonus, received_date, user_id) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, salary.getEmployeeId());
            ps.setInt(2, salary.getDepartmentId());
            ps.setInt(3, salary.getAttendanceId());
            ps.setDouble(4, salary.getBasicSalary());
            ps.setDouble(5, salary.getAllowance());
            ps.setDouble(6, salary.getTax());
            ps.setDouble(7, salary.getBonus());
            ps.setString(8, salary.getReceivedDate());
            ps.setInt(9, salary.getUserId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }

    }

    public Salary getSalaryById(int id) throws ClassNotFoundException {
        String query = "SELECT * FROM Salary WHERE salary_id = ?";
        Salary salary = null;
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                salary = new Salary(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getDouble(5),
                        rs.getDouble(6),
                        rs.getDouble(7),
                        rs.getDouble(8),
                        rs.getString(9),
                        rs.getInt(10),
                        rs.getDouble(11)
                );

            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
        return salary;
    }

    public void updateSalary(Salary e, int id) throws ClassNotFoundException {
        String query = "UPDATE salary SET basic_salary = ?,"
                + " allowance = ?, tax = ?, bonus = ? "
                + "WHERE salary_id = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setDouble(1, e.getBasicSalary());
            ps.setDouble(2, e.getAllowance());
            ps.setDouble(3, e.getTax());
            ps.setDouble(4, e.getBonus());
            ps.setInt(5, id);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
    }

    public void deleteSalary(int id) throws ClassNotFoundException {
        String query = "DELETE FROM salary WHERE salary_id = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);

            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
    }

    public List<EmployeeSalary> getAllSalary() throws ClassNotFoundException {
        List<EmployeeSalary> list = new ArrayList<>();
        EmployeeSalary employeeSalary = new EmployeeSalary();
        String query = "select s.salary_id,s.employee_id, s.department_id, s.attendance_id ,\n"
                + "basic_salary, allowance, tax, bonus, received_date, e.name, e.email, e.image, e.hire_date, d.name, total_salary\n"
                + "from salary s join employee e on s.employee_id = e.employee_id\n"
                + "join department d on d.department_id = s.department_id";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);

            rs = ps.executeQuery();
            while (rs.next()) {
                employeeSalary = new EmployeeSalary(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getDouble(5),
                        rs.getDouble(6),
                        rs.getDouble(7),
                        rs.getDouble(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getString(11),
                        rs.getString(12),
                        rs.getString(13),
                        rs.getString(14),
                        rs.getDouble(15)
                );
                list.add(employeeSalary);
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

    public boolean isUsernameExists(int id) {
        String query = "SELECT *\n"
                + "from salary s join employee e on s.employee_id = e.employee_id\n"
                + "join department d on d.department_id = s.department_id\n"
                + "join users u  on u.user_id= e.user_id\n"
                + "where s.user_id =  ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                if (count > 0) {
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý ngoại lệ nếu có lỗi xảy ra
        } finally {
            // Đóng tài nguyên
            closeResources();
        }
        return false;
    }

    public EmployeeSalary getEmployeeSalaryByUsername(String username) throws ClassNotFoundException {
        String query = "select s.salary_id,s.employee_id, s.department_id, s.attendance_id ,\n"
                + "basic_salary, allowance, tax, bonus, received_date, e.name, e.email, e.image, e.hire_date, d.name, total_salary\n"
                + "from salary s join employee e on s.employee_id = e.employee_id\n"
                + "join department d on d.department_id = s.department_id\n"
                + "join users u  on u.user_id= e.user_id\n"
                + "where username = ?";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, username);
            rs = ps.executeQuery();
            if (rs.next()) {
                EmployeeSalary employeeSalary = new EmployeeSalary(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getDouble(5),
                        rs.getDouble(6),
                        rs.getDouble(7),
                        rs.getDouble(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getString(11),
                        rs.getString(12),
                        rs.getString(13),
                        rs.getString(14),
                        rs.getDouble(15)
                );
                return employeeSalary;

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

    public EmployeeSalary getEmployeeSalaryById(int id) throws ClassNotFoundException {
        String query = "select s.salary_id,s.employee_id, s.department_id, s.attendance_id ,\n"
                + "basic_salary, allowance, tax, bonus, received_date, e.name, e.email, e.image, e.hire_date, d.name, total_salary\n"
                + "from salary s join employee e on s.employee_id = e.employee_id\n"
                + "join department d on d.department_id = s.department_id\n"
                + "join users u  on u.user_id= e.user_id\n"
                + "where s.salary_id = ?";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                EmployeeSalary employeeSalary = new EmployeeSalary(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getDouble(5),
                        rs.getDouble(6),
                        rs.getDouble(7),
                        rs.getDouble(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getString(11),
                        rs.getString(12),
                        rs.getString(13),
                        rs.getString(14),
                        rs.getDouble(15)
                );
                return employeeSalary;

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

    public EmployeeSalary getEmployeeSalaryByUserName1(String username) throws ClassNotFoundException {
        String query = "select e.employee_id, d.department_id, a.attendance_id , u.user_id, e.hire_date\n"
                + "from attendance a join employee e on a.employee_id = e.employee_id\n"
                + "join department d on d.department_id = a.department_id\n"
                + "join users u on u.user_id = e.user_id\n"
                + "where username = ?";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, username);
            rs = ps.executeQuery();
            if (rs.next()) {
                EmployeeSalary employeeSalary = new EmployeeSalary(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getString(5)
                        
                );
                return employeeSalary;

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

    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        SalaryDAO dao = new SalaryDAO();
        System.out.println(dao.getEmployeeSalaryByUsername("manageruser"));
    }
}

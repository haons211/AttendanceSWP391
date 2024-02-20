/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.Employee;

/**
 *
 * @author NCM
 */
public class EmployeeDAO {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public boolean updateIn4Information(int accid, String name, String phone, String email, String address, boolean gender, String birthdate) throws Exception {

        try {
            con = new dal.DBContext().getConnection();
            if (con != null) {
                // Tạo truy vấn SQL để cập nhật thông tin sinh viên
                String sql = "UPDATE employee SET name = ?, phoneNumber = ?, email = ?, address = ?, gender = ?, birth_date = ? WHERE user_id=?";
                ps = con.prepareStatement(sql);
                ps.setString(1, name);
                ps.setString(2, phone);
                ps.setString(3, email);
                ps.setString(4, address);
                ps.setBoolean(5, gender);
                ps.setString(6, birthdate);
                ps.setInt(7, accid);

                // Thực hiện truy vấn cập nhật
                int row = ps.executeUpdate();
                if (row > 0) {
                    return true;
                }
            }
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    public Employee getin4(int userId) throws SQLException, ClassNotFoundException {

        Employee em = null;

        try {
            // Kết nối cơ sở dữ liệu
            con = new dal.DBContext().getConnection();
            if (con != null) {
                // Câu truy vấn SQL với INNER JOIN
                String sql = "select e.* from users u join employee e on u.user_id=e.user_id where u.user_id=? ";

                // Tạo statement và thiết lập tham số
                ps = con.prepareStatement(sql);
                ps.setInt(1, userId);

                // Thực hiện câu truy vấn
                rs = ps.executeQuery();

                // Xử lý kết quả
                if (rs.next()) {
                    // Lấy dữ liệu từ ResultSet và tạo đối tượng Student

                    em = new Employee(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getBoolean(6), rs.getString(7), rs.getDate(8), rs.getDate(9), rs.getInt(10));
                    return em;
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace(); // Xử lý lỗi theo ý của bạn
        } finally {
            // Đóng các tài nguyên
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }

        return null;
    }

    public void addEmployee(String name,
            String phoneNumber,
            String address,
            String email,
            Boolean gender,
            String image,
            Date birthDate,
            Date hireDate) throws SQLException {
        String query = "INSERT INTO employee "
                + "(name, phoneNumber, address, email, gender, image, birth_date, hire_date) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, phoneNumber);
            ps.setString(3, address);
            ps.setString(4, email);
            ps.setBoolean(5, gender);
            ps.setString(6, image);
            ps.setDate(7, (java.sql.Date) birthDate);
            ps.setDate(8, (java.sql.Date) hireDate);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }

    }

    public Employee getEmployeeById(int id) throws ClassNotFoundException {
        String query = "SELECT * FROM employee WHERE employee_id = ?";
        Employee employee = null;
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                int employeeId = rs.getInt("employee_id");
                String name = rs.getString("name");
                String phoneNumber = rs.getString("phoneNumber");
                String address = rs.getString("address");
                String email = rs.getString("email");
                boolean gender = rs.getBoolean("gender");
                String image = rs.getString("image");
                Date birthDate = rs.getDate("birth_date");
                Date hireDate = rs.getDate("hire_date");
                int userId = rs.getInt("user_id");

                employee = new Employee(employeeId, name, phoneNumber, address, email, gender, image, birthDate, hireDate, userId);
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

    public void updateEmployee(Employee e, int id) throws ClassNotFoundException {
        String query = "UPDATE `swp`.`employee`\n"
                + "SET\n"
                + "\n"
                + "`name` = ?,\n"
                + "`phoneNumber` =?,\n"
                + "`address` = ?,\n"
                + "`email` = ?,\n"
                + "`gender` = ?,\n"
                + "`image` = ?,\n"
                + "`birth_date` = ?,\n"
                + "`hire_date` =?\n"
                + "WHERE `employee_id` = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, e.getName());
            ps.setString(2, e.getPhoneNumber());
            ps.setString(3, e.getAddress());
            ps.setString(4, e.getEmail());
            ps.setBoolean(5, e.isGender());
            ps.setString(6, e.toString());
            ps.setDate(7, e.getBirth_date());
            ps.setDate(8, e.getHire_date());
            ps.setInt(9, id);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
    }

    public void deleteEmployee(int id) throws ClassNotFoundException {
        String query = "  DELETE FROM employee WHERE employee_id =?";
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

    public List<Employee> getAllEmployees(String search) throws ClassNotFoundException {
        List<Employee> list = new ArrayList<>();
        String query = "SELECT * FROM employee WHERE name LIKE ? ORDER BY employee_id ASC";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, "%" + search + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                int employeeId = rs.getInt("employee_id");
                String name = rs.getString("name");
                String phoneNumber = rs.getString("phoneNumber");
                String address = rs.getString("address");
                String email = rs.getString("email");
                boolean gender = rs.getBoolean("gender");
                String image = rs.getString("image");
                Date birthDate = rs.getDate("birth_date");
                Date hireDate = rs.getDate("hire_date");
                int userId = rs.getInt("user_id");

                Employee employee = new Employee(employeeId, name, phoneNumber, address, email, gender, image, birthDate, hireDate, userId);
                list.add(employee);
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

    public int GetDepIDfromEmployee(int Employee_id) throws SQLException {
        int dep_id = -1; // Giá trị mặc định nếu không tìm thấy kết quả
        String query = "SELECT department_id FROM employeedepartment WHERE employee_id = ?";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, Employee_id);

            ResultSet rs = ps.executeQuery(); // Thực hiện truy vấn

            if (rs.next()) {
                // Lấy giá trị department_id từ kết quả truy vấn
                dep_id = rs.getInt("department_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý ngoại lệ nếu có
        } finally {
            closeResources(); // Đóng các tài nguyên kết nối
        }
        return dep_id; // Trả về giá trị department_id
    }
    
    public int GetRemainIDfromEmployee(int Employee_id) throws SQLException {
        int remain_id = -1; // Giá trị mặc định nếu không tìm thấy kết quả
        String query = "SELECT remainDay_id FROM remainday WHERE employee_id = ?";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, Employee_id);

            ResultSet rs = ps.executeQuery(); 

            if (rs.next()) {
                remain_id = rs.getInt("remainDay_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý ngoại lệ nếu có
        } finally {
            closeResources(); 
        }
        return remain_id; 
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

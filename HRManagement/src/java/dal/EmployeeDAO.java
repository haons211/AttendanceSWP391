/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import context.DBContext;
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
 * @author Dan
 */
public class EmployeeDAO {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Employee> getAllEmployeesforProject(int departmentID) throws ClassNotFoundException {
        List<Employee> list = new ArrayList<>();
        String query = "SELECT e.* FROM employee e join employeedepartment ep on e.employee_id=ep.employee_id where department_id=(select department_id from employeedepartment where employee_id=?)";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, departmentID);
            rs = ps.executeQuery();
            while (rs.next()) {
                int employeeId = rs.getInt("employee_id");
                String name = rs.getString("name");
                String phoneNumber = rs.getString("phoneNumber");
                String address = rs.getString("address");
                String email = rs.getString("email");
                boolean gender = rs.getBoolean("gender");
                String image = rs.getString("image");
                String birthDate = rs.getString("birth_date");
                String hireDate = rs.getString("hire_date");
                int userId = rs.getInt("user_id");
                double salary = rs.getDouble(11);
                Employee employee = new Employee(employeeId, name, phoneNumber, address, email, gender, image, birthDate, hireDate, userId, salary);
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

    public boolean updateInformation(
            int userId,
            String name,
            String phone,
            String email,
            String address,
            boolean gender,
            String birthDate
    ) throws Exception {
        try {
            con = new context.DBContext().getConnection();
            if (con != null) {

                String sql = "UPDATE employee SET name = ?, phoneNumber = ?, email = ?, address = ?, gender = ?, birth_date = ? WHERE user_id=?";
                ps = con.prepareStatement(sql);
                ps.setString(1, name);
                ps.setString(2, phone);
                ps.setString(3, email);
                ps.setString(4, address);
                ps.setBoolean(5, gender);
                ps.setString(6, birthDate);
                ps.setInt(7, userId);

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
            con = new context.DBContext().getConnection();
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

                    em = new Employee(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getBoolean(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getInt(10), rs.getDouble(11));
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

    public void addEmployee(
            String name,
            String phoneNumber,
            String address,
            String email,
            Boolean gender,
            String image,
            String birthDate,
            String hireDate, int id,
            Double salary) throws SQLException {
        String query = "INSERT INTO employee "
                + "(name, phoneNumber, address, email, gender, image, birth_date, hire_date,user_id ,basic_salary ) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?,?,?)";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, phoneNumber);
            ps.setString(3, address);
            ps.setString(4, email);
            ps.setBoolean(5, gender);
            ps.setString(6, image);
            ps.setString(7, birthDate);
            ps.setString(8, hireDate);
            ps.setInt(9, id);
            ps.setDouble(10, salary);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }

    }

    public void addEmployeeDepartment(
            Employee employee
    ) throws SQLException {
        String query = "INSERT INTO employeedepartment "
                + "(employee_id, department_id) "
                + "VALUES (?, ?)";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, employee.getEmployeeId());
            ps.setInt(9, employee.getDepartmentId());
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
                String birthDate = rs.getString("birth_date");
                String hireDate = rs.getString("hire_date");
                int userId = rs.getInt("user_id");
                double salary = rs.getDouble(11);
                employee = new Employee(employeeId, name, phoneNumber, address,
                        email, gender, image, birthDate, hireDate, userId, salary);
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
        String query = "UPDATE employee SET name = ?, "
                + "phoneNumber = ?, address = ?, email = ?, "
                + "gender = ?, image = ?, birth_date = ?, hire_date = ?, basic_salary = ? WHERE employee_id = ?";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, e.getName());
            ps.setString(2, e.getPhoneNumber());
            ps.setString(3, e.getAddress());
            ps.setString(4, e.getEmail());
            ps.setBoolean(5, e.isGender());
            ps.setString(6, e.getImage());
            ps.setString(7, e.getBirthDate());
            ps.setString(8, e.getHireDate());
            ps.setDouble(9, e.getBasicSalary());
            ps.setInt(10, id);
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

        String query = " delete from attendance where employee_id=? DELETE FROM employee WHERE employee_id =?";
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

    public void deleteEmployee1(int id) throws ClassNotFoundException {

        String query = " DELETE FROM employee WHERE employee_id =?";
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

    public boolean isEmpExists(int id) {
        String query = "SELECT COUNT(DISTINCT e.employee_id) AS so_luong_nguoi_diem_danh\n"
                + "FROM employee e\n"
                + "JOIN attendance a ON e.employee_id = a.employee_id\n"
                + "where e.employee_id = ?";
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
        }
        return false;
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
                String birthDate = rs.getString("birth_date");
                String hireDate = rs.getString("hire_date");
                int userId = rs.getInt("user_id");
                double salary = rs.getDouble(11);
                Employee employee = new Employee(employeeId, name, phoneNumber, address, email, gender, image, birthDate, hireDate, userId, salary);
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

    public double getSalaryByUserName(String username) throws SQLException {

        String query = "select basic_salary from employee e join users u on e.user_id = u.user_id\n"
                + "where username = ?";
        double salary = 0;
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                salary = rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý ngoại lệ nếu có
        } finally {
            closeResources();
        }
        return salary;
    }

    public int getEmployeeID() throws SQLException {

        String query = "SELECT employee_id \n"
                + "FROM employee \n"
                + "ORDER BY employee_id DESC\n"
                + "LIMIT 1;";
        int salary = 0;
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                salary = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý ngoại lệ nếu có
        } finally {
            closeResources();
        }
        return salary;
    }

    public Employee getin4byemid(int Id) throws SQLException, ClassNotFoundException {

        Employee em = null;

        try {
            // Kết nối cơ sở dữ liệu
            con = new DBContext().getConnection();
            if (con != null) {
                // Câu truy vấn SQL với INNER JOIN
                String sql = "select distinct e.* from employee e join notification n on e.employee_id=n.employee_id where n.notification_id=?";

                // Tạo statement và thiết lập tham số
                ps = con.prepareStatement(sql);
                ps.setInt(1, Id);

                // Thực hiện câu truy vấn
                rs = ps.executeQuery();

                // Xử lý kết quả
                if (rs.next()) {
                    // Lấy dữ liệu từ ResultSet và tạo đối tượng Student

                    em = new Employee(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getBoolean(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getInt(10), rs.getDouble(11));
                    return em;
                }
            }
        } catch (SQLException e) {
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

        return em;
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

    public static void main(String[] args) throws ClassNotFoundException {
        EmployeeDAO dAO = new EmployeeDAO();
        dAO.deleteEmployee(8);
    }
}

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
import models.DepartmentAttendanceDTO;
import models.DepartmentEmployeeCountDTO;
import models.Employee;

/**
 *
 * @author andep
 */
public class DashboardDAO {

    Connection con = null;
    PreparedStatement stm = null;
    ResultSet rs = null;

    public int getNumberOfDepartments() {
        int numberOfDepartments = 0;
        String query = "SELECT COUNT(*) FROM department";

        try {
            // Kết nối đến cơ sở dữ liệu
            con = new DBContext().getConnection();

            // Chuẩn bị câu truy vấn
            stm = con.prepareStatement(query);

            // Thực hiện truy vấn
            rs = stm.executeQuery();

            // Xử lý kết quả truy vấn
            if (rs.next()) {
                numberOfDepartments = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý các ngoại lệ (exception) nếu có
        }
        return numberOfDepartments;
    }

    public int getNumberOfEmployees() {
        int numberOfEmployees = 0;
        String query = "SELECT COUNT(*) FROM employee";

        try {
            // Kết nối đến cơ sở dữ liệu
            con = new DBContext().getConnection();

            // Chuẩn bị câu truy vấn
            stm = con.prepareStatement(query);

            // Thực hiện truy vấn
            rs = stm.executeQuery();

            // Xử lý kết quả truy vấn
            if (rs.next()) {
                numberOfEmployees = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý các ngoại lệ (exception) nếu có
        }
        return numberOfEmployees;
    }

    public int getNumberOfAttend() {
        int numberOfAttend = 0;
        String query = "SELECT COUNT(*)\n"
                + "FROM employee e\n"
                + "LEFT JOIN attendance a ON e.employee_id = a.employee_id\n"
                + "WHERE a.status = 'Present';";

        try {
            // Kết nối đến cơ sở dữ liệu
            con = new DBContext().getConnection();

            // Chuẩn bị câu truy vấn
            stm = con.prepareStatement(query);

            // Thực hiện truy vấn
            rs = stm.executeQuery();

            // Xử lý kết quả truy vấn
            if (rs.next()) {
                numberOfAttend = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý các ngoại lệ (exception) nếu có
        }
        return numberOfAttend;
    }

    public List<Department> getTop3Department() {
        List<Department> list = new ArrayList<>();
        String query = "select * from department LIMIT 3;";
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Department(rs.getInt(1),
                        rs.getString(2),rs.getString(3)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public List<Employee> getTop5Employee() {
        List<Employee> list = new ArrayList<>();
        String query = "SELECT * FROM employee LIMIT 5;";
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Employee(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getBoolean(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getInt(10)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList<DepartmentEmployeeCountDTO> getEmployeeCountByDepartment() {
        ArrayList<DepartmentEmployeeCountDTO> departmentEmployeeCounts = new ArrayList<>();
        String query = "SELECT d.name AS department_name, COUNT(e.employee_id) AS employee_count "
                + "FROM department d "
                + "LEFT JOIN employeedepartment ed ON d.department_id = ed.department_id "
                + "LEFT JOIN employee e ON ed.employee_id = e.employee_id "
                + "GROUP BY d.name";

        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            rs = stm.executeQuery();

            while (rs.next()) {
                String departmentName = rs.getString("department_name");
                int employeeCount = rs.getInt("employee_count");
                DepartmentEmployeeCountDTO dto = new DepartmentEmployeeCountDTO();
                dto.setDepartmentName(departmentName);
                dto.setEmployeeCount(employeeCount);
                departmentEmployeeCounts.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý các ngoại lệ (exception) nếu có
        } finally {
            // Đóng ResultSet, PreparedStatement và Connection ở đây nếu cần
            closeResources();
        }

        return departmentEmployeeCounts;
    }

    public ArrayList<DepartmentAttendanceDTO> getAttendancePercentageByDepartment() {
        ArrayList<DepartmentAttendanceDTO> departmentAttendanceList = new ArrayList<>();
        String query = "SELECT d.name AS department_name, "
                + "SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(e.employee_id) AS attendance_percentage "
                + "FROM department d "
                + "LEFT JOIN employeedepartment ed ON d.department_id = ed.department_id "
                + "LEFT JOIN employee e ON ed.employee_id = e.employee_id "
                + "LEFT JOIN attendance a ON e.employee_id = a.employee_id "
                + "GROUP BY d.name";

        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            rs = stm.executeQuery();

            while (rs.next()) {
                String departmentName = rs.getString("department_name");
                double attendancePercentage = rs.getDouble("attendance_percentage");
                DepartmentAttendanceDTO dto = new DepartmentAttendanceDTO();
                dto.setDepartmentName(departmentName);
                dto.setAttendancePercentage(attendancePercentage);
                departmentAttendanceList.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý các ngoại lệ (exception) nếu có
        } finally {
            // Đóng ResultSet, PreparedStatement và Connection ở đây nếu cần
            closeResources();
        }

        return departmentAttendanceList;
    }
    

    public List<Employee> getEmployee(int departmentId) {
        List<Employee> list = new ArrayList<>();
    String query = "SELECT e.* FROM employee e "
                 + "JOIN employeedepartment ed ON e.employee_id = ed.employee_id "
                 + "WHERE ed.department_id = ?";
    try {
        con = new DBContext().getConnection();
        stm = con.prepareStatement(query);
        stm.setInt(1, departmentId); // Thiết lập giá trị cho tham số trong truy vấn
        rs = stm.executeQuery();
        while (rs.next()) {
            list.add(new Employee(rs.getInt(1),
                    rs.getString(2),
                    rs.getString(3),
                    rs.getString(4),
                    rs.getString(5),
                    rs.getBoolean(6),
                    rs.getString(7),
                    rs.getString(8),
                    rs.getString(9),
                    rs.getInt(10)));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
    

    public List<Employee> getListLeave() {
        List<Employee> list = new ArrayList<>();
        String query = "SELECT *\n"
                + "FROM employee e\n"
                + "LEFT JOIN attendance a ON e.employee_id = a.employee_id\n"
                + "WHERE a.status = 'Absent';";
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Employee(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getBoolean(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getInt(10)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    private void closeResources() {
        try {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}

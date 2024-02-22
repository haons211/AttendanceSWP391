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
}

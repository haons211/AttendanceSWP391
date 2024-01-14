/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
}

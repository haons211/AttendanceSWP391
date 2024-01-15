/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import models.employee;

/**
 *
 * @author NCM
 */
public class employeeDAO {

    public boolean updateIn4Information(int accid, String name, String phone, String email, String address, boolean gender, String birthdate) throws Exception {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = new dal.DBContext().getConnection();
            if (con != null) {
                // Tạo truy vấn SQL để cập nhật thông tin sinh viên
                String sql = "UPDATE employee SET name = ?, phoneNumber = ?, email = ?, address = ?, gender = ?, birth_date = ? WHERE user_id=?";
                stm = con.prepareStatement(sql);
                stm.setString(1, name);
                stm.setString(2, phone);
                stm.setString(3, email);
                stm.setString(4, address);
                stm.setBoolean(5, gender);
                stm.setString(6, birthdate);
                stm.setInt(7, accid);

                // Thực hiện truy vấn cập nhật
                int row = stm.executeUpdate();
                if (row > 0) {
                    return true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    public employee getin4(int userId) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        employee em = null;

        try {
            // Kết nối cơ sở dữ liệu
            con = new dal.DBContext().getConnection();
            if (con != null) {
                // Câu truy vấn SQL với INNER JOIN
                String sql = "select e.* from users u join employee e on u.user_id=e.user_id where u.user_id=? ";

                // Tạo statement và thiết lập tham số
                stm = con.prepareStatement(sql);
                stm.setInt(1, userId);

                // Thực hiện câu truy vấn
                rs = stm.executeQuery();

                // Xử lý kết quả
                if (rs.next()) {
                    // Lấy dữ liệu từ ResultSet và tạo đối tượng Student

                    em = new employee(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getBoolean(6), rs.getString(7), rs.getDate(8), rs.getDate(9), rs.getInt(10));
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
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }

        return null;
    }

}

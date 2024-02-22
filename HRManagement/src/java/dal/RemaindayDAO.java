/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author ThuyVy
 */
import context.DBContext;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RemaindayDAO {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public int getRemainDayById(int remainDayId) throws ClassNotFoundException {
        String sql = "SELECT remainDay FROM swp.remainday WHERE employee_id = ?";
        int remainDay = -1; // Giá trị mặc định nếu không tìm thấy
        try {
            // Lấy kết nối từ ConnectionPool (hoặc tạo mới nếu cần)
            con = DBContext.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, remainDayId); 
            rs = ps.executeQuery();
            if (rs.next()) {
                remainDay = rs.getInt("remainDay"); 
            }
        } catch (SQLException e) {
        } finally {
            // Đóng tất cả các tài nguyên (ResultSet, PreparedStatement, Connection)
            closeResources();
        }

        // Trả về giá trị remainDay
        return remainDay;
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
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

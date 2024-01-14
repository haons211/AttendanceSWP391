/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import models.AccountDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author NCM
 */
public class AccountDAO {

    Connection con = null;
    PreparedStatement stm = null;
    ResultSet rs = null;

    public AccountDTO checkLogin(String username, String password) throws SQLException, ClassNotFoundException, Exception {

        try {
            // 1. Connect DB
            con = new DBContext().getConnection();
            if (con != null) {
                // 2. Create SQL String
                String sql = "select * from users WHERE username = ? AND password = ?";
                // 3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                stm.setString(2, password);
                // 4. Execute Query
                rs = stm.executeQuery();
                // 5. Process Result
                if (rs.next()) {
                    AccountDTO dto = new AccountDTO(rs.getInt(1),
                            rs.getString(2), rs.getString(3),
                            rs.getInt(4)); // Corrected index for Role
                    return dto;
                }
            }
        } catch (Exception e) {
            // Xử lý lỗi, ví dụ: ghi log
            e.printStackTrace();
        } finally {
            // Đóng tài nguyên
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

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import context.DBContext;
import models.AccountDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author NCM
 */
public class AccountDAO {

    Connection con = null;
    PreparedStatement stm = null;
    ResultSet rs = null;
public int getEmployeeId(int userId) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int employeeId = -1;

        try {
            con = new DBContext().getConnection();
            String sql = "SELECT employee_id FROM employee WHERE user_id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                employeeId = rs.getInt("employee_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Đóng tất cả các tài nguyên
        }

        return employeeId;
    }
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

    public int getNumberOfUsers() {
        int numberOfUsers = 0;
        String query = "SELECT COUNT(*) FROM users";

        try {
            // Connect to the database
            con = new DBContext().getConnection();

            // Prepare the query
            stm = con.prepareStatement(query);

            // Execute the query
            rs = stm.executeQuery();

            // Process the query result
            if (rs.next()) {
                numberOfUsers = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
        return numberOfUsers;
    }

    public ArrayList<AccountDTO> getAllUsers(String search, int role_id) {
        ArrayList<AccountDTO> list = new ArrayList<>();
        String query = "SELECT *\n"
                + "FROM users\n"
                + "WHERE \n"
                + "    (username LIKE ? OR ? = '') \n" // Lọc theo username là 'admin' nếu có giá trị, nếu không thì bỏ qua
                + "    AND (role_id = ? OR ? = 0) \n" //Bỏ qua điều kiện này vì role_id trống
                + "ORDER BY user_id ASC;";
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, "%" + search + "%");
            stm.setString(2, "%" + search + "%");
            stm.setInt(3, role_id);
            stm.setInt(4, role_id);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new AccountDTO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4)));
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

    public boolean isUserIdExists(int id) {
        String query = "SELECT COUNT(*) FROM users WHERE user_id = ?";
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
        return false;
    }

    public boolean isUsernameExists(String username) {
        String query = "SELECT COUNT(*) FROM users WHERE username = ?";
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, username);
            rs = stm.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
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

    public void addUser(String username, String password, int role_id) {

        String query = "INSERT INTO users (username, password, role_id) VALUES (?, ?, ?)";
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, username);
            stm.setString(2, password);
            stm.setInt(3, role_id);
            stm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
    }

    public String updateUser(int user_id, String username, String password, int role_id) {
        String query = "UPDATE users\n"
                + "SET username = ?, \n"
                + "    password = ?, \n"
                + "    role_id = ?\n"
                + "WHERE user_id = ?;";
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, username);
            stm.setString(2, password);
            stm.setInt(3, role_id);
            stm.setInt(4, user_id);
            int rowsAffected = stm.executeUpdate();
            if (rowsAffected > 0) {
                return "Update successfully!";
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
        return "Update failed";
    }

    public void deleteUser(int id) {
        String query = "DELETE FROM users WHERE user_id = ?";
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
    }

    public AccountDTO getUserById(int user_id) {
        String query = "SELECT * FROM users WHERE user_id = ?";
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            stm.setInt(1, user_id);
            rs = stm.executeQuery();
            if (rs.next()) {
                return new AccountDTO(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4));
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

    // Other methods for department operations
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

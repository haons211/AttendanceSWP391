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
import java.util.ArrayList;

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

    public ArrayList<AccountDTO> getAllUsers(String search) {
        ArrayList<AccountDTO> list = new ArrayList<>();
        String query = "SELECT * FROM users WHERE username LIKE ? ORDER BY user_id ASC";
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, "%" + search + "%");
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

    public void addUser(int user_id, String username, String password, int role_id) {
        if (isUserIdExists(user_id)) {
            System.out.println("User with ID " + user_id + " already exists.");
            return;
        }
        String query = "INSERT INTO users (user_id, username, password, role_id) VALUES (?, ?, ?, ?)";
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            stm.setInt(1, user_id);
            stm.setString(2, username);
            stm.setString(3, password);
            stm.setInt(4, role_id);
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

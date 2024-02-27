/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import context.DBContext;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import models.Attendance;
import models.AttendanceReport;

/**
 *
 * @author ThuyVy
 */
public class AttendanceDAO {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // Phương thức để thêm đối tượng Attendance vào cơ sở dữ liệu
    public int CheckIn(int employee_id, String notes, String image, int remainDay_id, int department_id) {
        String query = "INSERT INTO attendance (employee_id, in_time, notes, image, remainDay_id, department_id) VALUES (?, now(), ?, ?, ?, ?)";
        int attendanceId = -1; // Mặc định gán attendanceId là -1
        try {
            int affectedRows = 0;
            con = DBContext.getConnection();
            ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS); // Sử dụng Statement.RETURN_GENERATED_KEYS để lấy khóa tự tăng
            ps.setInt(1, employee_id);
            ps.setString(2, notes);
            ps.setString(3, image);
            ps.setInt(4, remainDay_id);
            ps.setInt(5, department_id);
            affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                ResultSet generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    attendanceId = generatedKeys.getInt(1); // Lấy giá trị tự tăng
                } else {
                    System.out.println("Attendance added, but couldn't retrieve attendance_id.");
                }
            } else {
                System.out.println("Failed to CheckIn.");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {

            closeResources();
        }
        return attendanceId;
    }

    public void CheckOut(int attendanceId) {
        String query = "UPDATE attendance SET out_time = now(), date = CURDATE() WHERE attendance_id = ?;";

        try {
            con = DBContext.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, attendanceId);
            ps.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
    }

    public Attendance getAttendanceById(int attendanceId) {
        Attendance attendance = null;
        String query = "SELECT * FROM attendance WHERE attendance_id = ?;";
        try {
            con = DBContext.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, attendanceId);
            rs = ps.executeQuery();
            if (rs.next()) {
                int employee_id = rs.getInt("employee_id");
                String in_time = rs.getString("in_time");
                String out_time = rs.getString("out_time");
                String notes = rs.getString("notes");
                String image = rs.getString("image");
                String status = rs.getString("status");
                String in_status = rs.getString("in_status");
                String out_status = rs.getString("out_status");
                int remainDay_id = rs.getInt("remainDay_id");
                int department_id = rs.getInt("department_id");
                Date date = rs.getDate("date");
                // Tạo đối tượng Attendance từ thông tin lấy được
                attendance = new Attendance(attendanceId, employee_id, in_time, out_time, notes, image, status, in_status, out_status, remainDay_id, department_id, date);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return attendance;
    }

    public ArrayList<AttendanceReport> getAllAttendance(String search, String dep_name, Date fromDate, Date toDate) {
        ArrayList<AttendanceReport> list = new ArrayList<>();
        String query = "SELECT a.attendance_id,e.name,d.name as dep_name,a.date,a.status, a.in_time, a.notes, a.in_status, a.out_time, a.out_status, r.remainDay "
                + "FROM attendance a "
                + "JOIN employee e ON a.employee_id = e.employee_id "
                + "JOIN department d ON a.department_id = d.department_id "
                + "JOIN remainday r ON a.remainDay_id = r.remainDay_id "
                + "WHERE 1=1 ";

        if (search != null && !search.isEmpty()) {
            query += "AND (e.name LIKE ? OR d.name LIKE ? OR a.status LIKE ? OR a.in_time LIKE ? OR a.out_time LIKE ? OR a.notes LIKE ? OR a.in_status LIKE ? OR a.out_status LIKE ?)";
        }

        if (dep_name != null && !dep_name.isEmpty()) {
            query += " AND d.name LIKE ?";
        }

        // Thêm điều kiện tìm kiếm theo ngày nếu có
        if (fromDate != null && toDate != null) {
            query += " AND a.date BETWEEN ? AND ?";
        }

        query += " ORDER BY a.attendance_id ASC";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            int paramIndex = 1;

            // Nếu có chuỗi tìm kiếm, đặt các tham số tương ứng trong câu truy vấn
            if (search != null && !search.isEmpty()) {
                String likePattern = "%" + search + "%";
                for (int i = 1; i <= 8; i++) { // Số lượng tham số tìm kiếm là 8
                    ps.setString(paramIndex++, likePattern);
                }
            }

            // Nếu có dep_name, đặt tham số tương ứng trong câu truy vấn
            if (dep_name != null && !dep_name.isEmpty()) {
                ps.setString(paramIndex++, "%" + dep_name + "%");
            }

            // Nếu có ngày bắt đầu và kết thúc, đặt tham số tương ứng trong câu truy vấn
            if (fromDate != null && toDate != null) {
                ps.setDate(paramIndex++, new java.sql.Date(fromDate.getTime()));
                ps.setDate(paramIndex++, new java.sql.Date(toDate.getTime()));
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new AttendanceReport(rs.getInt("a.attendance_id"), rs.getString("e.name"),
                        rs.getString("dep_name"), rs.getDate("a.date"), rs.getString("a.status"),
                        rs.getString("a.notes"), rs.getString("a.in_time"), rs.getString("a.in_status"),
                        rs.getString("out_time"), rs.getString("out_status"), rs.getInt("r.remainDay")));
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
    public void deleteAttendance(int id) {
        String query = "DELETE FROM attendance WHERE attendance_id = ?";
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

    public String updateAttendance(int attendance_id, String in_time,
            String out_time, String notes, String status,
            String in_status, String out_status, int remainDay, String date) {
        String query = "UPDATE attendance a \n"
                + "JOIN employee e ON a.employee_id = e.employee_id \n"
                + "JOIN department d ON a.department_id = d.department_id \n"
                + "JOIN remainday r ON a.remainDay_id = r.remainDay_id \n"
                + "SET a.date = ?, \n"
                + "    a.status = ?, \n"
                + "    a.in_time = ?, \n"
                + "    a.notes = ?, \n"
                + "    a.in_status = ?, \n"
                + "    a.out_time = ?, \n"
                + "    a.out_status = ?, \n"
                + "    r.remainDay = ?\n"
                + "WHERE a.attendance_id = ?;";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, date);
            ps.setString(2, status);
            ps.setString(3, in_time);
            ps.setString(4, notes);
            ps.setString(5, in_status);
            ps.setString(6, out_time);
            ps.setString(7, out_status);
            ps.setInt(8, remainDay);
            ps.setInt(9, attendance_id);
            int rowsAffected = ps.executeUpdate();
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

    public AttendanceReport getAttendanceReportById(int attendanceId) {
        AttendanceReport attendanceReport = null;
        String query = "SELECT *\n"
                + "FROM attendance a \n"
                + "JOIN employee e ON a.employee_id = e.employee_id \n"
                + "JOIN department d ON a.department_id = d.department_id \n"
                + "JOIN remainday r ON a.remainDay_id = r.remainDay_id \n"
                + "WHERE attendance_id = ?;";
        try {
            con = DBContext.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, attendanceId);
            rs = ps.executeQuery();
            if (rs.next()) {
                // Tạo đối tượng Attendance từ thông tin lấy được
                attendanceReport = new AttendanceReport(rs.getInt("a.attendance_id"), rs.getString("e.name"),
                        rs.getString("d.name"), rs.getDate("a.date"), rs.getString("a.status"),
                        rs.getString("a.notes"), rs.getString("a.in_time"), rs.getString("a.in_status"),
                        rs.getString("out_time"), rs.getString("out_status"), rs.getInt("r.remainDay"),
                        rs.getInt("r.approvedLeaveDays"));
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return attendanceReport;
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

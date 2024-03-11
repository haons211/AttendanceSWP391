/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import context.DBContext;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import models.Attendance;

import models.AttendanceReport;
import models.AttendanceSheet;

import models.AttendanceDepartmentDTO;

/**
 *
 * @author ThuyVy
 */
public class AttendanceDAO {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // Phương thức để thêm đối tượng Attendance vào cơ sở dữ liệu
    public int CheckIn(int employee_id, String notes, int remainDay_id) {
        String updateQuery = "UPDATE attendance "
                + "SET in_time = NOW(), "
                + "    notes = ?, "
                + "    remainDay_id = ? "
                + "WHERE employee_id = ? AND DATE(date) = CURDATE()";

        String selectQuery = "SELECT attendance_id "
                + "FROM attendance "
                + "WHERE employee_id = ? AND DATE(date) = CURDATE()";

        int attendanceId = -1; // Mặc định gán attendanceId là -1
        try {
            con = DBContext.getConnection();

            // Thực hiện câu lệnh UPDATE
            ps = con.prepareStatement(updateQuery);
            ps.setString(1, notes);
            ps.setInt(2, remainDay_id);
            ps.setInt(3, employee_id);
            int affectedRows = ps.executeUpdate(); // Số lượng bản ghi đã được cập nhật

            if (affectedRows > 0) {
                // Nếu có bản ghi được cập nhật thành công, thực hiện truy vấn SELECT để lấy attendance_id
                ps = con.prepareStatement(selectQuery);
                ps.setInt(1, employee_id);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    attendanceId = rs.getInt("attendance_id"); // Lấy attendance_id từ kết quả truy vấn SELECT
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
        String query = "UPDATE attendance SET out_time = now() WHERE attendance_id = ?;";

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

    public ArrayList<AttendanceDepartmentDTO> getAllAttendance(String search, String dep_name, Date fromDate, Date toDate) {
        ArrayList<AttendanceDepartmentDTO> list = new ArrayList<>();
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
                list.add(new AttendanceDepartmentDTO(rs.getInt("a.attendance_id"), rs.getString("e.name"),
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

    public AttendanceDepartmentDTO getAttendanceReportById(int attendanceId) {
        AttendanceDepartmentDTO attendanceReport = null;
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
                attendanceReport = new AttendanceDepartmentDTO(rs.getInt("a.attendance_id"), rs.getString("e.name"),
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

    public void insertCheckStatus(int employeeId, boolean checkedIn, boolean checkedOut) {
        String sql = "UPDATE UserCheckStatus SET CheckedIn = ?, CheckedOut = ? WHERE employee_id = ?";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(sql);
            ps.setBoolean(1, checkedIn);
            ps.setBoolean(2, checkedOut);
            ps.setInt(3, employeeId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý các ngoại lệ nếu có
        } finally {
            // Đóng các tài nguyên trong khối finally
            closeResources();
        }
    }

    public boolean getCheckedInStatus(int employeeId) throws ClassNotFoundException {
        String sql = "SELECT CheckedIn FROM UserCheckStatus WHERE employee_id = ?";
        try {
            con = DBContext.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, employeeId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getBoolean("CheckedIn");
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

    public boolean getCheckedOutStatus(int employeeId) throws ClassNotFoundException {
        String sql = "SELECT CheckedOut FROM UserCheckStatus WHERE employee_id = ?";
        try {
            con = DBContext.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, employeeId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getBoolean("CheckedOut");
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

    public void CallAttendanceByDay() {
        String procedureCall = "{CALL generateDailyAttendance()}";

        try {
            con = DBContext.getConnection();
            CallableStatement cs = con.prepareCall(procedureCall);
            cs.execute();
            System.out.println("Stored procedure executed successfully.");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
    }

    public ArrayList<AttendanceSheet> getAttendanceByEmployeeAndDateRange(int em_id, String month, String Year) {
        ArrayList<AttendanceSheet> attendanceList = new ArrayList<>();
        String query = "SELECT e.name, "
                + "       dates.date AS date, "
                //                + "       COALESCE(a.status, 'Absent') AS status "
                + "       a.status AS status "
                + "FROM ("
                + "    -- Tạo một bảng tạm thời chứa tất cả các ngày trong tháng được chỉ định\n"
                + "    SELECT DATE_ADD('" + Year + "-" + month + "-01', INTERVAL (t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) DAY) AS date "
                + "    FROM "
                + "        (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t0, "
                + "        (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t1, "
                + "        (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t2, "
                + "        (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t3, "
                + "        (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t4 "
                + "    WHERE DATE_FORMAT(DATE_ADD('" + Year + "-" + month + "-01', INTERVAL (t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) DAY), '%Y-%m') = '" + Year + "-" + month + "'"
                + ") AS dates "
                + "CROSS JOIN (SELECT DISTINCT employee_id FROM attendance) AS aid "
                + "JOIN employee e ON aid.employee_id = e.employee_id "
                + "LEFT JOIN attendance a ON e.employee_id = a.employee_id AND dates.date = DATE_FORMAT(a.date, '%Y-%m-%d') "
                + "where e.employee_id = ? "
                + "ORDER BY e.employee_id, dates.date;";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, em_id);
            rs = ps.executeQuery();

            while (rs.next()) {
                AttendanceSheet attendance = new AttendanceSheet(
                        rs.getString("name"),
                        rs.getString("date"),
                        rs.getString("status")
                );
                attendanceList.add(attendance);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
        return attendanceList;
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

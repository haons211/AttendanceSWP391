/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import context.DBContext;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import models.AccountDTO;
import models.Notification;

/**
 *
 * @author NCM
 */
public class NotificationDAO {

    Connection con = null;
    PreparedStatement stm = null;
    ResultSet rs = null;

    public List<Notification> getAllNotification() {
        List<Notification> list = new ArrayList<>();
        String query = "SELECT n.*,f.file_data FROM notification n left join managerfile mf on n.notification_id=mf.FID left join file f on mf.file_id=f.file_id";
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Notification(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getTimestamp(5), rs.getBinaryStream(6)));
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        }
        return list;
    }

    public List<Notification> searchNotification(String search) {
        List<Notification> list = new ArrayList<>();
        String query = "SELECT n.*,f.file_data FROM notification n left join managerfile mf on n.notification_id=mf.FID left join file f on mf.file_id=f.file_id\n"
                + "where n.subject like ?";
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, "%" + search + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Notification(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getTimestamp(5), rs.getBinaryStream(6)));
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        }
        return list;
    }

    public List<Notification> searchNotificationwithdate(Date dateFrom, Date dateEnd) {
        List<Notification> list = new ArrayList<>();
        String query = "SELECT n.*,f.file_data FROM notification n left join managerfile mf on n.notification_id=mf.FID left join file f on mf.file_id=f.file_id\n"
                + "where n.sent_date BETWEEN ? AND ?";
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            stm.setDate(1, new java.sql.Date(dateFrom.getTime()));
            stm.setDate(2, new java.sql.Date(dateEnd.getTime()));
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Notification(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getTimestamp(5), rs.getBinaryStream(6)));
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        }
        return list;
    }

    public Notification getdetailsNotification(int id) throws SQLException, ClassNotFoundException {
        String query = "SELECT n.*,f.file_data FROM notification n left join managerfile mf on n.notification_id=mf.FID left join file f on mf.file_id=f.file_id where n.notification_id=?";
        Notification n = null;
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            while (rs.next()) {
                n = new Notification(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getTimestamp(5), rs.getBinaryStream(6));
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        }
        return n;
    }

    public String getfileName(int id) throws SQLException, ClassNotFoundException {
        String query = "SELECT f.file_name FROM notification n left join managerfile mf on n.notification_id=mf.FID left join file f on mf.file_id=f.file_id where n.notification_id=?";
        String n = null;
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            while (rs.next()) {
                n = rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        }
        return n;
    }

    public boolean insertFile(String fileName, InputStream fileInputStream) throws ClassNotFoundException, SQLException {
        String sql = "INSERT INTO file (file_name, file_data) VALUES (?, ?)";
        boolean success = false;
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, fileName);
            stm.setBlob(2, fileInputStream);
            int affectedRows = stm.executeUpdate();
            success = affectedRows > 0; // Trả về true nếu có ít nhất một hàng được ảnh hưởng
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    public boolean createNotification(String subject, String description, int employeeID) throws ClassNotFoundException, SQLException {
        String sql = "INSERT INTO notification (employee_id, subject, description, sent_date) \n"
                + "VALUES (?, ?, ?, NOW())";
        boolean success = false;
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, employeeID);
            stm.setString(2, subject);
            stm.setString(3, description);
            int affectedRows = stm.executeUpdate();
            success = affectedRows > 0; // Trả về true nếu có ít nhất một hàng được ảnh hưởng
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    public boolean insertManagerfile(int FID, int FileID) throws ClassNotFoundException, SQLException {
        String sql = "INSERT INTO managerfile (FID,file_id) VALUES (?, ?)";
        boolean success = false;
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, FID);
            stm.setInt(2, FileID);
            int affectedRows = stm.executeUpdate();
            success = affectedRows > 0; // Trả về true nếu có ít nhất một hàng được ảnh hưởng
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    public int getLatestFileId() throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int latestFileId = -1;

        try {
            con = new DBContext().getConnection();
            String sql = "SELECT MAX(file_id) AS latest_file_id FROM file";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                latestFileId = rs.getInt("latest_file_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Đóng tất cả các tài nguyên
        }

        return latestFileId;
    }

    public int getLatestNotificationId() throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int latestNotificationId = -1;

        try {
            con = new DBContext().getConnection();
            String sql = "SELECT MAX(notification_id) AS latest_notification_id FROM notification";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                latestNotificationId = rs.getInt("latest_notification_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Đóng tất cả các tài nguyên
        }

        return latestNotificationId;
    }

    public int getfileID(int NotiID) throws ClassNotFoundException, SQLException {

        int FileId = -1;

        try {
            con = new DBContext().getConnection();
            String sql = "SELECT file_id FROM managerfile where FID=?";
            stm = con.prepareStatement(sql);
            stm.setInt(1, NotiID);
            rs = stm.executeQuery();
            if (rs.next()) {
                FileId = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Đóng tất cả các tài nguyên
        }

        return FileId;
    }

    public boolean DeleteNotification(int NotiId) {
        String sql = "Delete from notification where notification_id = ?";
        boolean success = false;
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, NotiId);

            int affectedRows = stm.executeUpdate();
            success = affectedRows > 0; // Trả về true nếu có ít nhất một hàng được ảnh hưởng
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    public boolean UpdateFile(String subject, String description, int NotiId) {
        String sql = "UPDATE swp.notification SET subject = ?, description = ? WHERE notification_id = ?;";
        boolean success = false;
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, subject);
            stm.setString(2, description);
            stm.setInt(3, NotiId);

            int affectedRows = stm.executeUpdate();
            success = affectedRows > 0; // Trả về true nếu có ít nhất một hàng được ảnh hưởng
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    public boolean DeleteFile(int NotiId) {
        String sql = "DELETE FROM file WHERE file_id = ?";
        boolean success = false;
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, NotiId);

            int affectedRows = stm.executeUpdate();
            success = affectedRows > 0; // Trả về true nếu có ít nhất một hàng được ảnh hưởng
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    public boolean DeleteManagerFile(int NotiId) {
        String sql = "DELETE FROM managerfile WHERE FID = ?";
        boolean success = false;
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, NotiId);

            int affectedRows = stm.executeUpdate();
            success = affectedRows > 0; // Trả về true nếu có ít nhất một hàng được ảnh hưởng
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }
}

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
import models.Notification;
import models.Project;
import models.Task;

/**
 *
 * @author NCM
 */
public class ProjectDao {

    Connection con = null;
    PreparedStatement stm = null;
    ResultSet rs = null;

    public boolean DeleteTask(int Id) {
        String sql = "Delete From Tasks where TaskId=?";
        boolean success = false;
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, Id);

            int affectedRows = stm.executeUpdate();
            success = affectedRows > 0; // Trả về true nếu có ít nhất một hàng được ảnh hưởng
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    public boolean UpdateTask(int id, String name, String description, Date timeEnd) {
        String sql = "UPDATE tasks\n"
                + "SET Name = ?, Description =? , TimeEnd = ?\n"
                + "WHERE TaskId=?;";
        boolean success = false;
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, name);
            stm.setString(2, description);
            stm.setDate(3, new java.sql.Date(timeEnd.getTime()));
            stm.setInt(4, id);
            int affectedRows = stm.executeUpdate();
            success = affectedRows > 0; // Trả về true nếu có ít nhất một hàng được ảnh hưởng
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    public boolean DoneTask(int Id) {
        String sql = "UPDATE tasks\n"
                + "SET TimeSuccess=Now(), Success=3\n"
                + "WHERE taskId=?;";
        boolean success = false;
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, Id);

            int affectedRows = stm.executeUpdate();
            success = affectedRows > 0; // Trả về true nếu có ít nhất một hàng được ảnh hưởng
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    public boolean DeleteProject(int Id) {
        String sql = "Delete From project where ProjectId=?";
        boolean success = false;
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, Id);

            int affectedRows = stm.executeUpdate();
            success = affectedRows > 0; // Trả về true nếu có ít nhất một hàng được ảnh hưởng
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    public List<Project> getAllProjectforEmployee(int userCreate) {
        List<Project> list = new ArrayList<>();
        String query = "select Distinct p.*,m.success from project p join managerproject m on p.ProjectId=m.ProjectId join tasks t on t.MaID=m.MaID join employeedepartment ed on ed.employee_id=t.employee_id join employee e on e.employee_id=ed.employee_id where e.employee_id=?";
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            stm.setInt(1, userCreate);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Project(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(6), rs.getDate(4), rs.getDate(5), rs.getInt(7)));
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        }
        return list;
    }

    public List<Project> getAllProject(int userCreate) {
        List<Project> list = new ArrayList<>();
        String query = "select p.*,m.success from project p join managerproject m on p.ProjectId=m.ProjectId where employee_id_create=?";
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            stm.setInt(1, userCreate);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Project(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(6), rs.getDate(4), rs.getDate(5), rs.getInt(7)));
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        }
        return list;
    }

    public List<Task> getAllTask(int userCreate) {
        List<Task> list = new ArrayList<>();
        String query = "SELECT t.*, e.name\n"
                + "FROM tasks t\n"
                + "JOIN managerproject mp ON mp.MaID = t.MaID\n"
                + "JOIN employee e ON t.employee_id = e.employee_id\n"
                + "WHERE mp.ProjectID = ?\n"
                + "ORDER BY t.employee_id ASC;";
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            stm.setInt(1, userCreate);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Task(rs.getInt(1), rs.getInt(2), rs.getInt(8), rs.getString(9), rs.getString(3), rs.getString(4), rs.getDate(5), rs.getDate(6), rs.getInt(7)));
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        }
        return list;
    }

    public List<Task> getAllTaskforem(int ProjectId, int employee_id) {
        List<Task> list = new ArrayList<>();
        String query = "SELECT t.*, e.name FROM tasks t JOIN managerproject mp ON mp.MaID = t.MaID JOIN employee e ON t.employee_id = e.employee_id WHERE mp.ProjectID = ? and t.employee_id=?";
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            stm.setInt(1, ProjectId);
            stm.setInt(2, employee_id);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Task(rs.getInt(1), rs.getInt(2), rs.getInt(8), rs.getString(9), rs.getString(3), rs.getString(4), rs.getDate(5), rs.getDate(6), rs.getInt(7)));
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        }
        return list;
    }

    public int getMaid(int userCreate) {

        String query = "select MaID from managerproject where ProjectID=?";
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            stm.setInt(1, userCreate);
            rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        }
        return -1;
    }

    public int getProjectID(int userCreate) {

        String query = "select ProjectID from managerproject where MaID=?";
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            stm.setInt(1, userCreate);
            rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        }
        return -1;
    }

    public int getProjectIDbyTask(int userCreate) {

        String query = "select  mp.ProjectId from managerproject mp join tasks t on mp.MaID=t.MaID where t.TaskId=?";
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);
            stm.setInt(1, userCreate);
            rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        }
        return -1;
    }

    public boolean insertTask(Task t) {
        String query = "INSERT INTO tasks (employee_id, name, Description,TimeEnd, MaID) VALUES (?, ?, ?, ?, ?)";
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);

            stm.setInt(1, t.getEmployee_id());
            stm.setString(2, t.getTaskName());
            stm.setString(3, t.getDescription());

            stm.setDate(4, new java.sql.Date(t.getDateEnd().getTime()));
            stm.setInt(5, t.getMaId());

            int rowsAffected = stm.executeUpdate(); // Sử dụng executeUpdate() thay vì executeQuery()

            return rowsAffected > 0; // Trả về true nếu có ít nhất một hàng đã được thêm vào

        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý các ngoại lệ nếu có
            return false; // Trả về thông báo khi insert không thành công
        } finally {
            // Đóng kết nối và tài nguyên
            try {
                if (stm != null) {
                    stm.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    public boolean createProject(int edi, String name, String description, Date dateStart, Date dateEnd) {
        String query = "INSERT INTO project (employee_id_create, name, description, datefrom, dateend) VALUES (?, ?, ?, ?, ?)";
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);

            stm.setInt(1, edi);
            stm.setString(2, name);
            stm.setString(3, description);
            stm.setDate(4, new java.sql.Date(dateStart.getTime()));
            stm.setDate(5, new java.sql.Date(dateEnd.getTime()));

            int rowsAffected = stm.executeUpdate(); // Sử dụng executeUpdate() thay vì executeQuery()

            return rowsAffected > 0; // Trả về true nếu có ít nhất một hàng đã được thêm vào

        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý các ngoại lệ nếu có
            return false; // Trả về thông báo khi insert không thành công
        } finally {
            // Đóng kết nối và tài nguyên
            try {
                if (stm != null) {
                    stm.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    public boolean UpdateProject(int edi, String name, String description, Date dateStart, Date dateEnd) {
        String query = "UPDATE project SET name = ?, description =?, datefrom = ?,dateend = ? WHERE ProjectId = ?;";
        try {
            con = new DBContext().getConnection();
            stm = con.prepareStatement(query);

            stm.setInt(5, edi);
            stm.setString(1, name);
            stm.setString(2, description);
            stm.setDate(3, new java.sql.Date(dateStart.getTime()));
            stm.setDate(4, new java.sql.Date(dateEnd.getTime()));

            int rowsAffected = stm.executeUpdate(); // Sử dụng executeUpdate() thay vì executeQuery()

            return rowsAffected > 0; // Trả về true nếu có ít nhất một hàng đã được thêm vào

        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý các ngoại lệ nếu có
            return false; // Trả về thông báo khi insert không thành công
        } finally {
            // Đóng kết nối và tài nguyên
            try {
                if (stm != null) {
                    stm.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import models.*;
import context.DBContext;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.Date;

/**
 * @author Admin
 */
public class ApplicationDAO extends DBContext {

    public List<TypeApplication> GetAllTypeAllications() {
        List<TypeApplication> list = new ArrayList<>();
        String sql = "select * from type_application";
        try (Connection con = super.getConnection(); PreparedStatement st = con.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                TypeApplication t = new TypeApplication(rs.getInt("type_id"), rs.getString("name"));
                list.add(t);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public void insertApplication(Application application) {
        String sql = "INSERT INTO Application (sender_id, type_id, receiver_id, file, title, content, status, create_date, complete_date, replyContent) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = super.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
            st.setInt(1, application.getSender_id());
            st.setInt(2, application.getType_id());
            st.setInt(3, application.getReceiver_id());
            st.setString(4, application.getFile());
            st.setString(5, application.getTitle());
            st.setString(6, application.getContent());
            st.setString(7, application.getStatus());
            st.setTimestamp(8, new java.sql.Timestamp(application.getCreate_date().getTime()));
            if (application.getComplete_date() != null) {
                st.setTimestamp(9, new java.sql.Timestamp(application.getComplete_date().getTime()));
            } else {
                st.setNull(9, java.sql.Types.TIMESTAMP);
            }
            st.setString(10, application.getReplyContent());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error inserting application: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }




    public int GetEmployeeIDbyUserID(AccountDTO accountDto0) {

        int employeeId = -1;
        String sql = "SELECT employee_id FROM employee WHERE user_id = ?";
        Connection con = null;
        try {
            con = super.getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, accountDto0.getUserID());
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                employeeId = rs.getInt("employee_id");
            }
        } catch (Exception e) {
            System.out.println(e);
            throw new RuntimeException("Error when getting employee ID", e);
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return employeeId;
    }

    public List<ManagerDTO> GetAllManagers() {
        List<ManagerDTO> list = new ArrayList<>();
        String sql = "select * from employee e join users u on e.user_id=u.user_id where role_id=3";
        try (Connection con = super.getConnection(); PreparedStatement st = con.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                ManagerDTO d = new ManagerDTO(rs.getInt("employee_id"), rs.getString("name"), rs.getInt("role_id"));
                list.add(d);
            }
        } catch (SQLException e) {
            System.out.println("Error while accessing the database: " + e.getMessage());
        } catch (Exception e) {
            System.out.println("Unexpected error: " + e.getMessage());
        }
        return list;
    }

    public List<ApplicationDTO> getAllApplicationbySenderId(int sender_id, String searchParam, String typeAppParam) {
        String sql = "SELECT\n" +
                "    a.application_id,\n" +
                "    ta.type_id,\n" +  // Thêm cột type_id
                "    ta.name AS type_name,\n" +
                "    a.title,\n" +
                "    e1.name AS sender_name,\n" +
                "    e2.name AS receiver_name,\n" +
                "    a.create_date,\n" +
                "    a.status,\n" +
                "    a.content,\n" +
                "    a.file,\n" +
                "    a.complete_date\n" +
                "FROM\n" +
                "    application AS a\n" +
                "    INNER JOIN type_application AS ta ON a.type_id = ta.type_id\n" +
                "    INNER JOIN employee AS e1 ON a.sender_id = e1.employee_id\n" +
                "    INNER JOIN employee AS e2 ON a.receiver_id = e2.employee_id\n" +
                "WHERE\n" +
                "    a.sender_id = ?";

        if (searchParam != null && !searchParam.isEmpty()) {
            sql += " AND LOWER(a.title) LIKE LOWER(?)";
        }

        if (typeAppParam != null && !typeAppParam.equals("0")) {
            sql += " AND a.type_id = ?";
        }

        sql += " ORDER BY a.create_date DESC";

        List<ApplicationDTO> list = new ArrayList<>();

        try (Connection con = super.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
            st.setInt(1, sender_id);
            int parameterIndex = 2; // Bắt đầu với index 2 cho các tham số tìm kiếm

            if (searchParam != null && !searchParam.isEmpty()) {
                st.setString(parameterIndex++, "%" + searchParam + "%");
            }
            if (typeAppParam != null && !typeAppParam.equals("0")) {
                st.setInt(parameterIndex, Integer.parseInt(typeAppParam));
            }

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    ApplicationDTO applicationDTO = new ApplicationDTO();
                    applicationDTO.setApplication_id(rs.getInt("application_id"));
                    applicationDTO.setType_id(rs.getInt("type_id")); // Lấy giá trị type_id từ ResultSet
                    applicationDTO.setType_name(rs.getString("type_name"));
                    applicationDTO.setTitle(rs.getString("title"));
                    applicationDTO.setSender_name(rs.getString("sender_name"));
                    applicationDTO.setReceiver_name(rs.getString("receiver_name"));
                    applicationDTO.setCreate_date(rs.getTimestamp("create_date"));
                    applicationDTO.setComplete_date(rs.getTimestamp("complete_date"));
                    if(applicationDTO.getComplete_date()!=null){
                        changeStatus(applicationDTO.getComplete_date(), applicationDTO.getApplication_id());
                    }
                    applicationDTO.setStatus(rs.getString("status"));
                    applicationDTO.setContent(rs.getString("content"));
                    applicationDTO.setFile(rs.getString("file"));

                    applicationDTO.setFormatCreDate(rs.getTimestamp("create_date"));
                    applicationDTO.setFormatComDate(rs.getTimestamp("complete_date"));
                    list.add(applicationDTO);
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi xảy ra khi thực thi truy vấn SQL: " + e.getMessage());
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        return list;
    }


    public List<ApplicationDTO> getAllApplicationbyReceiverId(int receiver_id, String searchParam, String typeAppParam) {
        String sql = "SELECT\n" +
                "    a.application_id,\n" +
                "    ta.type_id,\n" +  // Thêm cột type_id
                "    ta.name AS type_name,\n" +
                "    a.title,\n" +
                "    e1.name AS sender_name,\n" +
                "    e2.name AS receiver_name,\n" +
                "    a.create_date,\n" +
                "    a.status,\n" +
                "    a.content,\n" +
                "    a.file,\n" +
                "    a.complete_date\n" +
                "FROM\n" +
                "    application AS a\n" +
                "    INNER JOIN type_application AS ta ON a.type_id = ta.type_id\n" +
                "    INNER JOIN employee AS e1 ON a.sender_id = e1.employee_id\n" +
                "    INNER JOIN employee AS e2 ON a.receiver_id = e2.employee_id\n" +
                "WHERE\n" +
                "    a.receiver_id = ?";

        if (searchParam != null && !searchParam.isEmpty()) {
            sql += " AND LOWER(a.title) LIKE LOWER(?)";
        }

        if (typeAppParam != null && !typeAppParam.equals("0")) {
            sql += " AND a.type_id = ?";
        }

        sql += " ORDER BY a.create_date DESC";

        List<ApplicationDTO> list = new ArrayList<>();

        try (Connection con = super.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
            st.setInt(1, receiver_id);
            int parameterIndex = 2; // Bắt đầu với index 2 cho các tham số tìm kiếm

            if (searchParam != null && !searchParam.isEmpty()) {
                st.setString(parameterIndex++, "%" + searchParam + "%");
            }
            if (typeAppParam != null && !typeAppParam.equals("0")) {
                st.setInt(parameterIndex, Integer.parseInt(typeAppParam));
            }

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    ApplicationDTO applicationDTO = new ApplicationDTO();
                    applicationDTO.setApplication_id(rs.getInt("application_id"));
                    applicationDTO.setType_id(rs.getInt("type_id")); // Lấy giá trị type_id từ ResultSet
                    applicationDTO.setType_name(rs.getString("type_name"));
                    applicationDTO.setTitle(rs.getString("title"));
                    applicationDTO.setSender_name(rs.getString("sender_name"));
                    applicationDTO.setReceiver_name(rs.getString("receiver_name"));
                    applicationDTO.setCreate_date(rs.getTimestamp("create_date"));
                    applicationDTO.setComplete_date(rs.getTimestamp("complete_date"));
                    if(applicationDTO.getComplete_date()!=null){
                        changeStatus(applicationDTO.getComplete_date(), applicationDTO.getApplication_id());
                    }
                    applicationDTO.setStatus(rs.getString("status"));
                    applicationDTO.setContent(rs.getString("content"));
                    applicationDTO.setFile(rs.getString("file"));

                    applicationDTO.setFormatCreDate(rs.getTimestamp("create_date"));
                    applicationDTO.setFormatComDate(rs.getTimestamp("complete_date"));
                    list.add(applicationDTO);
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi xảy ra khi thực thi truy vấn SQL: " + e.getMessage());
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        return list;
    }


    public ApplicationDTO getApplicationById(int applicationId) {
        String sql = "SELECT " +
                "    a.application_id, " +
                "    ta.name AS type_name, " +
                "    a.title, " +
                "    e1.name AS sender_name, " +
                "    e2.name AS receiver_name, " +
                "    a.create_date, " +
                "    a.status, " +
                "    a.content, " +
                "    a.file, " +
                "    a.complete_date, " +
                "    a.replyContent " +
                "FROM " +
                "    application AS a " +
                "    INNER JOIN type_application AS ta ON a.type_id = ta.type_id " +
                "    INNER JOIN employee AS e1 ON a.sender_id = e1.employee_id " +
                "    INNER JOIN employee AS e2 ON a.receiver_id = e2.employee_id " +
                "WHERE " +
                "    a.application_id=?";

        ApplicationDTO applicationDTO = null;

        try (Connection con = super.getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setInt(1, applicationId);

            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    applicationDTO = new ApplicationDTO();
                    applicationDTO.setApplication_id(rs.getInt("application_id"));
                    applicationDTO.setType_name(rs.getString("type_name"));
                    applicationDTO.setTitle(rs.getString("title"));
                    applicationDTO.setSender_name(rs.getString("sender_name"));
                    applicationDTO.setReceiver_name(rs.getString("receiver_name"));
                    applicationDTO.setCreate_date(rs.getDate("create_date"));
                    applicationDTO.setStatus(rs.getString("status"));
                    applicationDTO.setContent(rs.getString("content"));
                    applicationDTO.setFile(rs.getString("file"));
                    applicationDTO.setComplete_date(rs.getDate("complete_date"));
                    applicationDTO.setReplyContent(rs.getString("replyContent"));
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi xảy ra khi thực thi truy vấn SQL: " + e.getMessage());
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        return applicationDTO;
    }


    public void DeleteApplication(int applicationId) {
        String sql = "DELETE FROM application WHERE application_id = ?";
        try (Connection con = super.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
            // Set the application_id parameter
            st.setInt(1, applicationId);
            // Execute the delete statement
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error deleting application: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean titlecontain(String para) {
        boolean containsTitle = false;
        try (Connection con = super.getConnection();
             PreparedStatement st = con.prepareStatement("SELECT title FROM application");
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                String title = rs.getString("title");
                if (title != null && para != null && title.toLowerCase().contains(para.toLowerCase())) {
                    containsTitle = true;
                    break;
                }
            }
        } catch (SQLException e) {
            // Ghi lại lỗi thay vì ném ngoại lệ
            System.err.println("Error while checking if title contains searchParam: " + e.getMessage());
            return false; // Trả về false nếu có lỗi xảy ra
        } catch (ClassNotFoundException e) {
            // Ghi lại lỗi thay vì ném ngoại lệ
            System.err.println("Database driver class not found: " + e.getMessage());
            return false; // Trả về false nếu có lỗi xảy ra
        }
        return containsTitle;
    }

    public void changeStatus(Date completeDate, int applicationId) {
        if (completeDate != null) {
            try (Connection con = super.getConnection();
                 PreparedStatement st = con.prepareStatement("UPDATE application SET status = 'complete' WHERE application_id = ?")) {
                st.setInt(1, applicationId);
                int rowsUpdated = st.executeUpdate();
                if (rowsUpdated == 0) {
                    System.out.println("Không có bản ghi nào được cập nhật. Ứng dụng có thể không tồn tại hoặc đã có trạng thái hoàn thành.");
                } else {
                    System.out.println("Cập nhật trạng thái của ứng dụng thành hoàn thành thành công.");
                }
            } catch (SQLException e) {
                System.out.println("Lỗi xảy ra khi thực hiện cập nhật trạng thái của ứng dụng: " + e.getMessage());
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                throw new RuntimeException("Không thể tìm thấy lớp cơ sở dữ liệu: " + e.getMessage());
            }
        } else {
            System.out.println("Complete date is null. Không thể cập nhật trạng thái.");
        }
    }


    public void SetReplyContent(String replyContent, int applicationId) {
        if (replyContent != null ) {
            try (Connection con = super.getConnection();
                 PreparedStatement st = con.prepareStatement("UPDATE application SET replyContent=?, complete_date=? WHERE application_id=?")) {
                st.setString(1, replyContent);
                // Sử dụng java.sql.Timestamp thay vì java.util.Date
                st.setTimestamp(2, new Timestamp(System.currentTimeMillis())); // Thời gian hiện tại
                st.setInt(3, applicationId);

                // Không cần gọi getAllApplication() ở đây
                //List<Application> applications = ad.getAllApplication();

                // Thực thi truy vấn
                st.executeUpdate();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            } catch (ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
        }
    }


    public List<ApplicationDTO> getAllApplications(String searchParam, String typeAppParam) {
        String sql = "SELECT\n" +
                "    a.application_id,\n" +
                "    ta.type_id,\n" +  // Thêm cột type_id
                "    ta.name AS type_name,\n" +
                "    a.title,\n" +
                "    e1.name AS sender_name,\n" +
                "    e2.name AS receiver_name,\n" +
                "    a.create_date,\n" +
                "    a.status,\n" +
                "    a.content,\n" +
                "    a.file,\n" +
                "    a.complete_date\n" +
                "FROM\n" +
                "    application AS a\n" +
                "    INNER JOIN type_application AS ta ON a.type_id = ta.type_id\n" +
                "    INNER JOIN employee AS e1 ON a.sender_id = e1.employee_id\n" +
                "    INNER JOIN employee AS e2 ON a.receiver_id = e2.employee_id\n";


        if (searchParam != null && !searchParam.isEmpty()) {
            sql += " AND LOWER(a.title) LIKE LOWER(?)";
        }

        if (typeAppParam != null && !typeAppParam.equals("0")) {
            sql += " AND a.type_id = ?";
        }

        sql += " ORDER BY a.create_date DESC";

        List<ApplicationDTO> list = new ArrayList<>();

        try (Connection con = super.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {

            int parameterIndex = 1; // Bắt đầu với index 1 cho các tham số tìm kiếm

            if (searchParam != null && !searchParam.isEmpty()) {
                st.setString(parameterIndex++, "%" + searchParam + "%");
            }
            if (typeAppParam != null && !typeAppParam.equals("0")) {
                st.setInt(parameterIndex, Integer.parseInt(typeAppParam));
            }

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    ApplicationDTO applicationDTO = new ApplicationDTO();
                    applicationDTO.setApplication_id(rs.getInt("application_id"));
                    applicationDTO.setType_id(rs.getInt("type_id")); // Lấy giá trị type_id từ ResultSet
                    applicationDTO.setType_name(rs.getString("type_name"));
                    applicationDTO.setTitle(rs.getString("title"));
                    applicationDTO.setSender_name(rs.getString("sender_name"));
                    applicationDTO.setReceiver_name(rs.getString("receiver_name"));
                    applicationDTO.setCreate_date(rs.getTimestamp("create_date"));
                    applicationDTO.setComplete_date(rs.getTimestamp("complete_date"));
                    if(applicationDTO.getComplete_date()!=null){
                        changeStatus(applicationDTO.getComplete_date(), applicationDTO.getApplication_id());
                    }
                    applicationDTO.setStatus(rs.getString("status"));
                    applicationDTO.setContent(rs.getString("content"));
                    applicationDTO.setFile(rs.getString("file"));

                    applicationDTO.setFormatCreDate(rs.getTimestamp("create_date"));
                    applicationDTO.setFormatComDate(rs.getTimestamp("complete_date"));
                    list.add(applicationDTO);
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi xảy ra khi thực thi truy vấn SQL: " + e.getMessage());
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        return list;
    }
    public static void main(String[] args) {
        // Tạo đối tượng DAO để truy vấn cơ sở dữ liệu
        ApplicationDAO applicationDAO = new ApplicationDAO();

        // Gọi phương thức getAllApplications với chuỗi tìm kiếm là "t"
        String searchParam = "t";
        String typeAppParam = "0"; // Nếu không muốn tìm kiếm theo loại ứng dụng, set giá trị này là "0"

        List<ApplicationDTO> resultList = applicationDAO.getAllApplications(searchParam, typeAppParam);

        // Hiển thị kết quả
        System.out.println("Danh sách các ứng dụng có chứa chuỗi 't':");
        for (ApplicationDTO application : resultList) {
            System.out.println(application);
        }
    }
}




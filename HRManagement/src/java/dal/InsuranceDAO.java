/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import models.Insurance;
import models.InsuranceEmployeeDTO;

/**
 *
 * @author andep
 */
public class InsuranceDAO {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

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

    public ArrayList<InsuranceEmployeeDTO> getAllInsurance(String search, String coverageType, Date fromDate, Date toDate, double premium_amount) {
        ArrayList<InsuranceEmployeeDTO> list = new ArrayList<>();
        String query = "SELECT i.*, e.* \n"
                + "FROM insurance i \n"
                + "INNER JOIN employee e ON i.employee_id = e.employee_id \n"
                + "WHERE 1=1 ";

        if (search != null && !search.isEmpty()) {
            query += "AND (e.name LIKE ? OR e.address LIKE ? OR i.insurance_company LIKE ? OR i.coverage_type LIKE ? OR i.beneficiary LIKE ?)";
        }

        if (coverageType != null && !coverageType.isEmpty()) {
            query += " AND i.coverage_type LIKE ?";
        }

        // Thêm điều kiện tìm kiếm theo ngày nếu có
        if (fromDate != null && toDate != null) {
            query += " AND (i.start_date BETWEEN ? AND ? AND i.end_date BETWEEN ? AND ?)";
        }

        if (premium_amount != 0) {
            query += " AND (i.premium_amount <= ? )";
        }
        query += " ORDER BY i.insurance_id ASC";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            int paramIndex = 1;

            // Nếu có chuỗi tìm kiếm, đặt các tham số tương ứng trong câu truy vấn
            if (search != null && !search.isEmpty()) {
                String likePattern = "%" + search + "%";
                for (int i = 1; i <= 5; i++) { // Số lượng tham số tìm kiếm là 5
                    ps.setString(paramIndex++, likePattern);
                }
            }

            // Nếu có loại phủ sóng, đặt tham số tương ứng trong câu truy vấn
            if (coverageType != null && !coverageType.isEmpty()) {
                ps.setString(paramIndex++, "%" + coverageType + "%");
            }

            // Nếu có ngày bắt đầu và kết thúc, đặt tham số tương ứng trong câu truy vấn
            if (fromDate != null && toDate != null) {
                query += " AND (i.start_date BETWEEN ? AND ? AND i.end_date BETWEEN ? AND ?)";
                ps.setDate(paramIndex++, new java.sql.Date(fromDate.getTime()));
                ps.setDate(paramIndex++, new java.sql.Date(toDate.getTime()));
                ps.setDate(paramIndex++, new java.sql.Date(fromDate.getTime()));
                ps.setDate(paramIndex++, new java.sql.Date(toDate.getTime()));
            }
            if (premium_amount != 0) {
                ps.setDouble(paramIndex++, premium_amount);
            }
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new InsuranceEmployeeDTO(
                        rs.getInt("insurance_id"),
                        rs.getInt("employee_id"),
                        rs.getString("insurance_company"),
                        rs.getString("policy_number"),
                        rs.getString("coverage_type"),
                        rs.getDate("start_date"),
                        rs.getDate("end_date"),
                        rs.getDouble("premium_amount"),
                        rs.getDouble("deductible"),
                        rs.getDouble("co_pay"),
                        rs.getString("coverage_details"),
                        rs.getString("policy_type"),
                        rs.getString("policy_issuer"),
                        rs.getString("beneficiary"),
                        rs.getDouble("coverage_limit"),
                        rs.getDate("renewal_date"),
                        rs.getString("name"),
                        rs.getString("phoneNumber"),
                        rs.getString("address"),
                        rs.getString("email"),
                        rs.getBoolean("gender"),
                        rs.getString("image"),
                        rs.getString("birth_date"),
                        rs.getString("hire_date"),
                        rs.getInt("user_id")
                ));
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

    public ArrayList<InsuranceEmployeeDTO> getAllType() {
        ArrayList<InsuranceEmployeeDTO> typeList = new ArrayList<>();

        try {
            con = new DBContext().getConnection();
            String query = "SELECT DISTINCT coverage_type FROM insurance";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                InsuranceEmployeeDTO insuranceType = new InsuranceEmployeeDTO();
                insuranceType.setCoverageType(rs.getString("coverage_type"));
                typeList.add(insuranceType);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý ngoại lệ
        } finally {
            // Đóng các tài nguyên
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
            } catch (Exception ex) {
                ex.printStackTrace();
                // Xử lý ngoại lệ khi đóng tài nguyên
            }
        }

        return typeList;
    }

    public InsuranceEmployeeDTO getInsuranceById(int insuranceId) {
        InsuranceEmployeeDTO insurance = null;
        String query = "SELECT i.*, e.* "
                + "FROM insurance i "
                + "INNER JOIN employee e ON i.employee_id = e.employee_id "
                + "WHERE i.insurance_id = ?";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, insuranceId);
            rs = ps.executeQuery();

            if (rs.next()) {
                insurance = new InsuranceEmployeeDTO(
                        rs.getInt("insurance_id"),
                        rs.getInt("employee_id"),
                        rs.getString("insurance_company"),
                        rs.getString("policy_number"),
                        rs.getString("coverage_type"),
                        rs.getDate("start_date"),
                        rs.getDate("end_date"),
                        rs.getDouble("premium_amount"),
                        rs.getDouble("deductible"),
                        rs.getDouble("co_pay"),
                        rs.getString("coverage_details"),
                        rs.getString("policy_type"),
                        rs.getString("policy_issuer"),
                        rs.getString("beneficiary"),
                        rs.getDouble("coverage_limit"),
                        rs.getDate("renewal_date"),
                        rs.getString("name"),
                        rs.getString("phoneNumber"),
                        rs.getString("address"),
                        rs.getString("email"),
                        rs.getBoolean("gender"),
                        rs.getString("image"),
                        rs.getString("birth_date"),
                        rs.getString("hire_date"),
                        rs.getInt("user_id")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
        return insurance;
    }

    public void deleteInsurance(int id) {
        String query = "DELETE FROM insurance WHERE insurance_id = ?";
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

    
}

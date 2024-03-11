/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configs.headerInfor;
import dal.AttendanceDAO;
import dal.DepartmentDAO;
import dal.EmployeeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.AttendanceDepartmentDTO;
import models.Department;
import models.Employee;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author ThuyVy
 */
@WebServlet(name = "ExportFileController", urlPatterns = {"/ExportFileController"})
public class ExportFileController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        headerInfor.setSessionAttributes(request);
        String exportType = request.getParameter("exportType");

        if ("department".equals(exportType)) {
            exportDepartmentList(response);
        } else if ("employee".equals(exportType)) {
            exportEmployeeList(response);
        } else if ("attendance".equals(exportType)) {
            exportAttendanceReport(response);
        }
        request.getRequestDispatcher("ExportFile.jsp").forward(request, response);
    }

    private void exportDepartmentList(HttpServletResponse response) throws IOException {
        DepartmentDAO departmentDAO = new DepartmentDAO();
        ArrayList<Department> departmentList = departmentDAO.getAllDepartments("");

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"); // Thiết lập kiểu MIME cho file Excel
        response.setHeader("Content-Disposition", "attachment; filename=\"ListDepartment.xlsx\""); // Thiết lập tiêu đề phản hồi để trình duyệt hiển thị hộp thoại tải xuống

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            XSSFWorkbook workbook = new XSSFWorkbook();
            XSSFSheet workSheet = workbook.createSheet("1");
            XSSFRow row;
            XSSFCell cell0;
            XSSFCell cell1;
            XSSFCell cell2;

            row = workSheet.createRow(0);
            cell0 = row.createCell(0);
            cell0.setCellValue("Department Id");
            cell1 = row.createCell(1);
            cell1.setCellValue("Department Name");
            cell2 = row.createCell(2);
            cell2.setCellValue("Department Code");

            int i = 0;
            for (Department pro : departmentList) {
                i++;
                row = workSheet.createRow(i);
                cell0 = row.createCell(0);
                cell0.setCellValue(pro.getDepartment_id());
                cell1 = row.createCell(1);
                cell1.setCellValue(pro.getName());
                cell2 = row.createCell(2);
                cell2.setCellValue(pro.getDep_code());
            }
            workbook.write(outputStream);
            workbook.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    private void exportEmployeeList(HttpServletResponse response) throws IOException {
        EmployeeDAO e = new EmployeeDAO();
        List<Employee> employeeList = null;
        try {
            employeeList = e.getAllEmployees("");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ExportDetailsServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"); // Thiết lập kiểu MIME cho file Excel
        response.setHeader("Content-Disposition", "attachment; filename=\"ListEmployee.xlsx\""); // Thiết lập tiêu đề phản hồi để trình duyệt hiển thị hộp thoại tải xuống

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            XSSFWorkbook workbook = new XSSFWorkbook();
            XSSFSheet workSheet = workbook.createSheet("1");
            XSSFRow row;
            XSSFCell cell0;
            XSSFCell cell1;
            XSSFCell cell2;
            XSSFCell cell3;
            XSSFCell cell4;

            row = workSheet.createRow(0);
            cell0 = row.createCell(0);
            cell0.setCellValue("Employee Id");
            cell1 = row.createCell(1);
            cell1.setCellValue("Employee Name");
            cell2 = row.createCell(2);
            cell2.setCellValue("Email");
            cell3 = row.createCell(3);
            cell3.setCellValue("Mobile");
            cell4 = row.createCell(4);
            cell4.setCellValue("Hire Date");

            int i = 0;
            for (Employee pro : employeeList) {
                i++;
                row = workSheet.createRow(i);
                cell0 = row.createCell(0);
                cell0.setCellValue(pro.getEmployeeId());
                cell1 = row.createCell(1);
                cell1.setCellValue(pro.getName());
                cell2 = row.createCell(2);
                cell2.setCellValue(pro.getEmail());
                cell3 = row.createCell(3);
                cell3.setCellValue(pro.getPhoneNumber());
                cell4 = row.createCell(4);
                cell4.setCellValue(pro.getHireDate());
            }
            workbook.write(outputStream);
            workbook.close();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    private void exportAttendanceReport(HttpServletResponse response) throws IOException {
        Date fromDate = null;
        Date toDate = null;
        // Xử lý fromDate và toDate
        String fromDateStr = "";
        String toDateStr = "";
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            if (fromDateStr != null && !fromDateStr.isEmpty()) {
                fromDate = dateFormat.parse(fromDateStr);
            }
            if (toDateStr != null && !toDateStr.isEmpty()) {
                toDate = dateFormat.parse(toDateStr);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        AttendanceDAO attendanceDAO = new AttendanceDAO();
        ArrayList<AttendanceDepartmentDTO> attendanceList = attendanceDAO.getAllAttendance("", "", fromDate == null ? null : fromDate, toDate == null ? null : toDate);

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"); // Thiết lập kiểu MIME cho file Excel
        response.setHeader("Content-Disposition", "attachment; filename=\"ListAttendance.xlsx\""); // Thiết lập tiêu đề phản hồi để trình duyệt hiển thị hộp thoại tải xuống

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            XSSFWorkbook workbook = new XSSFWorkbook();
            XSSFSheet workSheet = workbook.createSheet("1");
            XSSFRow row;
            XSSFCell cell;

            // Create header row
            row = workSheet.createRow(0);
            cell = row.createCell(0);
            cell.setCellValue("Attendance ID");
            cell = row.createCell(1);
            cell.setCellValue("Name");
            cell = row.createCell(2);
            cell.setCellValue("Department");
            cell = row.createCell(3);
            cell.setCellValue("Date");
            cell = row.createCell(4);
            cell.setCellValue("Status");
            cell = row.createCell(5);
            cell.setCellValue("Message");
            cell = row.createCell(6);
            cell.setCellValue("Check In");
            cell = row.createCell(7);
            cell.setCellValue("In Status");
            cell = row.createCell(8);
            cell.setCellValue("Check Out");
            cell = row.createCell(9);
            cell.setCellValue("Out Status");
            cell = row.createCell(10);
            cell.setCellValue("Remain Day");

            int rowNum = 1;
            for (AttendanceDepartmentDTO attendance : attendanceList) {
                row = workSheet.createRow(rowNum++);
                row.createCell(0).setCellValue(attendance.getAttendance_id());
                row.createCell(1).setCellValue(attendance.getEm_name());
                row.createCell(2).setCellValue(attendance.getDep_name());
                row.createCell(3).setCellValue(attendance.getDate());
                row.createCell(4).setCellValue(attendance.getStatus());
                row.createCell(5).setCellValue(attendance.getNotes());
                row.createCell(6).setCellValue(attendance.getIn_time());
                row.createCell(7).setCellValue(attendance.getIn_status());
                row.createCell(8).setCellValue(attendance.getOut_time());
                row.createCell(9).setCellValue(attendance.getOut_status());
                row.createCell(10).setCellValue(attendance.getRemainDay());
            }
            workbook.write(outputStream);
            workbook.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        processRequest(request, response);

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

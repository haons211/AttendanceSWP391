/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configs.headerInfor;
import dal.AttendanceDAO;
import dal.DepartmentDAO;
import dal.EmployeeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.AttendanceReport;
import models.Department;
import models.Employee;

/**
 *
 * @author ThuyVy
 */
@WebServlet(name = "ExportDetailsServlet", urlPatterns = {"/ExportDetailsServlet"})
public class ExportDetailsServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ExportDetailsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ExportDetailsServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        headerInfor.setSessionAttributes(request);
        String exportType = request.getParameter("exportType");
        String detailData = "";

        if ("department".equals(exportType)) {
            DepartmentDAO d = new DepartmentDAO();
            ArrayList<Department> list = new ArrayList<>();
            list = d.getAllDepartments("");

            // Tạo HTML cho bảng phòng ban
            detailData += "<table class=\"table table-striped custom-table mb-0 datatable\">";
            detailData += "<thead>";
            detailData += "<tr>";
            detailData += "<th>#</th>";
            detailData += "<th>Department Name</th>";
            detailData += "<th>Department Code</th>";
            detailData += "</tr>";
            detailData += "</thead>";
            detailData += "<tbody>";

            for (Department department : list) {
                detailData += "<tr>";
                detailData += "<td>" + department.getDepartment_id() + "</td>";
                detailData += "<td>" + department.getName() + "</td>";
                detailData += "<td>" + department.getDep_code() + "</td>";
                detailData += "</tr>";
            }

            detailData += "</tbody>";
            detailData += "</table>";
        } else if ("employee".equals(exportType)) {
            EmployeeDAO e = new EmployeeDAO();
            List<Employee> list = null;
            try {
                list = e.getAllEmployees("");
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(ExportDetailsServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            // Tạo HTML cho bảng nhân viên
            detailData += "<table class=\"table table-striped custom-table mb-0 datatable\">";
            detailData += "<thead>";
            detailData += "<tr>";
            detailData += "<th>Employee ID</th>";
            detailData += "<th style=\"min-width:200px;\">Name</th>";
            detailData += "<th>Email</th>";
            detailData += "<th>Mobile</th>";
            detailData += "<th style=\"min-width: 110px;\">Hire Date</th>";
            detailData += "</tr>";
            detailData += "</thead>";
            detailData += "<tbody>";

            for (Employee employee : list) {
                detailData += "<tr>";
                detailData += "<td>" + employee.getEmployeeId() + "</td>";
                detailData += "<td>" + employee.getName() + "</td>";
                detailData += "<td>" + employee.getEmail() + "</td>";
                detailData += "<td>" + employee.getPhoneNumber() + "</td>";
                detailData += "<td>" + employee.getHireDate() + "</td>";
                detailData += "</tr>";
            }

            detailData += "</tbody>";
            detailData += "</table>";
        } else if ("attendance".equals(exportType)) {

            Date fromDate = null;
            Date toDate = null;
            // Xử lý fromDate và toDate
            String fromDateStr = request.getParameter("fromDate");
            String toDateStr = request.getParameter("toDate");
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
            ArrayList<AttendanceReport> attendanceList = attendanceDAO.getAllAttendance("", "", fromDate == null ? null : fromDate, toDate == null ? null : toDate);
            // Generate HTML for the attendance table
            detailData += "<table class=\"table table-striped custom-table mb-0 datatable\">";
            detailData += "<thead>";
            detailData += "<tr>";
            detailData += "<th>ID</th>";
            detailData += "<th>Name</th>";
            detailData += "<th>Department</th>";
            detailData += "<th>Date</th>";
            detailData += "<th>Status</th>";
            detailData += "<th>Message</th>";
            detailData += "<th>Check In</th>";
            detailData += "<th>In Status</th>";
            detailData += "<th>Check Out</th>";
            detailData += "<th>Out Status</th>";
            detailData += "<th>Remain Day</th>";
            detailData += "</tr>";
            detailData += "</thead>";
            detailData += "<tbody>";

            for (AttendanceReport attendance : attendanceList) {
                detailData += "<tr>";
                detailData += "<td>" + attendance.getAttendance_id() + "</td>";
                detailData += "<td>" + attendance.getEm_name() + "</td>";
                detailData += "<td>" + attendance.getDep_name()+ "</td>";
                detailData += "<td>" + attendance.getDate() + "</td>";
                detailData += "<td>" + attendance.getStatus() + "</td>";
                detailData += "<td>" + attendance.getNotes()+ "</td>";
                detailData += "<td>" + attendance.getIn_time() + "</td>";
                detailData += "<td>" + attendance.getIn_status() + "</td>";
                detailData += "<td>" + attendance.getOut_time() + "</td>";
                detailData += "<td>" + attendance.getOut_status() + "</td>";
                detailData += "<td>" + attendance.getRemainDay() + "</td>";
                detailData += "</tr>";
            }

            detailData += "</tbody>";
            detailData += "</table>";
        }

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.write(detailData);
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

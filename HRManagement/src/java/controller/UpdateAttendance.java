/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configs.Validate;
import dal.AttendanceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import models.Attendance;
import models.AttendanceReport;

/**
 *
 * @author andep
 */
@WebServlet(name = "UpdateAttendance", urlPatterns = {"/updateAttendance"})
public class UpdateAttendance extends HttpServlet {

    private Validate validate = new Validate();

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
            out.println("<title>Servlet UpdateAttendance</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateAttendance at " + request.getContextPath() + "</h1>");
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
        AttendanceDAO d = new AttendanceDAO();
        int id = Integer.parseInt(request.getParameter("aid"));
        AttendanceReport ar = d.getAttendanceReportById(id);
        request.setAttribute("ar", ar);
        // Trong phương thức doGet hoặc doGet
        String successMessage = (String) request.getSession().getAttribute("successMessage");
        if (successMessage != null) {
            request.getSession().removeAttribute("successMessage"); // Xóa thông điệp sau khi sử dụng
            request.setAttribute("successMessage", successMessage);
        }

        request.getRequestDispatcher("UpdateAttendance.jsp").forward(request, response);
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
        String id = request.getParameter("id");
        String date = request.getParameter("date");
        String status = request.getParameter("status");
        String message = request.getParameter("message");
        String checkin = request.getParameter("checkin");
        String checkout = request.getParameter("checkout");
        String instatus = request.getParameter("instatus");
        String outstatus = request.getParameter("outstatus");
        String remainday = request.getParameter("remainday");
        String approvedLeaveDays = request.getParameter("approvedLeaveDays");

        int remaindayInt = 0;
        int approvedLeaveDaysInt = 0;
        if (approvedLeaveDays != null) {
            approvedLeaveDaysInt = Integer.parseInt(approvedLeaveDays);
        }

        AttendanceDAO dao = new AttendanceDAO();

        int attendanceId = Integer.parseInt(id);
        request.setAttribute("id", attendanceId);

        int count = 0;
        if (remainday == null || remainday.isEmpty()) {
            request.setAttribute("remaindayError", "Remaining days cannot be empty");
            count++;
        } else {
            try {
                remaindayInt = Integer.parseInt(remainday);
                if (remaindayInt <= 0) {
                    request.setAttribute("remaindayError", "Remaining days must be greater than or equal to 0");
                    count++;
                }
            } catch (NumberFormatException e) {
                request.setAttribute("remaindayError", "Invalid input! Please enter a valid integer");
                count++;
            }
        }
        
        if (!validate.validateTime(checkin, checkout)) {
            request.setAttribute("checkInError", "Check-in time must be earlier than check-out time");
            count++;
        }
        if (!validate.validateDateBeforeToday(date)) {
            request.setAttribute("dateError", "Date must be before today");
            count++;
        }
        if (!validate.validateRemainDay(remaindayInt, approvedLeaveDaysInt)) {
            request.setAttribute("remaindayError", "Remaining days must be less than or equal to approved leave days");
            count++;
        }
        if (count > 0) {
            request.setAttribute("ar", dao.getAttendanceReportById(attendanceId));
            request.getRequestDispatcher("UpdateAttendance.jsp").forward(request, response);

        } else {
            // Create Employee object with updated information

            // Update the employee in the database
            dao.updateAttendance(attendanceId, checkin, checkout, message, status, instatus, outstatus, remaindayInt, date);
            // Redirect to the list-employee servlet or page
            response.sendRedirect("AttendanceReport");
        }
    }

    @Override
    public String getServletInfo() {
        return "Update Employee Servlet";
    }
}

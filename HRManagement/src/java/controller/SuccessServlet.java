/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AttendanceDAO;
import dal.EmployeeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import models.AccountDTO;
import models.Attendance;
import models.Employee;

/**
 *
 * @author ThuyVy
 */
@WebServlet(name = "SuccessServlet", urlPatterns = {"/SuccessServlet"})
public class SuccessServlet extends HttpServlet {

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
            HttpSession session = request.getSession();

            if (session != null) {
                AccountDTO acc = (AccountDTO) session.getAttribute("account");
                EmployeeDAO dao = new EmployeeDAO();
//            RemaindayDAO DAO = new RemaindayDAO();
                if (acc != null) {
                    try {
                        Employee em = dao.getin4(acc.getUserID());
                        request.setAttribute("emp", em);
                        int attendanceId = (int) session.getAttribute("attendanceId");
                        AttendanceDAO attendanceDAO = new AttendanceDAO();
//         Attendance attendance = (Attendance) session.getAttribute("attendance");
//                        Attendance attendance = attendanceDAO.getAttendanceById(attendanceId);
                        // Đặt thông tin attendance vào request attribute của Success.jsp
//                        request.setAttribute("attendance", attendance);
//                        System.out.println(attendance.toString());
                        Timestamp checkInTime = (Timestamp) session.getAttribute("checkInTime");
                        request.setAttribute("checkInTime", checkInTime);
                        Timestamp checkOutTime = (Timestamp) session.getAttribute("checkOutTime");
                        request.setAttribute("checkOutTime", checkOutTime);
                        
                    } catch (Exception e) {
                    }

                    if (acc == null) {
                        response.sendRedirect("Login");
                    } else {
                        request.getRequestDispatcher("Success.jsp").forward(request, response);
                    }
                }
            }
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
//        HttpSession session = request.getSession();
//        int attendanceId = (int) session.getAttribute("attendanceId");
//        AttendanceDAO attendanceDAO = new AttendanceDAO();
////         Attendance attendance = (Attendance) session.getAttribute("attendance");
//        Attendance attendance = attendanceDAO.getAttendanceById(attendanceId);
//        // Đặt thông tin attendance vào request attribute của Success.jsp
//        request.setAttribute("attendance", attendance);
//
//        // Chuyển tiếp sang trang Success.jsp
//        request.getRequestDispatcher("Success.jsp").forward(request, response);
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

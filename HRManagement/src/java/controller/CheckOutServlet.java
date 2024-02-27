/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configs.headerInfor;
import dal.AttendanceDAO;
import dal.EmployeeDAO;
import dal.RemaindayDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.Date;
import models.AccountDTO;
import models.Attendance;
import models.Employee;

/**
 *
 * @author ThuyVy
 */
@WebServlet(name = "CheckOutServlet", urlPatterns = {"/CheckOutServlet"})
public class CheckOutServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        headerInfor.setSessionAttributes(request);
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            AccountDTO acc = (AccountDTO) session.getAttribute("account");
            EmployeeDAO dao = new EmployeeDAO();
            RemaindayDAO DAO = new RemaindayDAO();
            try {
                Employee em = dao.getin4(acc.getUserID());
                int remainDay = DAO.getRemainDayById(em.getEmployeeId());
                request.setAttribute("re", remainDay);
                request.setAttribute("emp", em);
                int attendanceId = (int) session.getAttribute("attendanceId");
                request.setAttribute("attendanceId", attendanceId);
                Timestamp checkOutTime = new Timestamp(System.currentTimeMillis());
                session.setAttribute("checkOutTime", checkOutTime);
                Timestamp checkInTime = (Timestamp) session.getAttribute("checkInTime");
                request.setAttribute("checkInTime", checkInTime);
                

            } catch (Exception e) {
            }

            if (acc == null) {
                response.sendRedirect("Login");
            } else {
                request.getRequestDispatcher("CheckOut.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
headerInfor.setSessionAttributes(request);
        if (session != null) {
            AccountDTO acc = (AccountDTO) session.getAttribute("account");
            EmployeeDAO dao = new EmployeeDAO();
            RemaindayDAO DAO = new RemaindayDAO();
            if (acc != null) {
                try {
                    Employee em = dao.getin4(acc.getUserID());
                    int remainDay = DAO.getRemainDayById(em.getEmployeeId());
                    request.setAttribute("re", remainDay);
                    request.setAttribute("emp", em);
                    int attendanceId = (int) session.getAttribute("attendanceId");
                    System.out.println("con so may man la" + attendanceId);
                    // Gọi phương thức DAO để cập nhật dữ liệu Check Out vào cơ sở dữ liệu
                    AttendanceDAO attendanceDAO = new AttendanceDAO();
                    attendanceDAO.CheckOut(attendanceId);
                    Attendance attendance = attendanceDAO.getAttendanceById(attendanceId);
                    request.setAttribute("attendance", attendance);
                    System.out.println(attendance.toString());
                    Timestamp checkOutTime = new Timestamp(System.currentTimeMillis());
                session.setAttribute("checkOutTime", checkOutTime);
                Timestamp checkInTime = (Timestamp) session.getAttribute("checkInTime");
                request.setAttribute("checkInTime", checkInTime);
                System.out.println(checkInTime+"va"+ checkOutTime);
                } catch (Exception e) {
                    System.out.println(e);
                }

                if (acc == null) {
                    response.sendRedirect("Login");
                } else {
                    request.getRequestDispatcher("Success.jsp").forward(request, response);
                }

            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
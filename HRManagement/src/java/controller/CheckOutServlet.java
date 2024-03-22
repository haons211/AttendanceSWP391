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
import java.sql.SQLException;
import java.sql.Timestamp;
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
            AttendanceDAO atDao = new AttendanceDAO();
            try {
                Employee em = dao.getin4(acc.getUserID());
                Attendance attendanceCheck = atDao.getAttendanceByEmployeeId(em.getEmployeeId());

                int remainDay = DAO.getRemainDayById(em.getEmployeeId());
                session.setAttribute("re", remainDay);
                request.setAttribute("emp", em);
                session.setAttribute("checkOutTime", attendanceCheck.getOut_time());
                session.setAttribute("checkInTime", attendanceCheck.getIn_time());
                request.getRequestDispatcher("CheckOut.jsp").forward(request, response);
            } catch (ServletException | IOException | ClassNotFoundException | SQLException e) {
                System.out.println(e);
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
                    session.setAttribute("re", remainDay);
                    request.setAttribute("emp", em);
                    int attendanceId = (int) session.getAttribute("attendanceId");
                    AttendanceDAO attendanceDAO = new AttendanceDAO();
                    attendanceDAO.CheckOut(attendanceId);
                    Attendance attendanceCheck = attendanceDAO.getAttendanceByEmployeeId(em.getEmployeeId());
                    request.setAttribute("attendance", attendanceCheck);
                    
                    session.setAttribute("checkOutTime", attendanceCheck.getOut_time());
                    
                    session.setAttribute("checkInTime", attendanceCheck.getIn_time());
                    session.setAttribute("checkedOut", true);
                } catch (Exception e) {
                    System.out.println(e);
                }

                request.getRequestDispatcher("Success.jsp").forward(request, response);

            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}




package controller;

import configs.headerInfor;
import dal.AttendanceDAO;
import dal.EmployeeDAO;
import dal.RemaindayDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.AccountDTO;
import models.Attendance;
import models.Employee;

@WebServlet(name = "EmployeesController", urlPatterns = {"/HomeEmployees"})
public class EmployeesController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            headerInfor.setSessionAttributes(request);
            HttpSession session = request.getSession();
            AccountDTO acc = (AccountDTO) session.getAttribute("account");
            EmployeeDAO dao = new EmployeeDAO();
            RemaindayDAO DAO = new RemaindayDAO();
            Employee em = dao.getin4(acc.getUserID());
            AttendanceDAO atDao = new AttendanceDAO();
            atDao.CallAttendanceByDay();

//            if (session.getAttribute("checkedOut") != null && (boolean) session.getAttribute("checkedOut")) {
            if (session.getAttribute("checkedOut") != null && (boolean) session.getAttribute("checkedOut")) {
                int attendanceId = (int) session.getAttribute("attendanceId");
                AttendanceDAO attendanceDAO = new AttendanceDAO();
                Attendance attendance = attendanceDAO.getAttendanceById(attendanceId);
                request.setAttribute("attendance", attendance);
                request.getRequestDispatcher("Success.jsp").forward(request, response);

//            } else if (session.getAttribute("checkedIn") != null && (boolean) session.getAttribute("checkedIn")) {
            } else if (session.getAttribute("checkedIn") != null && (boolean) session.getAttribute("checkedIn")) {
                Timestamp timeIn = (Timestamp) session.getAttribute("checkInTime");
                int remainDay = DAO.getRemainDayById(em.getEmployeeId());
                session.setAttribute("checkInTime", timeIn);
                int id = (int) session.getAttribute("attendanceId");
                session.setAttribute("attendanceId", id);
                request.getRequestDispatcher("CheckOut.jsp").forward(request, response);

            } else {
                try {
                    int remainDay = DAO.getRemainDayById(em.getEmployeeId());
                    session.setAttribute("re", remainDay);
                } catch (Exception e) {
                    System.out.println(e);
                }
                request.getRequestDispatcher("HomeEmployees.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session != null) {
            AccountDTO acc = (AccountDTO) session.getAttribute("account");
            if (acc != null) {
                try {
                    headerInfor.setSessionAttributes(request);
                    EmployeeDAO dao = new EmployeeDAO();
                    RemaindayDAO DAO = new RemaindayDAO();
                    Employee em = dao.getin4(acc.getUserID());
                    int remainDay = DAO.getRemainDayById(em.getEmployeeId());
                    session.setAttribute("re", remainDay);
                    request.setAttribute("emp", em);
                    if (em != null) {
                        int em_id = em.getEmployeeId();
                        int remain_id = dao.GetRemainIDfromEmployee(em_id);
                        String notes = request.getParameter("message");
                        AttendanceDAO attendanceDAO = new AttendanceDAO();
                        int attendanceId = attendanceDAO.CheckIn(em_id, notes, remain_id);
                        if (attendanceId != -1) {
                            attendanceDAO.insertCheckStatus(em_id, true, false);
                            Timestamp checkInTime = new Timestamp(System.currentTimeMillis());
                            session.setAttribute("checkInTime", checkInTime);
                            session.setAttribute("attendanceId", attendanceId);
                            session.setAttribute("checkedIn", true);
//                            session.setAttribute("checkedIn", attendanceDAO.getCheckedInStatus(em_id));
                            request.getRequestDispatcher("CheckOut.jsp").forward(request, response);
                            return;
                        }
                    }

                }
                if (acc == null) {
                    response.sendRedirect("Login");
                } else {

//         Nếu không có session hoặc không có account, chuyển hướng đến trang lỗi hoặc xử lý khác
                   response.sendRedirect("error.jsp");

                } catch (SQLException | ClassNotFoundException ex) {
                    System.out.println(ex);

                }
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}

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
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
            Attendance attendanceCheck = atDao.getAttendanceByEmployeeId(em.getEmployeeId());
            if(attendanceCheck.getOut_time()!=null){
                
                session.setAttribute("checkInTime", attendanceCheck.getIn_time());
                
                    session.setAttribute("checkOutTime", attendanceCheck.getOut_time());
                int remainDay = DAO.getRemainDayById(em.getEmployeeId());
                    session.setAttribute("re", remainDay);
                request.setAttribute("attendance", attendanceCheck);
                request.getRequestDispatcher("Success.jsp").forward(request, response);
            }else if(attendanceCheck.getIn_time()!=null && attendanceCheck.getOut_time()==null){
                int remainDay = DAO.getRemainDayById(em.getEmployeeId());
                session.setAttribute("re", remainDay);
                session.setAttribute("checkInTime", attendanceCheck.getIn_time());
                int id = attendanceCheck.getAttendance_id();
                session.setAttribute("attendanceId", id);
                request.getRequestDispatcher("CheckOut.jsp").forward(request, response);
            }
             else {
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
                        if(isValidInput(notes)){
                            notes = sanitizeInput(notes);
                        }
                        AttendanceDAO attendanceDAO = new AttendanceDAO();
                        int attendanceId = attendanceDAO.CheckIn(em_id, notes, remain_id);
                        if (attendanceId != -1) {
                            AttendanceDAO atDao = new AttendanceDAO();
                            Attendance attendanceCheck = atDao.getAttendanceByEmployeeId(em.getEmployeeId());
                            session.setAttribute("checkInTime", attendanceCheck.getIn_time());                            
                            session.setAttribute("attendanceId", attendanceId);
                            session.setAttribute("checkedIn", true);
                            request.getRequestDispatcher("CheckOut.jsp").forward(request, response);
                            return;
                        }
                    }
                } catch (SQLException | ClassNotFoundException ex) {
                    System.out.println(ex);
                }
            }
        }
    }
    
    

        @Override
        public String getServletInfo
        
            () {
        return "Short description";
        }
            
            private boolean isValidInput(String input) {
        return input != null && !input.isEmpty();
    }

// Sanitization method to replace '<' and '>'
    private String sanitizeInput(String input) {
        // Manually replace '<' and '>'
        return input.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
    }
    }


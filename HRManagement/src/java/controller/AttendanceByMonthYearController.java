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
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import models.AttendanceSheet;
import models.Department;
import models.Employee;

/**
 *
 * @author ThuyVy
 */
@WebServlet(name = "AttendanceByMonthYearController", urlPatterns = {"/AttendanceSheet"})
public class AttendanceByMonthYearController extends HttpServlet {

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
            out.println("<title>Servlet AttendanceByMonthYearController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AttendanceByMonthYearController at " + request.getContextPath() + "</h1>");
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
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        heade@rInfor.setSessionAttributes(request);
//
//        
//        EmployeeDAO dao = new EmployeeDAO();
//        List<Employee> employeesList =  new ArrayList<>() ;
//        try {
//            employeesList = dao.getAllEmployees("" );
//        } catch (ClassNotFoundException ex) {
//            Logger.getLogger(ListEmployeeController.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        request.setAttribute("employeeList", employeesList);
//
//       AttendanceDAO attendanceDAO = new AttendanceDAO();
//        ArrayList<AttendanceSheet> attendanceList = attendanceDAO.getAttendanceByEmployeeAndDateRange(2, Month,Year);
//        System.out.println(attendanceList.toString());
//        // Lưu danh sách vào request attribute để truyền tới jsp
//        request.setAttribute("list", attendanceList);
//        // Chuyển hướng đến trang jsp để hiển thị danh sách
//        request.getRequestDispatcher("AttendanceByMonthYear.jsp").forward(request, response);
//    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        headerInfor.setSessionAttributes(request);

        Calendar calendar = Calendar.getInstance();
        int currentMonth = calendar.get(Calendar.MONTH) + 1;
        int currentYear = calendar.get(Calendar.YEAR);

        String search = request.getParameter("search");
        String month = request.getParameter("Month");
        String year = request.getParameter("Year");
        // Get employee list
        EmployeeDAO dao = new EmployeeDAO();
        List<Employee> employeesList = new ArrayList<>();
        try {
            employeesList = dao.getAllEmployees(search == null ? "" : search);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AttendanceByMonthYearController.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.setAttribute("employeeList", employeesList);

        // Get attendance lists for each employee
        AttendanceDAO attendanceDAO = new AttendanceDAO();
        ArrayList<List<AttendanceSheet>> allAttendanceLists = new ArrayList<>();

        // Iterate over employees to fetch attendance for each one
        for (Employee employee : employeesList) {
            ArrayList<AttendanceSheet> employeeAttendanceList = attendanceDAO.getAttendanceByEmployeeAndDateRange(
                    employee.getEmployeeId(), (month == null || month.isEmpty()) ? String.format("%02d", currentMonth) : month, (year == null || year.isEmpty()) ? String.valueOf(currentYear) : year);
            allAttendanceLists.add(employeeAttendanceList);
        }

        // Set the attribute containing all attendance lists
        request.setAttribute("attendanceLists", allAttendanceLists);

        // Forward to the JSP
        request.getRequestDispatcher("AttendanceByMonthYear.jsp").forward(request, response);
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

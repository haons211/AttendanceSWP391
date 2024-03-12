/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configs.headerInfor;
import dal.BeneficiaryDAO;
import dal.EmployeeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Dependents;
import models.Employee;

/**
 *
 * @author andep
 */
@WebServlet(name = "AllBeneficiaryController", urlPatterns = {"/beneficiary"})
public class AllBeneficiaryController extends HttpServlet {

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
            out.println("<title>Servlet AllBeneficiaryController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AllBeneficiaryController at " + request.getContextPath() + "</h1>");
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
        headerInfor.setSessionAttributes(request);
        int id_employee = 0;
        HttpSession session = request.getSession();
        if (session != null) {
            id_employee = (int) session.getAttribute("Iid");
        }
        EmployeeDAO dao = new EmployeeDAO();
        try {
            Employee employee = dao.getEmployeeById(id_employee);
            request.setAttribute("employee", employee);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AllBeneficiaryController.class.getName()).log(Level.SEVERE, null, ex);
        }
        String relationship = request.getParameter("relationship");
        String search = request.getParameter("search");

        Date fromDate = null;
        Date toDate = null;
        // Xử lý fromDate và toDate
        String fromDateStr = request.getParameter("fromDate");
        String toDateStr = request.getParameter("toDate");
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        if (fromDateStr != null && !fromDateStr.isEmpty()) {
            try {
                fromDate = dateFormat.parse(fromDateStr);
            } catch (ParseException ex) {
                Logger.getLogger(AllBeneficiaryController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        if (toDateStr != null && !toDateStr.isEmpty()) {
            try {
                toDate = dateFormat.parse(toDateStr);
            } catch (ParseException ex) {
                Logger.getLogger(AllBeneficiaryController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        // Gọi phương thức DAO để lấy danh sách AttendanceReport
        BeneficiaryDAO d = new BeneficiaryDAO();
        ArrayList<Dependents> beneficiaryList;

        beneficiaryList = d.getBeneficiaryByEmployeeID(id_employee,
                search == null ? "" : search, relationship,
                fromDate == null ? null : fromDate, toDate == null ? null : toDate);

        request.setAttribute("list", beneficiaryList);

        // Chuyển hướng đến trang jsp để hiển thị danh sách
        request.getRequestDispatcher("Beneficiary.jsp").forward(request, response);
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

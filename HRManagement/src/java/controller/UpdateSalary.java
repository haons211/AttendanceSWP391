/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountDAO;
import dal.DepartmentDAO;
import dal.EmployeeDAO;
import dal.SalaryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.AccountDTO;
import models.Department;
import models.Employee;
import models.Salary;

/**
 *
 * @author Dan
 */
@WebServlet(name = "UpdateSalaryController", urlPatterns = {"/UpdateSalary"})
public class UpdateSalary extends HttpServlet {

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
            out.println("<title>Servlet UpdateSalary</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateSalary at " + request.getContextPath() + "</h1>");
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
        int id = Integer.parseInt(request.getParameter("id"));
        SalaryDAO dao = new SalaryDAO();
        EmployeeDAO edao = new EmployeeDAO();
        DepartmentDAO ddao = new DepartmentDAO();
        AccountDAO adao = new AccountDAO();
      
        try {
            Salary salary = dao.getSalaryById(id);
            Employee employee = edao.getEmployeeById(salary.getEmployeeId());
            Department department = ddao.getDepartmentById(salary.getDepartmentId());
            AccountDTO account = adao.getUserById(salary.getUserId());
            String username = account.getUserName();
            request.setAttribute("leaveDay",dao.getLeaveDayById(adao.getIdByUsername(username).getUserID()) );
            request.setAttribute("id", id);
            request.setAttribute("account", account);
            request.setAttribute("salary", salary);
            request.setAttribute("employee", employee);
            request.setAttribute("department", department);

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UpdateSalary.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UpdateSalary.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.getRequestDispatcher("UpdateSalary.jsp").forward(request, response);
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
       
        int id = Integer.parseInt(request.getParameter("id"));
       
        double allowance = Double.parseDouble(request.getParameter("allowance"));
        double tax = Double.parseDouble(request.getParameter("tax"));
        double bonus = Double.parseDouble(request.getParameter("bonus"));
        SalaryDAO dao = new SalaryDAO();
        try {
            dao.updateSalary(new Salary( allowance, tax, bonus) ,id);
            response.sendRedirect("ListSalary");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UpdateSalary.class.getName()).log(Level.SEVERE, null, ex);
        }
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

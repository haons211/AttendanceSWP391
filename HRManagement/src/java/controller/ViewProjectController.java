/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configs.headerInfor;
import dal.EmployeeDAO;
import dal.ProjectDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.AccountDTO;
import models.Employee;
import models.Project;

/**
 *
 * @author NCM
 */
@WebServlet(name = "ViewProjectController", urlPatterns = {"/ViewProject"})
public class ViewProjectController extends HttpServlet {

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
            out.println("<title>Servlet ViewProjectController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewProjectController at " + request.getContextPath() + "</h1>");
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
        try {
            HttpSession session = request.getSession();
            AccountDTO acc = (AccountDTO) session.getAttribute("account");
            headerInfor.setSessionAttributes(request);
            EmployeeDAO dao = new EmployeeDAO();
            Employee em = dao.getin4(acc.getUserID());
            ProjectDao pdDao = new ProjectDao();

            Boolean mess = (Boolean) request.getSession().getAttribute("mess");
            Boolean mess1 = (Boolean) request.getSession().getAttribute("mess1");
            Boolean mess2 = (Boolean) request.getSession().getAttribute("mess2");
            request.getSession().removeAttribute("mess");
            request.getSession().removeAttribute("mess1");
            request.getSession().removeAttribute("mess2");

            request.setAttribute("mess", mess);
        
        if (mess1 != null) {
            request.setAttribute("mess1", mess1);
        }
        if (mess2 != null) {
            request.setAttribute("mess2", mess2);
        }
        List<Project> listProjectForManager = new ArrayList<>();
        if (acc.getRole() == 3) {
            listProjectForManager = pdDao.getAllProject(em.getEmployeeId());
        } else if (acc.getRole() == 2) {
            listProjectForManager = pdDao.getAllProjectforEmployee(em.getEmployeeId());
        }

        request.setAttribute("lpformanager", listProjectForManager);
        request.getRequestDispatcher("viewAllProject.jsp").forward(request, response);
    }
    catch (SQLException ex

    
        ) {
            Logger.getLogger(ViewProjectController.class.getName()).log(Level.SEVERE, null, ex);
    }
    catch (ClassNotFoundException ex

    
        ) {
            Logger.getLogger(ViewProjectController.class.getName()).log(Level.SEVERE, null, ex);
    }
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

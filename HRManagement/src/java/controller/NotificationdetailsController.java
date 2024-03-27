package controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import configs.headerInfor;
import dal.EmployeeDAO;
import dal.NotificationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.AccountDTO;
import models.Employee;
import models.Notification;

/**
 *
 * @author NCM
 */
@WebServlet(urlPatterns = {"/AllNotification"})
public class NotificationdetailsController extends HttpServlet {

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
        HttpSession session = request.getSession();
        AccountDTO acc = (AccountDTO) session.getAttribute("account");
        EmployeeDAO edao = new EmployeeDAO();
        NotificationDAO ndao = new NotificationDAO();
        List<Notification> listNotification = ndao.getAllNotification();
        headerInfor.setSessionAttributes(request);
        request.setAttribute("listNo1", listNotification);
        request.getRequestDispatcher("allNotification.jsp").forward(request, response);
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
        processRequest(request, response);

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
        try {
            HttpSession session = request.getSession();
            AccountDTO acc = (AccountDTO) session.getAttribute("account");
            EmployeeDAO edao = new EmployeeDAO();
            NotificationDAO ndao = new NotificationDAO();
            NotificationDAO NDao = new NotificationDAO();
            List<Notification> listNotification = ndao.getAllNotification();
            
            
            Employee em = edao.getin4(acc.getUserID());
            request.setAttribute("emp", em);
            
            
            
            String search = request.getParameter("search");
            int month = Integer.parseInt(request.getParameter("Month"));
            int Year = Integer.parseInt(request.getParameter("Year"));
            // LocalDate cho ngày không chứa thông tin về thời gian
            List<Notification> listNotification1 = NDao.searchNotification(search, Year, month);
            request.setAttribute("listNo", listNotification);
            request.setAttribute("listNo1", listNotification1);
            
            request.getRequestDispatcher("allNotification.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(NotificationdetailsController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(NotificationdetailsController.class.getName()).log(Level.SEVERE, null, ex);
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

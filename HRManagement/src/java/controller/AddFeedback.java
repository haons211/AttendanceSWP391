/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.FeedbackDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.AccountDTO;
import models.Feedback;

/**
 *
 * @author Dan
 */
@WebServlet(name = "AddFeedbackController", urlPatterns = {"/AddFeedback"})
public class AddFeedback extends HttpServlet {

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
            out.println("<title>Servlet AddFeedback</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddFeedback at " + request.getContextPath() + "</h1>");
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
        
        HttpSession session = request.getSession();
        AccountDTO acc = (AccountDTO) session.getAttribute("account");
        FeedbackDAO dao = new FeedbackDAO();
        String search = "";
        try {
            List<Feedback> list = dao.getAllTitles(search == null ? "" : search, acc.getUserID());
            request.setAttribute("listTitle", list);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AddFeedback.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.getRequestDispatcher("AddFeedback.jsp").forward(request, response);
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
        LocalDate currentDate = LocalDate.now();
        String dateString = currentDate.toString();
        HttpSession session = request.getSession();
        AccountDTO acc = (AccountDTO) session.getAttribute("account");
       
        FeedbackDAO dao = new FeedbackDAO();
        String title = request.getParameter("titleSelect");
        String otherTitle = request.getParameter("otherTitle");
        String content = request.getParameter("content");
        System.out.println(title);
         System.out.println(otherTitle);
          System.out.println(content);
          if(title.equals("other")){
              title = null;
          }
          if(otherTitle.equals("")){
              otherTitle = null;
          }
        if (title != null) {
            try {
                dao.addFeedback(new Feedback(acc.getUserID(), title, content, dateString));
            } catch (SQLException ex) {
                Logger.getLogger(AddFeedback.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        if (otherTitle != null) {
            try {
                dao.addFeedback(new Feedback(acc.getUserID(), otherTitle, content, dateString));
            } catch (SQLException ex) {
                Logger.getLogger(AddFeedback.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        response.sendRedirect("Feedback");
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

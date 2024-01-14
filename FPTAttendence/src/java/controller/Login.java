/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.AccountDAO;
import models.AccountDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author NCM
 */
public class Login extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet Login</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Login at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String url = "Login.jsp";
         request.getRequestDispatcher(url).forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            
    throws ServletException, IOException {
        
         try {
           /* TODO output your page here. You may use following sample code. */
           String url ="Login.jsp";
           String button = request.getParameter("btAction");
           String username = request.getParameter("txtUsername");
           String password = request.getParameter("txtPassword");
           String errorMessage = "";
           AccountDAO dao = new AccountDAO();
           AccountDTO account = dao.checkLogin(username, password);
           
           if (account!=null) {
               try {
                  
                   int role = account.getRole();
                   if (role == 2) {
                       url = "HomeEmployees";
                       HttpSession session = request.getSession();
                       session.setAttribute("account", account);
                      response.sendRedirect(url);
                   } else if (role == 3) {
                       url = "HomeManager";
                       HttpSession session = request.getSession();
                       session.setAttribute("account", account);
                       response.sendRedirect(url);
                   }else if (role == 1) {
                       url = "dashboard";
                       HttpSession session = request.getSession();
                       session.setAttribute("account", account);
                       response.sendRedirect(url);}
               } catch (Exception ex) {
                   Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
               }
           }  else {
               errorMessage = "Sai tên đăng nhập hoặc mật khẩu. Vui lòng thử lại.";
               // Kiểm tra nếu người dùng chưa đăng nhập hoặc bị chặn bởi filter, không hiển thị lỗi
               request.setAttribute("error", errorMessage);
               request.getRequestDispatcher(url).forward(request, response);
               return;
           }
       } catch (ClassNotFoundException ex) {
           Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
       } catch (Exception ex) {
           Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
       }

                   
                }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

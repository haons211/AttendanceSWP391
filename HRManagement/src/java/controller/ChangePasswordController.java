/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configs.PasswordEncryption;
import configs.Validate;
import configs.headerInfor;
import dal.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.AccountDTO;

/**
 *
 * @author Dan
 */
@WebServlet(name = "ChangePasswordController", urlPatterns = {"/ChangePassword"})
public class ChangePasswordController extends HttpServlet {

    private final Validate validate = new Validate();
    private final PasswordEncryption passwordEncryption = new PasswordEncryption();

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
            out.println("<title>Servlet ChangePasswordController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePasswordController at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
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
        HttpSession session = request.getSession();
        AccountDTO acc = (AccountDTO) session.getAttribute("account");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");

        String reNewPassword = request.getParameter("reNewPassword");
        String passwordHex = passwordEncryption.hashPasswordMD5(currentPassword);

        String newPasswordHex = passwordEncryption.hashPasswordMD5(newPassword);

        String messageError = "Invalid password. Try again";
        int count = 0;
        
        if(acc == null){
            request.setAttribute("messageErrorCur", messageError);
            count++;
        }
        if (!passwordHex.equals(acc.getPassWord())) {
            request.setAttribute("messageErrorIncorrect", "Current password is incorrect. Please try again.");
            count++;
        }
        if (!newPassword.equals(reNewPassword)) {
            request.setAttribute("messageErrorNotMatch", "New Password does not match. Enter new password again here.");
            count++;
        }

        if (!validate.isPasswordValid(newPassword)) {
            
            request.setAttribute("messageErrorNew", messageError);
            count++;
        }
        if (!validate.isPasswordValid(reNewPassword)) {
            request.setAttribute("messageErrorReNew", messageError);
            count++;
        }
        if (newPassword.equals(currentPassword)) {
            request.setAttribute("messageErrorEqual", "The new password must be different from the current password.");
            count++;
        } 
        if(count > 0){
            request.setAttribute("curPass", currentPassword);
            request.setAttribute("newPass", newPassword);
            request.setAttribute("reNewPass", reNewPassword);
            request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
        }
        else {
            AccountDAO dao = new AccountDAO();
            dao.updatePassword(acc.getUserID(), newPasswordHex);
            acc.setPassWord(newPasswordHex);
            request.setAttribute("successful", "You have successfully changed your password");
            request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
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

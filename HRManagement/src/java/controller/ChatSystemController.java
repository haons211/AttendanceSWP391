/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configs.headerInfor;
import dal.ApplicationDAO;
import dal.ConversationDAO;
import dal.EmployeeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import models.AccountDTO;
import models.Conversation;
import models.Employee;
import models.EmployeeDTO;
import models.TypeApplication;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ChatSystemController", urlPatterns = {"/ChatSystem"})
public class ChatSystemController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        headerInfor.setSessionAttributes(request);
        ApplicationDAO a = new ApplicationDAO();
        AccountDTO account = (AccountDTO) request.getSession().getAttribute("account");
        if (account == null) {
            throw new ServletException("Account not found in session");
        }
        request.getRequestDispatcher("ChatSystem.jsp").forward(request, response);
    }

}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.ApplicationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.AccountDTO;
import models.ApplicationDTO;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;


@WebServlet(name = "EmployeeDetailApplicationController", urlPatterns = {"/employee-detailapplication"})
public class EmployeeDetailApplicationController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ApplicationDAO a = new ApplicationDAO();
        AccountDTO account = (AccountDTO) request.getSession().getAttribute("account");
        if (account == null) {
            throw new ServletException("Account not found in session");
        }

        String applicationId_raw = request.getParameter("applicationId");
        int applicationId = 0;
        try {
            applicationId = Integer.parseInt(applicationId_raw);
        } catch (NumberFormatException e) {
            // Handle parsing error
            e.printStackTrace(); // Log or handle the exception appropriately
            // Redirect user to an error page or display an error message
            return;
        }

        ApplicationDTO app = null;
        try {
            app = a.getApplicationById(applicationId);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EmployeeDetailApplicationController.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (app == null) {
            // Handle application not found
            // Redirect user to an error page or display an error message
            return;
        }

        request.setAttribute("app", app);
        request.getRequestDispatcher("EmployeeDetailApplication.jsp").forward(request, response);
    }




}

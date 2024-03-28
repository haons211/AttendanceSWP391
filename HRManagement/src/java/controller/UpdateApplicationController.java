/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ApplicationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.ApplicationDTO;

@WebServlet(name = "UpdateApplicationController", urlPatterns = {"/updateApplication"})
public class UpdateApplicationController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ApplicationDAO adao = new ApplicationDAO();
        if (request.getParameter("application_id") != null) {

            int application_id = 0;
            String application_idRaw = request.getParameter("application_id");
            String newTitle = request.getParameter("newTitle");
            String newContent = request.getParameter("newContent");
            if (isValidInput(newTitle) && isValidInput(newContent)) {
                newTitle = sanitizeInput(newTitle);
                newContent = sanitizeInput(newContent);
                try {
                    application_id = Integer.parseInt(application_idRaw);

                    adao.UpdateApplication(application_id, newTitle, newContent);
                    ApplicationDTO app = null;
                    app = adao.getApplicationById(application_id);
                    if (app == null) {
                        // Handle application not found
                        // Redirect user to an error page or display an error message
                        return;
                    }
                    request.setAttribute("app", app);
                    request.getRequestDispatcher("EmployeeDetailApplication.jsp").forward(request, response);
                } catch (NumberFormatException e) {
                    System.out.println(e.getMessage());
                }
            }

        }
    }

    private boolean isValidInput(String input) {
        return input != null && !input.isEmpty();
    }

// Sanitization method to replace '<' and '>'
    private String sanitizeInput(String input) {
        // Manually replace '<' and '>'
        return input.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
    }

}

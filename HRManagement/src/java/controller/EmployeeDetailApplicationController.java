/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configs.headerInfor;
import dal.ApplicationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.awt.HeadlessException;
import models.AccountDTO;
import models.ApplicationDTO;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "EmployeeDetailApplicationController", urlPatterns = {"/detailapplication"})
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
        app = a.getApplicationById(applicationId);
        if (app == null) {
            // Handle application not found
            // Redirect user to an error page or display an error message
            return;
        }
        headerInfor.setSessionAttributes(request);
        request.setAttribute("app", app);
        request.getRequestDispatcher("EmployeeDetailApplication.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("content") != null && request.getParameter("application_id") != null) {
            String replyContent = request.getParameter("content");
            int applicationId = 0;

            // Kiểm tra xem tham số application_id có giá trị không
            try {
                String applicationId_raw = request.getParameter("application_id");
                applicationId = Integer.parseInt(applicationId_raw);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                return;
            }

            // Gọi phương thức SetReplyContent từ ApplicationDAO
            ApplicationDAO ad = new ApplicationDAO();
            ad.SetReplyContent(replyContent, applicationId);

            // Lấy thông tin application sau khi đã thêm replyContent
            ApplicationDTO app = null;
            app = ad.getApplicationById(applicationId);

            // Đặt thuộc tính "app" và chuyển hướng tới trang EmployeeDetailApplication.jsp
            request.setAttribute("app", app);
            request.getRequestDispatcher("EmployeeDetailApplication.jsp").forward(request, response);
        }
    }

}

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

@WebServlet(name = "ReplyApplicationController", urlPatterns = {"/replyapplication"})
public class ReplyApplicationController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

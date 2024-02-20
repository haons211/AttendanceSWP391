package controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */


import dal.ApplicationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.AccountDTO;
import models.Application;
import models.ManagerDTO;
import models.TypeApplication;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

/**
 * @author Admin
 */
@WebServlet(urlPatterns = {"/deleteApplication"})
public class DeleteApplicationController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String delAppId_raw = request.getParameter("application_id");
        int delAppId = 0;
        String deleteMess = null;

        // Kiểm tra xem tham số delAppId_raw có khác null không
        if (delAppId_raw != null) {
            try {
                // Chuyển đổi delAppId_raw sang kiểu int
                delAppId = Integer.parseInt(delAppId_raw);

                // Thực hiện xóa ứng dụng với delAppId đã nhận được
                ApplicationDAO aD = new ApplicationDAO();
                aD.DeleteApplication(delAppId);

                // Gửi thông báo xóa thành công
                deleteMess = "Delete Successfully";
            } catch (NumberFormatException e) {
                // Xử lý nếu không thể chuyển đổi delAppId_raw sang kiểu int
                System.out.println(e.getMessage());
            }
        }

        // Chuyển hướng người dùng đến trang EmployeeDetailApplication.jsp
        // Sau khi xóa thành công hoặc không thành công
        request.setAttribute("thongbao", deleteMess);
        request.getRequestDispatcher("EmployeeDetailApplication.jsp").forward(request, response);
    }







}

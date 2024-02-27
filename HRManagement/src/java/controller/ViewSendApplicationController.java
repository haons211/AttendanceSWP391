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
import models.AccountDTO;
import models.ApplicationDTO;
import models.TypeApplication;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Admin
 */
@WebServlet(name = "ViewApplicationController", urlPatterns = {"/viewsendapplication"})
public class ViewSendApplicationController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        headerInfor.setSessionAttributes(request);
        ApplicationDAO a = new ApplicationDAO();
        AccountDTO account = (AccountDTO) request.getSession().getAttribute("account");
        if (account == null) {
            throw new ServletException("Account not found in session");
        }

        // Khai báo biến
        List<ApplicationDTO> list= new ArrayList<>();
        String searchParam = null;
        String msgError=null;
        String typeAppParam=null;

        if(account.getRole()==2) {
            // Xử lí type application
            List<TypeApplication> applicationTypes= a.GetAllTypeAllications();
            if(request.getParameter("type_id")!= null) {
                typeAppParam = request.getParameter("type_id");
            }
            // Kiểm tra giá trị trả về từ GetEmployeeIDbyUserID
            int employeeId = a.GetEmployeeIDbyUserID(account);
            if (employeeId == -1) {
                // Xử lý trường hợp không tìm thấy người dùng hoặc giá trị không hợp lệ
                throw new ServletException("Employee ID not found for the given user ID");
            }
            // Xử lí searchParam
            if(a.titlecontain(request.getParameter("searchTerm"))){
                searchParam= request.getParameter("searchTerm");
            }else{
                msgError="Can't not found";
                request.setAttribute("SearchError",msgError);
            }

            list=a.getAllApplicationbySenderId(employeeId,searchParam,typeAppParam);
            request.setAttribute("list_typeapplication",applicationTypes);
            request.setAttribute("list_application",list);
            request.getRequestDispatcher("ViewSendApplication.jsp").forward(request, response);
        } else if (account.getRole()==3) {
            // Xử lí type application//
            List<TypeApplication> applicationTypes= a.GetAllTypeAllications();
            if(request.getParameter("type_id")!= null) {
                typeAppParam = request.getParameter("type_id");
            }

            // lấy danh sách người gửi
            int employeeId=a.GetEmployeeIDbyUserID(account);
            if (employeeId == -1) {
                // Xử lý trường hợp không tìm thấy người dùng hoặc giá trị không hợp lệ
                throw new ServletException("Employee ID not found for the given user ID");
            }

            // Xử lí searchParam
            if(a.titlecontain(request.getParameter("searchTerm"))){
                searchParam= request.getParameter("searchTerm");
            }else{
                msgError="Can't not found";
                request.setAttribute("SearchError",msgError);
            }
            list=a.getAllApplicationbyReceiverId(employeeId,searchParam,typeAppParam);
            request.setAttribute("list_typeapplication",applicationTypes);
            request.setAttribute("list_application",list);
            request.getRequestDispatcher("ManagerViewApplication.jsp").forward(request, response);


        } else if (account.getRole() ==1) {
            // Xử lí type application//
            List<TypeApplication> applicationTypes= a.GetAllTypeAllications();
            if(request.getParameter("type_id")!= null) {
                typeAppParam = request.getParameter("type_id");
            }



            // Xử lí searchParam
            if(a.titlecontain(request.getParameter("searchTerm"))){
                searchParam= request.getParameter("searchTerm");
            }else{
                msgError="Can't not found";
                request.setAttribute("SearchError",msgError);
            }
            list=a.getAllApplications(searchParam,typeAppParam);
            request.setAttribute("list_typeapplication",applicationTypes);
            request.setAttribute("list_application",list);
            request.getRequestDispatcher("ManagerViewApplication.jsp").forward(request, response);

        }

    }


}

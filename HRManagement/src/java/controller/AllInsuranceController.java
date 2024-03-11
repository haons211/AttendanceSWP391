/*
* Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configs.headerInfor;
import dal.InsuranceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import models.InsuranceEmployeeDTO;

/**
 *
 * @author andep
 */
@WebServlet(name = "AllInsuranceController", urlPatterns = {"/insurance"})
public class AllInsuranceController extends HttpServlet {

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
            out.println("<title>Servlet AllInsuranceController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AllInsuranceController at " + request.getContextPath() + "</h1>");
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
        String search = request.getParameter("search");
        String amountString = request.getParameter("amount");
        double amount = 0; // Giá trị mặc định nếu không thể chuyển đổi
        try {
            if (amountString != null) {
                amount = Double.parseDouble(amountString);
            }
        } catch (NumberFormatException e) {
            // Xử lý ngoại lệ nếu chuỗi không thể chuyển đổi thành số
            e.printStackTrace();
        }
        InsuranceDAO insuranceDAO = new InsuranceDAO();
        ArrayList<InsuranceEmployeeDTO> typeList = insuranceDAO.getAllType();
        request.setAttribute("typeList", typeList);
        String typeName = request.getParameter("typeName");
        Date fromDate = null;
        Date toDate = null;
        // Xử lý fromDate và toDate
        String fromDateStr = request.getParameter("fromDate");
        String toDateStr = request.getParameter("toDate");
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            if (fromDateStr != null && !fromDateStr.isEmpty()) {
                fromDate = dateFormat.parse(fromDateStr);
            }
            if (toDateStr != null && !toDateStr.isEmpty()) {
                toDate = dateFormat.parse(toDateStr);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        // Gọi phương thức DAO để lấy danh sách AttendanceReport
        ArrayList<InsuranceEmployeeDTO> insuranceList = insuranceDAO.getAllInsurance(
                search == null ? "" : search, typeName,
                fromDate == null ? null : fromDate, toDate == null ? null : toDate, amount == 10000 ? 10000 : amount);
        // Lưu danh sách vào request attribute để truyền tới jsp
        request.setAttribute("list", insuranceList);
        // Chuyển hướng đến trang jsp để hiển thị danh sách
        request.getRequestDispatcher("Insurance.jsp").forward(request, response);
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
        processRequest(request, response);
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

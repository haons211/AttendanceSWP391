/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DepartmentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ThuyVy
 */
public class AddDepartmentController extends HttpServlet {

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
            out.println("<title>Servlet addDep</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet addDep at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("AddDepartment.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String name = request.getParameter("deparmentName");
//        String id_raw = request.getParameter("deparmentID");
//        int id = Integer.parseInt(id_raw);
//        DepartmentDAO dao = new DepartmentDAO();
//        dao.AddDeparment(id, name);
//        response.sendRedirect("addDep");
//    }
   @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    // Lấy thông tin từ form
    String name = request.getParameter("departmentName");
    String id_raw = request.getParameter("departmentID");

    // Kiểm tra và chuyển hướng
    if (isValidInput(id_raw, name)) {
        int id = Integer.parseInt(id_raw);

        // Thêm department vào database
        DepartmentDAO dao = new DepartmentDAO();

        // Check if the department ID already exists
        if (!dao.isDepartmentIdExists(id)) {
            dao.addDepartment(id, name);

            // Set thông báo thành công
            request.setAttribute("successMessage", "Add successful!");
        } else {
            // Set thông báo lỗi
            request.setAttribute("errorMessage", "Department with ID " + id + " already exists. Please enter a different ID.");
        }
    } else {
        // Set thông báo lỗi
        request.setAttribute("errorMessage", "Invalid department ID or name. Please try again.");
    }

    // Chuyển hướng đến trang addDepartment.jsp để hiển thị thông báo
    request.getRequestDispatcher("AddDepartment.jsp").forward(request, response);
}


    private boolean isValidInput(String id_raw, String name) {
        try {
            int id = Integer.parseInt(id_raw);
            return id > 0 && name != null && !name.trim().isEmpty();
        } catch (NumberFormatException e) {
            return false;
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

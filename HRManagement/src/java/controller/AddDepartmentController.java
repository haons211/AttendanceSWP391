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
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    // Lấy thông tin từ form
    String name = request.getParameter("departmentName");
    String code = request.getParameter("departmentCode");

    // Validate and sanitize inputs
    if (isValidInput(name) && isValidInput(code)) {
        DepartmentDAO dao = new DepartmentDAO();

        try {
            // Check if the department ID already exists
            if (!dao.isDepartmentCodeExists(code)) {
                // Sanitize and manually replace '<' and '>'
                name = sanitizeInput(name);
                code = sanitizeInput(code);

                dao.addDepartment(code, name);

                // Set thông báo thành công
                request.setAttribute("successMessage", "Department add successful!");

                // Xóa thông báo lỗi nếu có
                request.getSession().removeAttribute("errorMessage");
            } else {
                // Set thông báo lỗi
                request.setAttribute("errorMessage", "Department with Code " + code + " already exists. Please enter a different ID.");
            }
        } catch (Exception e) {
            e.printStackTrace();

            // Set thông báo lỗi chung nếu có lỗi xảy ra
            request.setAttribute("errorMessage", "Error adding department.");
        }
    } else {
        // Invalid input, set an error message
        request.setAttribute("errorMessage", "Invalid input. Please enter valid data.");
    }

    // Chuyển hướng đến trang addDepartment.jsp để hiển thị thông báo
    request.getRequestDispatcher("AddDepartment.jsp").forward(request, response);
}

// Validation method to check if the input is not empty
private boolean isValidInput(String input) {
    return input != null && !input.isEmpty();
}

// Sanitization method to replace '<' and '>'
private String sanitizeInput(String input) {
    // Manually replace '<' and '>'
    return input.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
}

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

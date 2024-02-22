/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configs.Validate;
import dal.DepartmentDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import models.Department;

/**
 *
 * @author andep
 */
public class UpdateDepartmentController extends HttpServlet {

    private Validate validate = new Validate();

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
            out.println("<title>Servlet updateDep</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet updateDep at " + request.getContextPath() + "</h1>");
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
        DepartmentDAO d = new DepartmentDAO();
        int id = Integer.parseInt(request.getParameter("pid"));
        Department p = d.getDepartmentById(id);
        request.setAttribute("p", p);
        // Trong phương thức doGet hoặc doGet
        String successMessage = (String) request.getSession().getAttribute("successMessage");
        if (successMessage != null) {
            request.getSession().removeAttribute("successMessage"); // Xóa thông điệp sau khi sử dụng
            request.setAttribute("successMessage", successMessage);
        }
        request.getRequestDispatcher("UpdateDepartment.jsp").forward(request, response);
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
        String departmentIDString = request.getParameter("departmentID");
        String departmentCode = request.getParameter("departmentCode").toLowerCase();
        String departmentName = request.getParameter("departmentName");
        departmentName = validate.normalizeName(departmentName);
        
        DepartmentDAO dao = new DepartmentDAO();
        String messageError = "Please input valid ";
        try {
            int count = 0;
            int departmentID = Integer.parseInt(departmentIDString);
            if (!dao.isDepartmentCodeExists(departmentCode, departmentID)) {
                if (!validate.checkWords(departmentName)) {
                    request.setAttribute("messageErrorName", messageError + "name");
                    count++;
                }
                if (!validate.checkWords(departmentCode)) {
                    request.setAttribute("messageErrorCode", messageError + "code");
                    count++;
                }
                if (count > 0) {

                    DepartmentDAO d = new DepartmentDAO();
                    Department p = d.getDepartmentById(departmentID);
                    request.setAttribute("p", p);
                    request.getRequestDispatcher("UpdateDepartment.jsp").forward(request, response);
                } else {
                    dao.updateDepartment(departmentID, departmentName, departmentCode);
                    request.getSession().setAttribute("successMessage", "Department updated successfully");
                    request.getSession().setAttribute("departmentID", departmentID);
                    request.getSession().setAttribute("departmentCode", departmentCode);
                    request.getSession().setAttribute("departmentName", departmentName);
                }

                // Check and remove errorMessage from session
                Object errorMessage = request.getSession().getAttribute("errorMessage");
                if (errorMessage != null) {
                    request.getSession().removeAttribute("errorMessage");
                }
            } else {
                // Set the error message attribute
                request.getSession().setAttribute("errorMessage", "Department with Code " + departmentCode + " already exists. Please enter a different Code.");
            }

            // Redirect to the update page with the departmentID parameter
            response.sendRedirect("UpdateDepartment?pid=" + departmentID);
        } catch (NumberFormatException | IOException e) {
            request.getSession().setAttribute("errorMessage", "Error updating department");

            // Redirect to the update page with the departmentID parameter
            response.sendRedirect("UpdateDepartment?pid=" + departmentIDString);
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

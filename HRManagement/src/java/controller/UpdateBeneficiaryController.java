/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configs.Validate;
import dal.BeneficiaryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.System.Logger;
import java.lang.System.Logger.Level;
import java.util.ArrayList;
import models.Dependents;

/**
 *
 * @author andep
 */
@WebServlet(name = "UpdateBeneficiaryController", urlPatterns = {"/updateBeneficiary"})
public class UpdateBeneficiaryController extends HttpServlet {

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
            out.println("<title>Servlet UpdateBeneficiaryController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateBeneficiaryController at " + request.getContextPath() + "</h1>");
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
        BeneficiaryDAO d = new BeneficiaryDAO();
        ArrayList<Dependents> relationshipType = d.getAllRelationshipType();
        request.setAttribute("relationshipType", relationshipType);
        int id = Integer.parseInt(request.getParameter("bid"));
        Dependents beneficiary = d.getBeneficiaryByID(id);
        request.setAttribute("beneficiary", beneficiary);
        // Trong phương thức doGet hoặc doGet
        String successMessage = (String) request.getSession().getAttribute("successMessage");
        if (successMessage != null) {
            request.getSession().removeAttribute("successMessage"); // Xóa thông điệp sau khi sử dụng
            request.setAttribute("successMessage", successMessage);
        }

        request.getRequestDispatcher("UpdateBeneficiary.jsp").forward(request, response);
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
        int employeeId = 0;
        HttpSession session = request.getSession();
        if (session != null) {
            employeeId = (int) session.getAttribute("Iid");
        }
        int dependentId = Integer.parseInt(request.getParameter("beneficiary_id"));
        String name = request.getParameter("name");
        String gender = request.getParameter("gender");
        boolean isMale = gender.equalsIgnoreCase("Male") ? true : false;
        String dateOfBirth = request.getParameter("dob");
        String relationship = request.getParameter("relationship");

        BeneficiaryDAO dao = new BeneficiaryDAO();
        String messageError = "Please input valid ";
        try {

            int count = 0;

            if (!validate.checkWords(name)) {
                request.setAttribute("messageErrorName", messageError + "name");
                count++;
            }
            if (!validate.checkDate(dateOfBirth)) {
                request.setAttribute("messageErrorDate", messageError + "date");
                count++;
            }
            if (!validate.validateDateBeforeToday(dateOfBirth)) {
                request.setAttribute("messageErrorDate", messageError + "date");
                count++;
            }
            if (gender.isEmpty() || gender == "") {
                request.setAttribute("messageErrorGender", "Please choose Gender");
                count++;
            }
            if (relationship.isEmpty() || relationship == "") {
                request.setAttribute("messageErrorRelationship", "Please choose Relationship");
                count++;
            }
            if (count > 0) {
                BeneficiaryDAO d = new BeneficiaryDAO();
                ArrayList<Dependents> relationshipType = d.getAllRelationshipType();
                request.setAttribute("relationshipType", relationshipType);
                request.setAttribute("beneficiary", dao.getBeneficiaryByEmployeeID(employeeId, "", "", null, null));
                request.getRequestDispatcher("UpdateBeneficiary.jsp").forward(request, response);

            } else {
                // Create Employee object with updated information

                // Update the employee in the database
                dao.updateBeneficiary(dependentId, employeeId, name, isMale,
                        dateOfBirth, relationship);
                // Redirect to the list-employee servlet or page
                response.sendRedirect("beneficiary");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Override
    public String getServletInfo() {
        return "Update Beneficiary Servlet";
    }
}

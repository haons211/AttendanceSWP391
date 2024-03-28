/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configs.Validate;
import configs.headerInfor;
import dal.BeneficiaryDAO;
import dal.EmployeeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Dependents;
import models.Employee;

/**
 *
 * @author andep
 */
@WebServlet(name = "AddBeneficiaryController", urlPatterns = {"/addBeneficiary"})
public class AddBeneficiaryController extends HttpServlet {

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
            out.println("<title>Servlet AddBeneficiaryController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddBeneficiaryController at " + request.getContextPath() + "</h1>");
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
        BeneficiaryDAO d = new BeneficiaryDAO();
        ArrayList<Dependents> relationshipType = d.getAllRelationshipType();
        request.setAttribute("relationshipType", relationshipType);

        int id_employee = 0;
        HttpSession session = request.getSession();
        if (session != null) {
            id_employee = (int) session.getAttribute("Iid");
        }
        EmployeeDAO dao = new EmployeeDAO();
        Employee employee;
        try {
            employee = dao.getEmployeeById(id_employee);
            request.setAttribute("employee", employee);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AddBeneficiaryController.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.getRequestDispatcher("AddBeneficiary.jsp").forward(request, response);
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
        headerInfor.setSessionAttributes(request);
        int id_employee = 0;
        HttpSession session = request.getSession();
        if (session != null) {
            id_employee = (int) session.getAttribute("Iid");
        }
        String name = request.getParameter("name");
        String gender = request.getParameter("gender");
        boolean isMale = gender.equalsIgnoreCase("Male") ? true : false;
        String dob = request.getParameter("dob");
        String relationship = request.getParameter("relationship");

        BeneficiaryDAO dao = new BeneficiaryDAO();

        String messageError = "Please input valid ";
        try {

            int count = 0;

            if (!validate.checkWords(name)) {
                request.setAttribute("messageErrorName", messageError + "name");
                count++;
            }
            if (!validate.checkDate(dob)) {
                request.setAttribute("messageErrorDate", messageError + "date");
                count++;
            }
            if (!validate.validateDateBeforeToday(dob)) {
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
                request.setAttribute("employee_id", id_employee);
                request.setAttribute("name", name);
                request.setAttribute("gender", isMale);
                request.setAttribute("dob", dob);
                request.setAttribute("relationship", relationship);
                BeneficiaryDAO d = new BeneficiaryDAO();
                ArrayList<Dependents> relationshipType = d.getAllRelationshipType();
                request.setAttribute("relationshipType", relationshipType);
                request.getRequestDispatcher("AddBeneficiary.jsp").forward(request, response);
            } else {

                dao.addBeneficiary(id_employee, name, isMale, dob, relationship);
                response.sendRedirect("beneficiary");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

    }

    @Override
    public String getServletInfo() {
        return "Add Insurance Servlet";
    }
}

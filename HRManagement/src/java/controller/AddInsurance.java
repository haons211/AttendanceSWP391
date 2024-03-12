/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configs.Validate;
import dal.EmployeeDAO;
import dal.InsuranceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Employee;
import models.InsuranceEmployeeDTO;

/**
 *
 * @author andep
 */
@WebServlet(name = "AddInsurance", urlPatterns = {"/addInsurance"})
public class AddInsurance extends HttpServlet {

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
            out.println("<title>Servlet AddInsurance</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddInsurance at " + request.getContextPath() + "</h1>");
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
        int id = Integer.parseInt(request.getParameter("id"));
        EmployeeDAO dao = new EmployeeDAO();
        Employee employee = new Employee();
        try {
            employee = dao.getEmployeeById(id);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AddInsurance.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.setAttribute("employee", employee);
        request.getRequestDispatcher("AddInsurance.jsp").forward(request, response);
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
        int employee_id = Integer.parseInt(request.getParameter("employee_id"));
        String insurance_company = request.getParameter("insurance_company");
        String policy_number = request.getParameter("policy_number");
        String coverage_type = request.getParameter("coverage_type");
        String policy_type = request.getParameter("policy_type");
        String end_date = request.getParameter("end_date");
        String start_date = request.getParameter("start_date");
        String deductible = request.getParameter("deductible");
        String co_pay = request.getParameter("co_pay");
        String coverage_limit = request.getParameter("coverage_limit");
        String premium_amount = request.getParameter("premium_amount");
        String renewal_date = request.getParameter("renewal_date");
        String coverage_details = request.getParameter("coverage_details");
        String beneficiary = request.getParameter("beneficiary");

        InsuranceDAO dao = new InsuranceDAO();
        String messageError = "Please input valid ";
        try {

            int count = 0;

            if (!validate.checkWords(insurance_company)) {
                request.setAttribute("messageErrorInsuranceCompanyWord", messageError + "insurance company");
                count++;
            }
            if (!validate.checkDate(start_date)) {
                request.setAttribute("messageErrorStartDate", messageError + "start date");
                count++;
            }
            if (!validate.checkDate(end_date)) {
                request.setAttribute("messageErrorEndDate", messageError + "end date");
                count++;
            }
            if (!validate.validateDouble(deductible)) {
                request.setAttribute("messageErrorDeductibleDouble", messageError + "deductible");
                count++;
            }
            if (!validate.validateDouble(co_pay)) {
                request.setAttribute("messageErrorCopayDouble", messageError + "copay");
                count++;
            }
            if (!validate.validateDouble(coverage_limit)) {
                request.setAttribute("messageErrorLimitDouble", messageError + "coverage limit");
                count++;
            }
            if (!validate.validateDouble(premium_amount)) {
                request.setAttribute("messageErrorAmountDouble", messageError + "premium amount");
                count++;
            }
            if (!validate.checkDate(renewal_date)) {
                request.setAttribute("messageErrorRenewalDate", messageError + "renewal date");
                count++;
            }
            if (validate.checkDate(renewal_date) && validate.checkDate(end_date)) {
                if (!validate.compareDate(end_date, renewal_date)) {
                    request.setAttribute("messageErrorRenewalDate", messageError + "The end date must be before the renewal date");
                    count++;
                }
            }
            if (validate.checkDate(start_date) && validate.checkDate(end_date)) {
                if (!validate.compareDate(start_date, end_date)) {
                    request.setAttribute("messageErrorStartDate", messageError + "The start date must be before the end date");
                    count++;
                }
            }

            if (count > 0) {
                request.setAttribute("employee_id", employee_id);
                request.setAttribute("insurance_company", insurance_company);
                request.setAttribute("policy_number", policy_number);
                request.setAttribute("coverage_type", coverage_type);
                request.setAttribute("start_date", start_date);
                request.setAttribute("end_date", end_date);
                request.setAttribute("policy_type", policy_type);
                request.setAttribute("deductible", deductible);
                request.setAttribute("co_pay", co_pay);
                request.setAttribute("coverage_limit", coverage_limit);
                request.setAttribute("premium_amount", premium_amount);
                request.setAttribute("renewal_date", renewal_date);
                request.setAttribute("coverage_details", coverage_details);
                request.setAttribute("beneficiary", beneficiary);
                request.getRequestDispatcher("AddInsurance.jsp").forward(request, response);
            } else {

                dao.addInsurance(employee_id, insurance_company, policy_number,
                        coverage_type, start_date, end_date, policy_type, deductible,
                        co_pay, coverage_limit, premium_amount, renewal_date,
                        coverage_details, beneficiary);
                response.sendRedirect("insurance");
            }
        } catch (Exception ex) {
            Logger.getLogger(AddEmployeeController.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    @Override
    public String getServletInfo() {
        return "Add Insurance Servlet";
    }
}

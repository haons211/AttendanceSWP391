/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configs.Validate;
import dal.InsuranceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.InsuranceEmployeeDTO;

/**
 *
 * @author andep
 */
@WebServlet(name = "UpdateInsuranceController", urlPatterns = {"/updateInsurance"})
public class UpdateInsuranceController extends HttpServlet {

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
            out.println("<title>Servlet UpdateInsuranceController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateInsuranceController at " + request.getContextPath() + "</h1>");
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
        InsuranceDAO d = new InsuranceDAO();
        int id = Integer.parseInt(request.getParameter("Iid"));
        InsuranceEmployeeDTO insurance = d.getInsuranceById(id);
        request.setAttribute("insurance", insurance);
        // Trong phương thức doGet hoặc doGet
        String successMessage = (String) request.getSession().getAttribute("successMessage");
        if (successMessage != null) {
            request.getSession().removeAttribute("successMessage"); // Xóa thông điệp sau khi sử dụng
            request.setAttribute("successMessage", successMessage);
        }

        request.getRequestDispatcher("UpdateInsurance.jsp").forward(request, response);
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
        int insurance_id = Integer.parseInt(request.getParameter("insurance_id"));
        request.setAttribute("id", insurance_id);
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
                request.setAttribute("insurance", dao.getInsuranceById(insurance_id));
                request.getRequestDispatcher("UpdateInsurance.jsp").forward(request, response);

            } else {
                // Create Employee object with updated information

                // Update the employee in the database
                dao.updateInsurance(insurance_id, employee_id, insurance_company, policy_number,
                        coverage_type, start_date, end_date, policy_type, deductible,
                        co_pay, coverage_limit, premium_amount, renewal_date,
                        coverage_details, beneficiary);
                // Redirect to the list-employee servlet or page
                response.sendRedirect("insurance");
            }
        } catch (Exception ex) {
            Logger.getLogger(AddEmployeeController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Update Insurance Servlet";
    }
}

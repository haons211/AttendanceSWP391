/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configs.Validate;
import configs.headerInfor;
import dal.CompanyDAO;
import dal.DepartmentDAO;
import dal.EmployeeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.AccountDTO;
import models.Company;
import models.Department;
import models.Employee;

/**
 *
 * @author Dan
 */
@WebServlet(name = "UpdateCompanyController", urlPatterns = {"/UpdateCompany"})
public class UpdateCompanyController extends HttpServlet {

    private final Validate validate = new Validate();

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
            out.println("<title>Servlet UpdateCompanyController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateCompanyController at " + request.getContextPath() + "</h1>");
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

        request.setAttribute("id", 1);
        // set attribute employeeList
        CompanyDAO dao = new CompanyDAO();
        EmployeeDAO employeeDAO = new EmployeeDAO();
        DepartmentDAO departmentDAO = new DepartmentDAO();

      

        try {
           
            Employee employee = employeeDAO.getEmployeeById(dao.getCompanyByID(1).getContactPerson());
            request.setAttribute("company", dao.getCompanyByID(1));
            request.setAttribute("employee1", employee);
            request.setAttribute("department", departmentDAO.getAllDepartments(""));
            
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SettingController.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.getRequestDispatcher("CompanySetting.jsp").forward(request, response);

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
        String companyName = request.getParameter("companyName");
        companyName = validate.normalizeName(companyName);
        String employeeName = request.getParameter("employeeName");
        employeeName = validate.normalizeName(employeeName);

        String address = request.getParameter("address");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String departmentName = request.getParameter("departmentName");
        String fax = request.getParameter("fax");
        String website = request.getParameter("website");
        String messageError = "Please input valid ";
        CompanyDAO dao = new CompanyDAO();
        EmployeeDAO employeeDAO = new EmployeeDAO();
        DepartmentDAO departmentDAO = new DepartmentDAO();
        int count = 0;
        try {
            int companyID = 1;
            request.setAttribute("id", companyID);
            if (!validate.checkWords(companyName)) {
                request.setAttribute("messageErrorCname", messageError + "company name");
                count++;
            }
            if (!validate.checkWords(employeeName)) {
                request.setAttribute("messageErrorEname", messageError + "contact person");
                count++;
            }
            if (!validate.checkEmail(email)) {
                request.setAttribute("messageErrorEmail", messageError + "email");
                count++;
            }

            if (!validate.checkAddress(address)) {
                request.setAttribute("messageErrorAddress", messageError + "address");
                count++;
            }
            if (!validate.checkPhone(fax)) {
                request.setAttribute("messageErrorfax", messageError + "fax");
                count++;
            }
            if (!validate.checkPhone(phoneNumber)) {
                request.setAttribute("messageErrorPhoneNumber", messageError + "phone number");
                count++;
            }
            if (!validate.checkWords(departmentName)) {
                request.setAttribute("messageErrorDname", messageError + "department name");
                count++;
            }

            if (count > 0) {

                Department department = departmentDAO.getDepartmentById(dao.getCompanyByID(1).getDepartment());
                Employee employee = employeeDAO.getEmployeeById(dao.getCompanyByID(1).getContactPerson());
                request.setAttribute("company", dao.getCompanyByID(1));
                request.setAttribute("employee1", employee);
                request.setAttribute("department", department);
                request.getRequestDispatcher("CompanySetting.jsp").forward(request, response);

            } else {
                Employee employee = dao.getEmployeeByName(employeeName);
                Department department = dao.getDepartmentByName(departmentName);

                Company company = new Company(companyID, companyName, address, email, phoneNumber, fax, website, employee.getEmployeeId(), department.getDepartment_id());

                dao.updateCompany(company, companyID);

                response.sendRedirect("Setting");

            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UpdateCompanyController.class.getName()).log(Level.SEVERE, null, ex);
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

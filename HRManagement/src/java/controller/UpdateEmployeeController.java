package controller;

import configs.Validate;
import dal.EmployeeDAO;
import java.io.IOException;
import java.sql.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.ParseException;
import models.Employee;

@WebServlet(name = "UpdateEmployee", urlPatterns = {"/update-employee"})
public class UpdateEmployeeController extends HttpServlet {

    private Validate validate = new Validate();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to the update-employee.jsp page for displaying the form
        if (request.getParameter("id") != null) {
            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("id", id);
            // set attribute employeeList
            EmployeeDAO employeeDAO = new EmployeeDAO();
            try {
                request.setAttribute("employee", employeeDAO.getEmployeeById(id));
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(UpdateEmployeeController.class.getName()).log(Level.SEVERE, null, ex);
            }
            request.getRequestDispatcher("update-employee.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("update-employee.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve parameters from the request
        String name = request.getParameter("name");
        name = validate.normalizeName(name);
        String image = request.getParameter("image");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        // Retrieve gender parameter and handle null case

        // Default to male if parameter is null
        String messageError = "Please input valid ";

        // Parse date parameters
        EmployeeDAO dao = new EmployeeDAO();
        String birthDate = request.getParameter("birthDate");
        String hireDate = request.getParameter("hireDate");
        EmployeeDAO employeeDAO = new EmployeeDAO();
      
        
        try {

            int employeeId = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("id", employeeId);

            boolean genderReturn = true;
            if (gender.equals("male")) {
                genderReturn = false;

            }
            int count = 0;
            if (!validate.checkPhone(phoneNumber)) {
                request.setAttribute("messageErrorPhoneNumber", messageError + "phone number");
                count++;
            }
            if (!validate.checkWords(name)) {
                request.setAttribute("messageErrorName", messageError + "name");
                count++;
            }
            if (!validate.checkAddress(address)) {
                request.setAttribute("messageErrorAddress", messageError + "address");
                count++;
            }
            if (!validate.checkDate(birthDate)) {
                request.setAttribute("messageErrorBirthDate", messageError + "birth date");
                count++;
            }
            if (!validate.checkDate(hireDate)) {
                request.setAttribute("messageErrorHireDate", messageError + "hire date");
                count++;
            }  
            
            if(!validate.compareDate(birthDate, hireDate)){
                request.setAttribute("messageErrorDate", messageError + ". The hire date is after the birth date");
                count++;
            }
            if(!validate.isAdult(birthDate)){
                request.setAttribute("messageErrorBirthday", messageError + ". The age of employee must be greater than 18");
                count++;
            }

            if (count > 0) {
                request.setAttribute("employee", employeeDAO.getEmployeeById(employeeId));
                request.getRequestDispatcher("update-employee.jsp").forward(request, response);
            } else {
                // Create Employee object with updated information
                Employee employee = new Employee(name, phoneNumber, address, email, genderReturn, image, birthDate, hireDate);
                // Update the employee in the database
                dao.updateEmployee(employee, employeeId);
                // Redirect to the list-employee servlet or page
                response.sendRedirect("employee");
            }

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UpdateEmployeeController.class.getName()).log(Level.SEVERE, null, ex);
        }
        catch (ParseException ex) {
            Logger.getLogger(UpdateEmployeeController.class.getName()).log(Level.SEVERE, null, ex);
        } 

    }

    @Override
    public String getServletInfo() {
        return "Update Employee Servlet";
    }
}

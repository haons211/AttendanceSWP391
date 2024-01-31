package controller;

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
import models.Employee;

@WebServlet(name = "UpdateEmployee", urlPatterns = {"/update-employee"})
public class UpdateEmployeeController extends HttpServlet {

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
        String image = request.getParameter("image");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String email = request.getParameter("email");

        // Retrieve gender parameter and handle null case
        String genderParam = request.getParameter("gender");
        boolean gender = "male".equals(genderParam); // Default to male if parameter is null

        Date birthDate = null;
        Date hireDate = null;

        // Parse date parameters
        try {
            birthDate = Date.valueOf(request.getParameter("birthDate"));
            hireDate = Date.valueOf(request.getParameter("hireDate"));
        } catch (IllegalArgumentException ex) {
            Logger.getLogger(UpdateEmployeeController.class.getName()).log(Level.SEVERE, null, ex);
            // Handle exception, possibly inform the user
        }

        // Parse employee ID parameter
        try {
            int employeeId = Integer.parseInt(request.getParameter("id"));
            // Create Employee object with updated information
            Employee employee = new Employee(name, phoneNumber, address, email, gender, image, birthDate, hireDate);
            // Update the employee in the database
            EmployeeDAO eDAO = new EmployeeDAO();
            eDAO.updateEmployee(employee, employeeId);
        } catch (NumberFormatException | ClassNotFoundException ex) {
            Logger.getLogger(UpdateEmployeeController.class.getName()).log(Level.SEVERE, null, ex);
            
        }

        // Redirect to the list-employee servlet or page
        response.sendRedirect("employee");
    }

    @Override
    public String getServletInfo() {
        return "Update Employee Servlet";
    }
}

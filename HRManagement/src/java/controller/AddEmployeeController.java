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
import java.sql.SQLException;

@WebServlet(name = "AddEmployeeServlet", urlPatterns = {"/add-employee"})
public class AddEmployeeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("add-employee.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String image = request.getParameter("image");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
      
        boolean gender = request.getParameter("gender").equals("male");
        
        Date birthDate = null;
        Date hireDate = null;

        try {
            birthDate = Date.valueOf(request.getParameter("birthDate"));
            hireDate = Date.valueOf(request.getParameter("hireDate"));
        } catch (IllegalArgumentException ex) {
            Logger.getLogger(AddEmployeeController.class.getName()).log(Level.SEVERE, null, ex);
        }

        EmployeeDAO dao = new EmployeeDAO();
        try {
            dao.addEmployee(name, phoneNumber, address, email, gender, image, birthDate, hireDate);
        } catch (SQLException ex) {
            Logger.getLogger(AddEmployeeController.class.getName()).log(Level.SEVERE, null, ex);
        }
        response.sendRedirect("employee");
    }

    @Override
    public String getServletInfo() {
        return "Add Employee Servlet";
    }
}

package controller;

import configs.Validate;
import dal.AccountDAO;
import dal.DepartmentDAO;
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
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import models.Employee;

@WebServlet(name = "AddEmployeeServlet", urlPatterns = {"/add-employee"})
public class AddEmployeeController extends HttpServlet {

    private Validate validate = new Validate();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DepartmentDAO dao =  new DepartmentDAO();
        request.setAttribute("department", dao.getAllDepartments(""));
        String username = request.getParameter("username");

        request.setAttribute("username", username);
        request.getRequestDispatcher("add-employee.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 String username = request.getParameter("username");
        String name = request.getParameter("name");
        name = validate.normalizeName(name);
        String image = request.getParameter("image");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        String birthDate = request.getParameter("birthDate");
        String hireDate = request.getParameter("hireDate");
        Double salary = Double.parseDouble(request.getParameter("salary"));
        System.out.println(birthDate);
        System.out.println(hireDate);
       String department = request.getParameter("department");
        System.out.println(department);
        EmployeeDAO dao = new EmployeeDAO();
        String messageError = "Please input valid ";
        boolean genderReturn = true;
        try {

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
            if (gender == null) {
                request.setAttribute("messageErrorGender", messageError + "gender");
                count++;
            }
            if (validate.checkDate(birthDate) && validate.checkDate(hireDate) ) {
                if (!validate.compareDate(birthDate, hireDate)) {
                    request.setAttribute("messageErrorDate", messageError + ". The hire date is after the birth date");
                    count++;
                }
                
            }
            if(validate.checkDate(birthDate)){
                if (!validate.isAdult(birthDate)) {
                    request.setAttribute("messageErrorBirthday", messageError + ". The age of employee must be greater than 18");
                    count++;
                }
            }
            
DepartmentDAO ddao =new DepartmentDAO();
            AccountDAO adao = new AccountDAO();
            int userId = adao.getIdByUsername(username).getUserID();
            if (count > 0) {
                request.setAttribute("name", name);
                request.setAttribute("image", image);
                request.setAttribute("phoneNumber", phoneNumber);
                request.setAttribute("address", address);
                request.setAttribute("email", email);
                request.setAttribute("gender", gender);
                request.setAttribute("birthDate", birthDate);
                request.setAttribute("hireDate", hireDate);
                 request.setAttribute("salary", hireDate);
                request.getRequestDispatcher("add-employee.jsp").forward(request, response);
            } else {
              
                dao.addEmployee(name, phoneNumber, address, email, genderReturn, image, birthDate, hireDate,userId,  salary);
                System.out.println(dao.getEmployeeID());
                 System.out.println(ddao.getDepartmentByName(department).getDepartment_id());
                if(dao.getEmployeeID() == 0){
                    request.getRequestDispatcher("add-employee").forward(request, response);
                }
             
//                dao.addEmployeeDepartment(new Employee(dao.getEmployeeID(), ddao.getDepartmentByName(department).getDepartment_id()));
                response.sendRedirect("employee");
            }

        } catch (SQLException ex) {
            Logger.getLogger(AddEmployeeController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(AddEmployeeController.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    @Override
    public String getServletInfo() {
        return "Add Employee Servlet";
    }
}

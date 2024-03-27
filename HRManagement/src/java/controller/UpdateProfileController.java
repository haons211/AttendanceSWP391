/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configs.Validate;
import configs.headerInfor;
import dal.EmployeeDAO;
import models.AccountDTO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Employee;
import org.apache.poi.poifs.crypt.ChainingMode;

/**
 *
 * @author NCM
 */
public class UpdateProfileController extends HttpServlet {

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
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");

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
        try {
            headerInfor.setSessionAttributes(request);
            int empID=Integer.parseInt(request.getParameter("empID"));
            EmployeeDAO edao=new EmployeeDAO();
            Employee e= edao.getin4(empID);
            request.setAttribute("emp1", e);
            request.getRequestDispatcher("UpdateProfile.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(UpdateProfileController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UpdateProfileController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
         
            Validate v = new Validate();
            String url = null;
            String button = request.getParameter("btAction");
            
            
            int accid = Integer.parseInt(request.getParameter("empId"));
            String name = request.getParameter("empName");
            
            String Phone = request.getParameter("empNumber");
            String email = request.getParameter("empEmail");
            String address = request.getParameter("empAddress");
            int gender = Integer.parseInt(request.getParameter("empGender"));
            boolean genderCheck = false;
            if (gender == 1) {
                genderCheck = false;
            } else {
                genderCheck = true;
            }
            String birthdateString = request.getParameter("empBirthdate");
            
            EmployeeDAO dao = new EmployeeDAO();
            
            boolean checkUpdate = false;
            checkUpdate = dao.updateInformation(accid, name, Phone, email, address, genderCheck, birthdateString);
       
           request.getRequestDispatcher("profile").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(UpdateProfileController.class.getName()).log(Level.SEVERE, null, ex);
        }
}
               
            } // sang tab thay doi thong tin nhan vien
         
       
    

/**
 * Returns a short description of the servlet.
 *
 * @return a String containing servlet description
 */

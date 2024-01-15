package controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */



import dal.ApplicationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;
import models.AccountDTO;
import models.Application;
import models.ManagerDTO;
import models.TypeApplication;

/**
 *
 * @author Admin
 */
@WebServlet(urlPatterns={"/sendapplication"})
public class SendApplicationController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet SendApplicationController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SendApplicationController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        ApplicationDAO  a= new ApplicationDAO();
        List<TypeApplication> list= a.GetAllTypeAllications();      
        request.setAttribute("types_list", list);
        List<ManagerDTO> listmana=a.GetAllManagers();
        request.setAttribute("managers_list", listmana);
        request.getRequestDispatcher("SendApplication.jsp").forward(request, response);
        
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    ApplicationDAO a = new ApplicationDAO();
    AccountDTO account = (AccountDTO) request.getSession().getAttribute("account");
    
    if (account == null) {
        throw new ServletException("Account not found in session");
    }
    
    int sender_id = a.GetEmployeeIDbyUserID(account);
    
    if (sender_id == -1) {
        throw new ServletException("Sender ID not found");
    }

    int type_id = parseIntegerParameter(request, "applicationType");
    int receiver_id = parseIntegerParameter(request, "receiver_id");

    String file = request.getParameter("fileAttach");
    if (file == null) {
        throw new ServletException("File not provided");
    }

    String reason = request.getParameter("reason");
    if (reason == null) {
        throw new ServletException("Reason not provided");
    }

    String status = "Pending"; // Assuming the status is "Pending" when a new application is created

    Date create_date = new Date(); // The create_date is set to the current time
    Date complete_date = null; // The complete_date is null when a new application is created

    Application application = new Application();
    application.setSender_id(sender_id);
    application.setType_id(type_id);
    application.setReceiver_id(receiver_id);
    application.setFile(file);
    application.setReason(reason);
    application.setStatus(status);
    application.setCreate_date(create_date);
    application.setComplete_date(complete_date);

    try {
        a.insertApplication(application);

        // Chuyển hướng sau khi gửi thành công
        response.sendRedirect("HomeEmployees.jsp");
    } catch (Exception e) {
        throw new ServletException("Error inserting application", e);
    }
}


private int parseIntegerParameter(HttpServletRequest request, String parameterName) throws ServletException {
    String rawValue = request.getParameter(parameterName);
    if (rawValue == null) {
        throw new ServletException(parameterName + " not provided");
    }
    try {
        return Integer.parseInt(rawValue);
    } catch (NumberFormatException e) {
        throw new ServletException(parameterName + " is not a valid integer", e);
    }
}


    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
}

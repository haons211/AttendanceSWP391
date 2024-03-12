/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletResponse;

import configs.headerInfor;
import dal.EmployeeDAO;
import dal.ProjectDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.AccountDTO;
import models.Employee;
import models.Task;

/**
 *
 * @author NCM
 */
@WebServlet(name = "createTasktoemployee", urlPatterns = {"/createTask"})
public class createTasktoemployee extends HttpServlet {

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
            out.println("<title>Servlet createTasktoemployee</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet createTasktoemployee at " + request.getContextPath() + "</h1>");
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
        try {
            int ProjectID = Integer.parseInt(request.getParameter("ProjectID"));
            headerInfor.setSessionAttributes(request);
            HttpSession session = request.getSession();
            AccountDTO acc = (AccountDTO) session.getAttribute("account");
            ProjectDao pd = new ProjectDao();
            List<Task> detailsTask = new ArrayList<>();
            
            EmployeeDAO dao = new EmployeeDAO();
            Employee em = dao.getin4(acc.getUserID());
            int MaId = pd.getMaid(ProjectID);
            Boolean mess = (Boolean) request.getSession().getAttribute("mess");
            request.getSession().removeAttribute("mess");
             Boolean mess2 = (Boolean) request.getSession().getAttribute("mess2");
            request.getSession().removeAttribute("mess2");
            if(acc.getRole()==3){
                detailsTask=pd.getAllTask(ProjectID);
            } else{
                detailsTask=pd.getAllTaskforem(ProjectID, em.getEmployeeId());
            }
            if(mess!=null){
            request.setAttribute("mess", mess);}
             if(mess!=null){
            request.setAttribute("mess2", mess2);}
            List<Employee> ltE = dao.getAllEmployeesforProject(em.getEmployeeId());
            request.setAttribute("MaId", MaId);
            request.setAttribute("listEm", ltE);
            request.setAttribute("listTask", detailsTask);
            request.getRequestDispatcher("CreateTaskforE.jsp").forward(request, response);
        } catch (Exception e) {

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
        PrintWriter out = response.getWriter();
        try {
            response.setContentType("text/html;charset=UTF-8");
            ProjectDao pd = new ProjectDao();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            int eid = Integer.parseInt(request.getParameter("employeeid"));
            String nameTask = request.getParameter("nameTask");
            String descriptionTask = request.getParameter("descriptionTask");

            String dateEndStr = request.getParameter("dateEnd");
            Date dateEnd = dateFormat.parse(dateEndStr);

            int maid = Integer.parseInt(request.getParameter("MaId"));

            Task tkadd = new Task(-1, eid, maid, "", nameTask, descriptionTask, null, dateEnd, -1);
            boolean checkInsert = pd.insertTask(tkadd);
            request.getSession().setAttribute("mess", checkInsert);
            response.sendRedirect("createTask?ProjectID=" + Integer.toString(pd.getProjectID(maid)));

            // Redirect to success page
        } catch (java.text.ParseException ex) {
            Logger.getLogger(createTasktoemployee.class.getName()).log(Level.SEVERE, null, ex);
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

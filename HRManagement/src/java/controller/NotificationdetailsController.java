package controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import configs.headerInfor;
import dal.EmployeeDAO;
import dal.NotificationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.AccountDTO;
import models.Employee;
import models.Notification;

/**
 *
 * @author NCM
 */
@WebServlet(urlPatterns = {"/AllNotification"})
public class NotificationdetailsController extends HttpServlet {

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
        HttpSession session = request.getSession();
        AccountDTO acc = (AccountDTO) session.getAttribute("account");
        EmployeeDAO edao = new EmployeeDAO();
        NotificationDAO ndao = new NotificationDAO();
        List<Notification> listNotification = ndao.getAllNotification();
        headerInfor.setSessionAttributes(request);
        request.setAttribute("listNo1", listNotification);
        request.getRequestDispatcher("allNotification.jsp").forward(request, response);
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
        processRequest(request, response);

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
        HttpSession session = request.getSession();
        AccountDTO acc = (AccountDTO) session.getAttribute("account");
        EmployeeDAO edao = new EmployeeDAO();
        NotificationDAO ndao = new NotificationDAO();
        NotificationDAO NDao = new NotificationDAO();
        List<Notification> listNotification = ndao.getAllNotification();
        try {

            Employee em = edao.getin4(acc.getUserID());
            request.setAttribute("emp", em);

        } catch (Exception e) {
        }
        request.setAttribute("listNo", listNotification);
        String url = "allNotification.jsp";
        String button = request.getParameter("btAction");
        try {
            if (button == null) {

            } //Update thong tin nhan vien
            else if (button.equals("Search")) {

                String search = request.getParameter("search");

                List<Notification> listNotification1 = NDao.searchNotification(search);
                request.setAttribute("listNo", listNotification);
                request.setAttribute("listNo1", listNotification1);

            } else if (button.equals("Find")) {

                Date fromDate = null;
                Date toDate = null;
                String fromDateStr = request.getParameter("dateFrom");
                String toDateStr = request.getParameter("dateEnd");
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                try {
                    if (fromDateStr != null && !fromDateStr.isEmpty()) {
                        fromDate = dateFormat.parse(fromDateStr);
                    }
                    if (toDateStr != null && !toDateStr.isEmpty()) {
                        toDate = dateFormat.parse(toDateStr);
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
                // LocalDate cho ngày không chứa thông tin về thời gian
                List<Notification> listNotification1 = NDao.searchNotificationwithdate(fromDate, toDate);
                request.setAttribute("listNo", listNotification);
                request.setAttribute("listNo1", listNotification1);
            }
        } catch (Exception ex) {

        }
        request.getRequestDispatcher(url).forward(request, response);
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

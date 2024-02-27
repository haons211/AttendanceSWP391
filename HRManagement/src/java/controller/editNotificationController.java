/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountDAO;
import dal.EmployeeDAO;
import dal.NotificationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.Collection;
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
@WebServlet(name = "editNotificationController", urlPatterns = {"/editNotification"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // Kích thước tệp tối đa trước khi lưu vào bộ nhớ tạm thời (2MB)
        maxFileSize = 1024 * 1024 * 10, // Kích thước tệp tối đa cho mỗi tệp (10MB)
        maxRequestSize = 1024 * 1024 * 50 // Kích thước tối đa cho mỗi yêu cầu (50MB)
)
public class editNotificationController extends HttpServlet {

    private static final String SAVE_DIR = "uploads";

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
            out.println("<title>Servlet editNotificationController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet editNotificationController at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        AccountDTO acc = (AccountDTO) session.getAttribute("account");
        AccountDAO accDao = new AccountDAO();
        NotificationDAO notidao = new NotificationDAO();
        int i = Integer.parseInt(request.getParameter("id"));
        List<models.Notification> listNotification = notidao.getAllNotification();
        EmployeeDAO emDao = new EmployeeDAO();
        Employee em = null;
        try {
            em = emDao.getin4(acc.getUserID());
            Employee AuthorNotification = emDao.getin4byemid(i);
            request.setAttribute("emp", em);
            request.setAttribute("listNo", listNotification);
            request.setAttribute("listNo1", listNotification);
            request.setAttribute("Author", AuthorNotification);
        } catch (SQLException ex) {
            Logger.getLogger(editNotificationController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(editNotificationController.class.getName()).log(Level.SEVERE, null, ex);
        }

        try {
            models.Notification n = notidao.getdetailsNotification(i);
            request.setAttribute("Noti", n);
            request.getRequestDispatcher("EditNotification.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Notification.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Notification.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
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
            String subject = request.getParameter("subject");
            String description = request.getParameter("description");
            int op = Integer.parseInt(request.getParameter("option"));
            int i = Integer.parseInt(request.getParameter("id"));
            NotificationDAO ndao = new NotificationDAO();
            int fileId   = ndao.getfileID(i);
    
            NotificationDAO notiDao = new NotificationDAO();
            HttpSession session = request.getSession();
            AccountDTO acc = (AccountDTO) session.getAttribute("account");
            EmployeeDAO dao = new EmployeeDAO();
            Employee em = dao.getin4(acc.getUserID());
            Employee AuthorNotification = dao.getin4byemid(i);
            if (op == 1) {
                boolean deleteManager = ndao.DeleteManagerFile(i);
                boolean deleteFile = ndao.DeleteFile(fileId);
                boolean updateNoti = ndao.UpdateFile(subject, description, i);

            } else {

                Part filePart = request.getPart("file");
                if (filePart != null && filePart.getSize() > 0) {

                    String savePath = request.getServletContext().getRealPath("") + File.separator + SAVE_DIR;
                    File fileSaveDir = new File(savePath);
                    if (!fileSaveDir.exists()) {
                        fileSaveDir.mkdir();
                    }
                    String fileName = "";
                    Collection<Part> parts = request.getParts();
                    for (Part part : parts) {
                        if (part.getSubmittedFileName() != null) {
                            fileName = extractFileName(part);
                            part.write(savePath + File.separator + fileName);
                        }
                    }
                    boolean deleteManager = ndao.DeleteManagerFile(i);
                    boolean deleteFile = ndao.DeleteFile(fileId);
                    try (InputStream fileInputStream = filePart.getInputStream()) {
                        boolean insertFile = ndao.insertFile(fileName, fileInputStream);
                    }
                    boolean insertmanager = ndao.insertManagerfile(i, notiDao.getLatestFileId());
                    boolean updateNoti = ndao.UpdateFile(subject, description, i);

                } else {
                    boolean updateNoti = ndao.UpdateFile(subject, description, i);
                }

            }
            models.Notification n = notiDao.getdetailsNotification(i);
                    request.setAttribute("Noti", n);
            List<models.Notification> listNotification = ndao.getAllNotification();
            request.setAttribute("emp", em);
            request.setAttribute("listNo", listNotification);
            request.setAttribute("listNo1", listNotification);
            request.setAttribute("Author", AuthorNotification);
             request.getRequestDispatcher("DetailsNotification.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(editNotificationController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(editNotificationController.class.getName()).log(Level.SEVERE, null, ex);
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

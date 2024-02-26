/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configs.headerInfor;
import dal.AccountDAO;
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
import java.util.logging.Level;
import java.util.logging.Logger;
import models.AccountDTO;

/**
 *
 * @author NCM
 */
@WebServlet(name = "NotificationManagerController", urlPatterns = {"/ManagerNotification"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // Kích thước tệp tối đa trước khi lưu vào bộ nhớ tạm thời (2MB)
        maxFileSize = 1024 * 1024 * 10, // Kích thước tệp tối đa cho mỗi tệp (10MB)
        maxRequestSize = 1024 * 1024 * 50 // Kích thước tối đa cho mỗi yêu cầu (50MB)
)
public class NotificationManagerController extends HttpServlet {

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
        headerInfor.setSessionAttributes(request);
        request.getRequestDispatcher("CreateNotification.jsp").forward(request, response);
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
        AccountDAO accDao = new AccountDAO();
        NotificationDAO notidao = new NotificationDAO();

        String subject = request.getParameter("subject");
        String description = request.getParameter("description");
        boolean checkNoti = false;
        boolean checkAlert = false;

        Part filePart = request.getPart("file");
        if (filePart != null && filePart.getSize() > 0) {
            // File đã được chọn, tiếp tục xử lý

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

            // Lưu thông tin file vào cơ sở dữ liệu
            try (InputStream fileInputStream = filePart.getInputStream()) {
                boolean checkFile = notidao.insertFile(fileName, fileInputStream);
                checkNoti = notidao.createNotification(subject, description, accDao.getEmployeeId(acc.getUserID()));
                if (checkFile && checkNoti) {
                    notidao.insertManagerfile(notidao.getLatestNotificationId(), notidao.getLatestFileId());
                    checkAlert = true;
                } else {
                    checkAlert = false;
                }
            } catch (ClassNotFoundException | SQLException ex) {

            }
        } else {
            try {

                checkNoti = notidao.createNotification(subject, description, accDao.getEmployeeId(acc.getUserID()));
                if (checkNoti) {
                    checkAlert = true;
                } else {
                    checkAlert = false;
                }
            } catch (ClassNotFoundException ex) {

            } catch (SQLException ex) {

            }
        }
        request.setAttribute("alert", checkAlert);
        request.getRequestDispatcher("CreateNotification.jsp").forward(request, response);
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
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

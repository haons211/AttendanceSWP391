/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountDAO;
import dal.EmployeeDAO;
import models.AccountDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Employee;
import java.util.regex.*;

/**
 *
 * @author NCM
 */
public class LoginController extends HttpServlet {

    public static boolean isusernameValid(String password) {
        // Kiểm tra độ dài của mật khẩu
        if (password.length() < 4) {
            return false;
        }
        Pattern specialCharPattern = Pattern.compile("[^a-zA-Z0-9]");
        Matcher specialCharMatcher = specialCharPattern.matcher(password);
        if (specialCharMatcher.find()) {
            return false;
        }
        return true;
    }

    public static boolean isPasswordValid(String password) {
        // Kiểm tra độ dài của mật khẩu
        if (password.length() < 6) {
            return false;
        }

        // Kiểm tra có ít nhất một chữ cái viết hoa
        Pattern upperCasePattern = Pattern.compile("[A-Z]");
        Matcher upperCaseMatcher = upperCasePattern.matcher(password);
        if (!upperCaseMatcher.find()) {
            return false;
        }

        // Kiểm tra có ít nhất một ký tự đặc biệt
        Pattern specialCharPattern = Pattern.compile("[^a-zA-Z0-9]");
        Matcher specialCharMatcher = specialCharPattern.matcher(password);
        if (!specialCharMatcher.find()) {
            return false;
        }

        return true;
    }

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
            out.println("<title>Servlet Login</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Login at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "Login.jsp";
        request.getRequestDispatcher(url).forward(request, response);
    }

    public static String hashPasswordMD5(String password) throws NoSuchAlgorithmException {
        // Tạo đối tượng MessageDigest với thuật toán MD5
        MessageDigest md = MessageDigest.getInstance("MD5");
        // Cập nhật dữ liệu đầu vào
        md.update(password.getBytes());
        // Nhận giá trị băm dưới dạng mảng byte
        byte[] mdBytes = md.digest();
        // Chuyển đổi mảng byte thành chuỗi hex
        StringBuilder hexString = new StringBuilder();
        for (byte mdByte : mdBytes) {
            hexString.append(String.format("%02x", mdByte));
        }
        return hexString.toString();
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            /* TODO output your page here. You may use following sample code. */
            String url = "Login.jsp";
            String username = request.getParameter("txtUsername");
            String inpassword = request.getParameter("txtPassword");
            if (username.equals("")) {
                username = null;
            }
            if (inpassword.equals("")) {
                inpassword = null;
            }
            String errorMessage = "";

            if (username != null && inpassword != null) {
                if (isPasswordValid(inpassword) == false && isusernameValid(username) == true) {
                    errorMessage = "Password must have at least 6 characters or more, including at least one uppercase character and one special character";
                    // Kiểm tra nếu người dùng chưa đăng nhập hoặc bị chặn bởi filter, không hiển thị lỗi
                    request.setAttribute("error", errorMessage);
                    request.getRequestDispatcher(url).forward(request, response);

                } else if (isPasswordValid(inpassword) == true && isusernameValid(username) == false) {
                    errorMessage = "Username must be more than 4 characters long and cannot contain special characters";
                    // Kiểm tra nếu người dùng chưa đăng nhập hoặc bị chặn bởi filter, không hiển thị lỗi
                    request.setAttribute("error", errorMessage);
                    request.getRequestDispatcher(url).forward(request, response);
                } else if (isPasswordValid(inpassword) == false && isusernameValid(username) == false) {
                    errorMessage = "Username must be more than 4 characters long and cannot contain special characters and Password must have at least 6 characters or more, including at least one uppercase character and one special character ";
                    // Kiểm tra nếu người dùng chưa đăng nhập hoặc bị chặn bởi filter, không hiển thị lỗi
                    request.setAttribute("error", errorMessage);
                    request.getRequestDispatcher(url).forward(request, response);
                } else {
                    String password = hashPasswordMD5(inpassword);
                    AccountDAO dao = new AccountDAO();
                    AccountDTO account = dao.checkLogin(username, password);
                    EmployeeDAO em = new EmployeeDAO();
                    if (account != null) {
                        try {
                            Employee emp = em.getin4(account.getUserID());
                            int role = account.getRole();
                            if (role == 2) {
                                url = "HomeEmployees";
                                HttpSession session = request.getSession();
                                session.setAttribute("account", account);
                                session.setAttribute("employee", emp);
                                response.sendRedirect(url);
                            } else if (role == 3) {
                                url = "HomeManager";
                                HttpSession session = request.getSession();
                                session.setAttribute("account", account);
                                session.setAttribute("employee", emp);
                                response.sendRedirect(url);
                            } else if (role == 1) {
                                url = "HomeAdmin";
                                HttpSession session = request.getSession();
                                session.setAttribute("account", account);
                                session.setAttribute("employee", emp);
                                response.sendRedirect(url);
                            }
                        } catch (Exception ex) {
                            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    } else {
                        errorMessage = "Sai tên đăng nhập hoặc mật khẩu. Vui lòng thử lại.";
                        // Kiểm tra nếu người dùng chưa đăng nhập hoặc bị chặn bởi filter, không hiển thị lỗi
                        request.setAttribute("error", errorMessage);
                        request.getRequestDispatcher(url).forward(request, response);
                        return;
                    }
                }
            } else if ((username == null && inpassword != null)) {
                errorMessage = "Username is Empty. Please try again";
                // Kiểm tra nếu người dùng chưa đăng nhập hoặc bị chặn bởi filter, không hiển thị lỗi
                request.setAttribute("error", errorMessage);
                request.getRequestDispatcher(url).forward(request, response);

            } else if ((username != null && inpassword == null)) {
                errorMessage = "Password is Empty.Please try again";
                // Kiểm tra nếu người dùng chưa đăng nhập hoặc bị chặn bởi filter, không hiển thị lỗi
                request.setAttribute("error", errorMessage);
                request.getRequestDispatcher(url).forward(request, response);
            } else {
                errorMessage = "username and password should not empty";
                // Kiểm tra nếu người dùng chưa đăng nhập hoặc bị chặn bởi filter, không hiển thị lỗi
                request.setAttribute("error", errorMessage);
                request.getRequestDispatcher(url).forward(request, response);
            }

        } catch (Exception e) {

        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

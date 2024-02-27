/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configs.headerInfor;
import static controller.LoginController.isPasswordValid;
import static controller.LoginController.isusernameValid;
import dal.AccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author andep
 */
@WebServlet(name = "AddAccountController", urlPatterns = {"/addAccount"})
public class AddAccountController extends HttpServlet {

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
            out.println("<title>Servlet AddAccountController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddAccountController at " + request.getContextPath() + "</h1>");
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
        headerInfor.setSessionAttributes(request);
        request.getRequestDispatcher("AddAccount.jsp").forward(request, response);
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
        // Lấy thông tin từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String passwordHex = hashPasswordMD5(password);
        String repass = request.getParameter("repass");
        String repassHex = hashPasswordMD5(repass);
        String role = request.getParameter("role");
        int roleId = role.equals("Admin") ? 1
                : role.equals("Manager") ? 2
                : role.equals("Employee") ? 3 : 0;
        // Validate and sanitize inputs
        if (username != null && password != null) {
            if (new AccountDAO().isUsernameExists(username)) {
                request.setAttribute("errorMessage", "Username already exists. Please choose another one.");
                request.getRequestDispatcher("AddAccount.jsp").forward(request, response);
                return; // Kết thúc phương thức nếu tên người dùng đã tồn tại
            }
            if (isPasswordValid(password) == false && isusernameValid(username) == true) {
                request.setAttribute("errorMessage", "Password must have "
                        + "at least 6 characters or more, including at least one "
                        + "uppercase character and one special character");
            } else if (isPasswordValid(password) == true && isusernameValid(username) == false) {
                request.setAttribute("errorMessage", "Username must be "
                        + "more than 4 characters long and cannot contain special "
                        + "characters");
            } else if (isPasswordValid(password) == false && isusernameValid(username) == false) {
                request.setAttribute("errorMessage", "Username must be more "
                        + "than 4 characters long and cannot contain special "
                        + "characters and Password must have at least 6 characters "
                        + "or more, including at least one uppercase character and "
                        + "one special character");
            } else {
                if (repassHex.equals(passwordHex)) {
                    AccountDAO dao = new AccountDAO();
                    try {
                        // Sanitize and manually replace '<' and '>'
                        username = sanitizeInput(username);
                        passwordHex = sanitizeInput(passwordHex);
                        dao.addUser(username, passwordHex, roleId);

                        // Set thông báo thành công
                        request.setAttribute("successMessage", "Account add successful!");

                        // Xóa thông báo lỗi nếu có
                        request.getSession().removeAttribute("errorMessage");
                    } catch (Exception e) {
                        e.printStackTrace();
                        // Set thông báo lỗi chung nếu có lỗi xảy ra
                        request.setAttribute("errorMessage", "Error adding account.");
                    }
                } else {
                    request.setAttribute("errorMessage", "Confirmation password is not correct");
                }
            }
        } else {
            // Invalid input, set an error message
            request.setAttribute("errorMessage", "Invalid input. Please enter valid data.");
        }
        request.getRequestDispatcher("AddAccount.jsp").forward(request, response);
    }
// Sanitization method to replace '<' and '>'

    private String sanitizeInput(String input) {
        // Manually replace '<' and '>'
        return input.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
    }

    public static String hashPasswordMD5(String password) {
        // Tạo đối tượng MessageDigest với thuật toán MD5
        MessageDigest md;
        StringBuilder hexString = new StringBuilder();
        try {
            md = MessageDigest.getInstance("MD5");
            md.update(password.getBytes());
            // Nhận giá trị băm dưới dạng mảng byte
            byte[] mdBytes = md.digest();
            // Chuyển đổi mảng byte thành chuỗi hex
            for (byte mdByte : mdBytes) {
                hexString.append(String.format("%02x", mdByte));

            }
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(AddAccountController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        // Cập nhật dữ liệu đầu vào
        return hexString.toString();
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

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package configs;

import dal.EmployeeDAO;
import dal.NotificationDAO;
import dal.RemaindayDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import models.AccountDTO;
import models.Employee;
import models.Notification;

/**
 *
 * @author NCM
 */
public class headerInfor {
     

    public static void setSessionAttributes(HttpServletRequest request) {
       HttpSession session = request.getSession();
        AccountDTO acc = (AccountDTO) session.getAttribute("account");

        EmployeeDAO dao = new EmployeeDAO();
        RemaindayDAO remaindayDAO = new RemaindayDAO();
        NotificationDAO notificationDAO = new NotificationDAO();

        List<Notification> listNotification = notificationDAO.getAllNotification();

        try {
            Employee em = dao.getin4(acc.getUserID());
           
            request.setAttribute("emp", em);
            request.setAttribute("listNo", listNotification);
        } catch (Exception e) {
            e.printStackTrace(); // Handle exception properly based on your application's requirement
        }
    }
}

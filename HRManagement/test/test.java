
import dal.AccountDAO;
import dal.DashboardDAO;
import java.util.List;
import models.Employee;

public class test {

    public static void main(String[] args) {
        DashboardDAO dao = new DashboardDAO();
        List<Employee> list = dao.getTop5Employee();
        for (Employee object : list) {
            System.out.println(list);
        }
    }
}

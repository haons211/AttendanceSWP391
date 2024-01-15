
import dal.AccountDAO;
import dal.DashboardDAO;
import java.util.List;
import models.employee;

public class test {

    public static void main(String[] args) {
        DashboardDAO dao = new DashboardDAO();
        List<employee> list = dao.getTop5Employee();
        for (employee object : list) {
            System.out.println(list);
        }
    }
}

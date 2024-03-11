import dal.InsuranceDAO;
import java.util.ArrayList;
import models.InsuranceEmployeeDTO;

public class test {
    public static void main(String[] args) {
        InsuranceDAO controller = new InsuranceDAO();
        ArrayList<InsuranceEmployeeDTO> types = controller.getAllType();

        // In ra các loại bảo hiểm được trả về
        for (InsuranceEmployeeDTO type : types) {
            System.out.println(type.getCoverageType());
        }
    }
}
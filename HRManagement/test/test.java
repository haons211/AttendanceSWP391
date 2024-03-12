
import dal.BeneficiaryDAO;


public class test {

    public static void main(String[] args) {
        // Thay thế các giá trị dưới đây bằng dữ liệu thực tế từ yêu cầu của bạn
        int id_employee = 1;
        String name = "John Doe";
        boolean gender = true; // true nếu là nam, false nếu là nữ
        String dob = "1990-01-01"; // Định dạng: YYYY-MM-DD
        String relationship = "Spouse";

        BeneficiaryDAO beneficiaryDAO = new BeneficiaryDAO();

        try {
            // Gọi phương thức addBeneficiary để thêm một người thụ hưởng mới
            beneficiaryDAO.addBeneficiary(id_employee, name, gender, dob, relationship);
            System.out.println("Beneficiary added successfully.");
        } catch (Exception e) {
            System.out.println("An error occurred while adding beneficiary: " + e.getMessage());
        }
    }
}

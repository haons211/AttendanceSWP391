
import dal.BeneficiaryDAO;


public class test {

    public static void main(String[] args) {
        // Thay thế các giá trị dưới đây bằng dữ liệu thực tế từ yêu cầu của bạn
        int dependentId = 1;
        int employeeId = 1;
        String name = "Updated Name";
        boolean gender = true; // true nếu là nam, false nếu là nữ
        String dateOfBirth = "1990-01-01"; // Định dạng: YYYY-MM-DD
        String relationship = "Updated Relationship";

        BeneficiaryDAO beneficiaryDAO = new BeneficiaryDAO();

        try {
            // Gọi phương thức updateBeneficiary để cập nhật thông tin người thụ hưởng
            beneficiaryDAO.updateBeneficiary(dependentId, employeeId, name, gender, dateOfBirth, relationship);
            System.out.println("Beneficiary updated successfully.");
        } catch (Exception e) {
            System.out.println("An error occurred while updating beneficiary: " + e.getMessage());
        }
    }
}

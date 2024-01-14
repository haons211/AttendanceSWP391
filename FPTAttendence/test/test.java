
import dal.AccountDAO;

public class test {

    public static void main(String[] args) {
        AccountDAO yourClassInstance = new AccountDAO();

        // Giả sử rằng trong cơ sở dữ liệu có 5 departments
        int expectedNumberOfDepartments = 5;

        // Gọi hàm để lấy số lượng departments
        int actualNumberOfDepartments = yourClassInstance.getNumberOfDepartments();

        // In ra kết quả để kiểm tra
        System.out.println("Expected number of departments: " + expectedNumberOfDepartments);
        System.out.println("Actual number of departments: " + actualNumberOfDepartments);

        // Kiểm tra và in ra kết luận
        if (expectedNumberOfDepartments == actualNumberOfDepartments) {
            System.out.println("Test Passed!");
        } else {
            System.out.println("Test Failed!");
        }
    }
}

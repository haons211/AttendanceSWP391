
import dal.DashboardDAO;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import models.DepartmentAttendanceDTO;
import models.DepartmentEmployeeCountDTO;

public class test {

    public static void main(String[] args) {
        DashboardDAO dashboardDAO = new DashboardDAO();

        // Gọi hàm để lấy danh sách department_name và attendance_percentage
        ArrayList<DepartmentAttendanceDTO> departmentAttendanceList = dashboardDAO.getAttendancePercentageByDepartment();

        // Hiển thị kết quả
        System.out.println("Department Attendance Percentage:");
        for (DepartmentAttendanceDTO dto : departmentAttendanceList) {
            System.out.println("Department Name: " + dto.getDepartmentName());
            System.out.println("Attendance Percentage: " + dto.getAttendancePercentage() + "%");
            System.out.println("----------------------");
        }
    }
}

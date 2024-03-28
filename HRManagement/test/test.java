
import dal.AttendanceDAO;
import dal.BeneficiaryDAO;

public class test {

    public static void main(String[] args) {
        AttendanceDAO dao = new AttendanceDAO();

        // Dữ liệu mẫu để kiểm tra
        int attendance_id = 1;
        String in_time = "09:00:00";
        String out_time = "17:00:00";
        String notes = "Test notes";
        String status = "Present";
        String in_status = "On time";
        String out_status = "On time";
        int remainDay = 4;
        String date = "2024-03-28";

        // Gọi phương thức updateAttendance và in kết quả
        String result = dao.updateAttendance(
                attendance_id, 
                in_time, 
                out_time, 
                notes, 
                status, 
                in_status, 
                out_status, 
                remainDay, 
                date);
        System.out.println(result);
    }
}

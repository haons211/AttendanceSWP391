/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package configs;

import java.util.Date;
import java.text.ParseException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 *
 * @author Dan
 */
public class Validate {

    public boolean checkPhone(String phone) {
        String regex = "^0\\d{9}$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(phone);
        return matcher.matches();
    }

//    public  boolean checkEmail(String email) {
//        String regex = "^[a-z][a-z0-9_\\.]{5,32}@[a-z0-9]{2,}(\\.[a-z0-9]{2,4}){1,2}$";
//        Pattern pattern = Pattern.compile(regex);
//        Matcher matcher = pattern.matcher(email);
//        return matcher.matches();
//    }
    public boolean checkWords(String input) {
        String regex = "^[a-zA-Z0-9 ]+$";
        return Pattern.matches(regex, input);
    }

    public boolean checkAddress(String input) {
        String regex = "^[a-zA-Z0-9,/]+$";
        return Pattern.matches(regex, input);
    }

    public boolean checkDate(String input) {
        String regex = "^[0-9/-]+$";
        return Pattern.matches(regex, input);
    }

    public String normalizeName(String name) {

        String lowercaseName = name.toLowerCase();
        // Chuyển ký tự đầu tiên của mỗi từ thành chữ hoa
        String[] nameParts = lowercaseName.split(" ");
        StringBuilder normalized = new StringBuilder();
        for (String part : nameParts) {
            if (!part.isEmpty()) {
                normalized.append(Character.toUpperCase(part.charAt(0))).append(part.substring(1)).append(" ");
            }
        }
        return normalized.toString().trim();
    }

    public boolean compareDate(String firstDate, String secondDate) throws ParseException {

        firstDate = firstDate.replace('-', '/');
        secondDate = secondDate.replace('-', '/');
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        Date date1 = dateFormat.parse(firstDate);
        Date date2 = dateFormat.parse(secondDate);

        if (date1.after(date2)) {
            return false;
        }
        return true;
    }

    public boolean isAdult(String dateOfBirthString) throws ParseException {
        dateOfBirthString = dateOfBirthString.replace('-', '/');

        // Chuyển đổi chuỗi ngày tháng thành đối tượng Date
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        Date dateOfBirth = dateFormat.parse(dateOfBirthString);

        // Tạo một Calendar object để lấy ngày hiện tại
        Calendar dob = Calendar.getInstance();
        dob.setTime(dateOfBirth);

        // Lấy ngày hiện tại
        Calendar today = Calendar.getInstance();

        // Tính tuổi dựa trên năm sinh và năm hiện tại
        int age = today.get(Calendar.YEAR) - dob.get(Calendar.YEAR);
        if (age < 18) {
            return false;
        }

        // Trong trường hợp có lỗi xảy ra, trả về false
        return true;
    }

    public boolean validateTime(String checkin, String checkout) {
        // Kiểm tra xem checkin và checkout có null hoặc trống không
        if (checkin == null || checkin.isEmpty() || checkout == null || checkout.isEmpty()) {
            return false;
        }

        // Chuyển đổi chuỗi thời gian thành đối tượng thời gian (Date) để so sánh
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
        try {
            Date checkinTime = sdf.parse(checkin);
            Date checkoutTime = sdf.parse(checkout);

            // So sánh checkin và checkout
            return checkinTime.before(checkoutTime);
        } catch (ParseException e) {
            // Xử lý ngoại lệ nếu định dạng thời gian không hợp lệ
            e.printStackTrace();
            return false;
        }
    }

    public boolean validateDateBeforeToday(String date) {
        // Kiểm tra xem date có null hoặc trống không
        if (date == null || date.isEmpty()) {
            return false;
        }

        // Lấy ngày hiện tại
        Date currentDate = new Date();

        // Chuyển đổi chuỗi ngày thành đối tượng ngày (Date) để so sánh
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date inputDate = sdf.parse(date);

            // So sánh date với ngày hiện tại
            return inputDate.before(currentDate);
        } catch (ParseException e) {
            // Xử lý ngoại lệ nếu định dạng ngày không hợp lệ
            e.printStackTrace();
            return false;
        }
    }

    public boolean validateRemainDay(int remainday, int approvedLeaveDays) {
        return remainday <= approvedLeaveDays;
    }
}
//    public static void main(String[] args) throws ParseException {
//        String a = "2024-02-15";
//        String b = "2024-02-03";
//        Validate validate = new Validate();
//        Date currentDate = new Date();
//
//        
//        try {
//            System.out.println(validate.compareDate(a, b));
////            System.out.println("Age check: " + validate.isAdult(b));
//        } catch (ParseException e) {
//            e.printStackTrace();
//        }
//
//    }



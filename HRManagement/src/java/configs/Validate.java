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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Calendar;
import models.AccountDTO;

import java.io.IOException;

/**
 *
 * @author Dan
 */
public class Validate {

    public boolean validateRemainDay(int remainday, int approvedLeaveDays) {
        return remainday <= approvedLeaveDays;
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

    public boolean checkPhone(String phone) {
        String regex = "^0\\d{9}$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(phone);
        return matcher.matches();
    }

    public boolean checkEmail(String email) {
        String regex = "^[A-Za-z0-9_.-]+@example\\.com$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }

    public boolean checkWords(String input) {
        String regex = "^[\\p{L}0-9\\s\\p{M}]+$";
        return Pattern.matches(regex, input);
    }

    public boolean checkAddress(String input) {
        String regex = "^[\\p{L}0-9\\s,\\/\\p{M}]+$";
        return Pattern.matches(regex, input);
    }

    public boolean checkDate(String input) {
        String regex = "^[0-9/-]+$";
        return Pattern.matches(regex, input);
    }

    public String normalizeName(String name) {

        String lowercaseName = name.toLowerCase();

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

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        Date dateOfBirth = dateFormat.parse(dateOfBirthString);

        Calendar dob = Calendar.getInstance();
        dob.setTime(dateOfBirth);

        Calendar today = Calendar.getInstance();

        int age = today.get(Calendar.YEAR) - dob.get(Calendar.YEAR);
        if (age < 18) {
            return false;
        }

        return true;
    }

    public boolean isPasswordValid(String password) {
        // Kiểm tra độ dài của mật khẩu

        if (password.length() < 6 || password == null) {
            return false;
        }

        // Kiểm tra có ít nhất một chữ cái viết hoa
        Pattern upperCasePattern = Pattern.compile("[A-Z]");
        Matcher upperCaseMatcher = upperCasePattern.matcher(password);
        if (!upperCaseMatcher.find()) {
            return false;
        }

        // Kiểm tra có ít nhất một ký tự đặc biệt
        Pattern specialCharPattern = Pattern.compile("[^a-zA-Z0-9]");
        Matcher specialCharMatcher = specialCharPattern.matcher(password);
        if (!specialCharMatcher.find()) {
            return false;
        }

        return true;
    }

    public boolean validateDouble(String input) {
        try {
            // Attempt to parse the input string to a double value
            Double.parseDouble(input);
            // If parsing succeeds, return true
            return true;
        } catch (NumberFormatException e) {
            // If parsing fails (NumberFormatException is thrown), return false
            return false;
        }
    }

}

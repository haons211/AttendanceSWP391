/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Dan
 */
public class Salary {

    private int salaryId;
    private int employeeId;
    private int departmentId;
    private int attendanceId;
    private double allowance;
    private double tax;
    private double bonus;
    private String receivedDate;
    private int userId;

    public Salary() {
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Salary(double allowance, double tax, double bonus) {
        this.allowance = allowance;
        this.tax = tax;
        this.bonus = bonus;
    }

    public Salary(int salaryId, int employeeId, int departmentId, int attendanceId, double allowance, double tax, double bonus, String receivedDate, int userId) {
        this.salaryId = salaryId;
        this.employeeId = employeeId;
        this.departmentId = departmentId;
        this.attendanceId = attendanceId;
        this.allowance = allowance;
        this.tax = tax;
        this.bonus = bonus;
        this.receivedDate = receivedDate;
        this.userId = userId;
    }

    public Salary(double allowance, double tax, double bonus, String receivedDate) {
        this.allowance = allowance;
        this.tax = tax;
        this.bonus = bonus;
        this.receivedDate = receivedDate;
    }

    public Salary(int employeeId, int departmentId, int attendanceId, double allowance, double tax, double bonus, String receivedDate, int userId) {
        this.employeeId = employeeId;
        this.departmentId = departmentId;
        this.attendanceId = attendanceId;
        this.allowance = allowance;
        this.tax = tax;
        this.bonus = bonus;
        this.receivedDate = receivedDate;
        this.userId = userId;
    }

    public int getSalaryId() {
        return salaryId;
    }

    public void setSalaryId(int salaryId) {
        this.salaryId = salaryId;
    }

    public int getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(int employeeId) {
        this.employeeId = employeeId;
    }

    public int getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(int departmentId) {
        this.departmentId = departmentId;
    }

    public int getAttendanceId() {
        return attendanceId;
    }

    public void setAttendanceId(int attendanceId) {
        this.attendanceId = attendanceId;
    }

    public double getAllowance() {
        return allowance;
    }

    public void setAllowance(double allowance) {
        this.allowance = allowance;
    }

    public double getTax() {
        return tax;
    }

    public void setTax(double tax) {
        this.tax = tax;
    }

    public double getBonus() {
        return bonus;
    }

    public void setBonus(double bonus) {
        this.bonus = bonus;
    }

    public String getReceivedDate() {
        return receivedDate;
    }

    public void setReceivedDate(String receivedDate) {
        this.receivedDate = receivedDate;
    }

}

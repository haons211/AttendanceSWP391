/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Dan
 */
public class EmployeeSalary {

    private int salaryId;
    private int employeeId;
    private int departmentId;
    private int attendanceId;
    private double basicSalary;
    private double allowance;
    private double tax;
    private double bonus;
    private String receivedDate;
    private String ename;
    private String email;
    private String image;
    private String hireDate;
    private String dname;
    private double totalSalary;
    private int userId;

    public EmployeeSalary(int salaryId, int employeeId, int departmentId, int attendanceId, double basicSalary, double allowance, double tax, double bonus, String receivedDate, String ename, String email, String image, String hireDate, String dname, double totalSalary ) {
        this.salaryId = salaryId;
        this.employeeId = employeeId;
        this.departmentId = departmentId;
        this.attendanceId = attendanceId;
        this.basicSalary = basicSalary;
        this.allowance = allowance;
        this.tax = tax;
        this.bonus = bonus;
        this.receivedDate = receivedDate;
        this.ename = ename;
        this.email = email;
        this.image = image;
        this.hireDate = hireDate;
        this.dname = dname;
        this.totalSalary = totalSalary;
      
    }

    public EmployeeSalary(int salaryId, int employeeId, int departmentId, int attendanceId, double basicSalary, double allowance, double tax, double bonus, String receivedDate, String ename, String email, String image, String hireDate, String dname) {
        this.salaryId = salaryId;
        this.employeeId = employeeId;
        this.departmentId = departmentId;
        this.attendanceId = attendanceId;
        this.basicSalary = basicSalary;
        this.allowance = allowance;
        this.tax = tax;
        this.bonus = bonus;
        this.receivedDate = receivedDate;
        this.ename = ename;
        this.email = email;
        this.image = image;
        this.hireDate = hireDate;
        this.dname = dname;
    }
    

    public EmployeeSalary(int salaryId, int employeeId, int departmentId, int attendanceId, double basicSalary, double allowance, double tax, double bonus, String receivedDate, String ename, String email, String image, String hireDate, String dname, double totalSalary, int userId) {
        this.salaryId = salaryId;
        this.employeeId = employeeId;
        this.departmentId = departmentId;
        this.attendanceId = attendanceId;
        this.basicSalary = basicSalary;
        this.allowance = allowance;
        this.tax = tax;
        this.bonus = bonus;
        this.receivedDate = receivedDate;
        this.ename = ename;
        this.email = email;
        this.image = image;
        this.hireDate = hireDate;
        this.dname = dname;
        this.totalSalary = totalSalary;
        this.userId = userId;
    }

    public EmployeeSalary(int employeeId, int departmentId, int attendanceId, int userId, String hireDate) {
        this.employeeId = employeeId;
        this.departmentId = departmentId;
        this.attendanceId = attendanceId;
        this.userId = userId;
        this.hireDate = hireDate;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public EmployeeSalary() {
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

    public double getBasicSalary() {
        return basicSalary;
    }

    public void setBasicSalary(double basicSalary) {
        this.basicSalary = basicSalary;
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

    public String getEname() {
        return ename;
    }

    public void setEname(String ename) {
        this.ename = ename;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getHireDate() {
        return hireDate;
    }

    public void setHireDate(String hireDate) {
        this.hireDate = hireDate;
    }

    public String getDname() {
        return dname;
    }

    public void setDname(String dname) {
        this.dname = dname;
    }

    public double getTotalSalary() {
        return totalSalary;
    }

    public void setTotalSalary(double totalSalary) {
        this.totalSalary = totalSalary;
    }

}

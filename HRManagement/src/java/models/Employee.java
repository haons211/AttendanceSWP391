/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Dan
 */
public class Employee {

    private int employeeId;
    private String name;
    private String phoneNumber;
    private String address;
    private String email;
    private boolean gender;
    private String image;
    private String birthDate;
    private String hireDate;
    private int userId;
    private double basicSalary;
    private int departmentId;

    public Employee() {
    }

    public Employee(String name, String phoneNumber, String address, String email, boolean gender, String image, String birthDate, String hireDate, int userId, double basicSalary) {
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.email = email;
        this.gender = gender;
        this.image = image;
        this.birthDate = birthDate;
        this.hireDate = hireDate;
        this.userId = userId;
        this.basicSalary = basicSalary;
    }

    public Employee(int employeeId, int departmentId) {
        this.employeeId = employeeId;
        this.departmentId = departmentId;
    }

    public int getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(int departmentId) {
        this.departmentId = departmentId;
    }
    

    public Employee(int employeeId, String name, String phoneNumber, String address, String email, boolean gender, String image, String birthDate, String hireDate, int userId, double basicSalary) {
        this.employeeId = employeeId;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.email = email;
        this.gender = gender;
        this.image = image;
        this.birthDate = birthDate;
        this.hireDate = hireDate;
        this.userId = userId;
        this.basicSalary = basicSalary;
    }

    public Employee(String name, String phoneNumber, String address, String email, boolean gender, String image, String birthDate, String hireDate, double basicSalary) {
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.email = email;
        this.gender = gender;
        this.image = image;
        this.birthDate = birthDate;
        this.hireDate = hireDate;
        this.basicSalary = basicSalary;
    }

    public double getBasicSalary() {
        return basicSalary;
    }

    public void setBasicSalary(double basicSalary) {
        this.basicSalary = basicSalary;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(int employeeId) {
        this.employeeId = employeeId;
    }

    public String getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    public String getHireDate() {
        return hireDate;
    }

    public void setHireDate(String hireDate) {
        this.hireDate = hireDate;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

}

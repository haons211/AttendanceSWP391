/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.util.Date;

/**
 *
 * @author andep
 */
public class employee {
    int employee_id;
    String name;
    String phoneNumber;
    String address;
    String email;
    boolean gender;
    String image;
    Date birth_date;
    Date hire_date;
    int user_id;

    public employee() {
    }

    public employee(int employee_id, String name, String phoneNumber, String address, String email, boolean gender, String image, Date birth_date, Date hire_date, int user_id) {
        this.employee_id = employee_id;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.email = email;
        this.gender = gender;
        this.image = image;
        this.birth_date = birth_date;
        this.hire_date = hire_date;
        this.user_id = user_id;
    }

    public int getEmployee_id() {
        return employee_id;
    }

    public void setEmployee_id(int employee_id) {
        this.employee_id = employee_id;
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

    public Date getBirth_date() {
        return birth_date;
    }

    public void setBirth_date(Date birth_date) {
        this.birth_date = birth_date;
    }

    public Date getHire_date() {
        return hire_date;
    }

    public void setHire_date(Date hire_date) {
        this.hire_date = hire_date;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    @Override
    public String toString() {
        return "Employees{" + "employee_id=" + employee_id + ", name=" + name + ", phoneNumber=" + phoneNumber + ", address=" + address + ", email=" + email + ", gender=" + gender + ", image=" + image + ", birth_date=" + birth_date + ", hire_date=" + hire_date + ", user_id=" + user_id + '}';
    }
    
}

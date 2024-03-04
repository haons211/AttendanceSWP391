/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Dan
 */
public class Company {
   
    private int companyId;
    private String companyName;
    private String address;
    private String email;
    private String phoneNumber;
    private String fax;
    private String website;
    private int contactPerson; 
    private int department;

    // Constructors
    public Company() {
        // Default constructor
    }

    public Company(int companyId, String companyName, String address, String email, String phoneNumber, String fax, String website, int contactPerson, int department) {
        this.companyId = companyId;
        this.companyName = companyName;
        this.address = address;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.fax = fax;
        this.website = website;
        this.contactPerson = contactPerson;
        this.department = department;
    }
    
    

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    

    // Getters and setters
    public int getCompanyId() {
        return companyId;
    }

    public void setCompanyId(int companyId) {
        this.companyId = companyId;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
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

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public int getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(int contactPerson) {
        this.contactPerson = contactPerson;
    }

    public int getDepartment() {
        return department;
    }

    public void setDepartment(int department) {
        this.department = department;
    }
}


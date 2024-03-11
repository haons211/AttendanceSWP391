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
public class InsuranceEmployeeDTO {

    private int insuranceId;
    private int employeeId;
    private String insuranceCompany;
    private String policyNumber;
    private String coverageType;
    private Date startDate;
    private Date endDate;
    private double premiumAmount;
    private double deductible;
    private double coPay;
    private String coverageDetails;
    private String policyType;
    private String policyIssuer;
    private String beneficiary;
    private double coverageLimit;
    private Date renewalDate;

    private String name;
    private String phoneNumber;
    private String address;
    private String email;
    private boolean gender;
    private String image;
    private String birthDate;
    private String hireDate;
    private int userId;

    public InsuranceEmployeeDTO() {
    }

    public InsuranceEmployeeDTO(int insuranceId, int employeeId, String insuranceCompany, String policyNumber, String coverageType, Date startDate, Date endDate, double premiumAmount, double deductible, double coPay, String coverageDetails, String policyType, String policyIssuer, String beneficiary, double coverageLimit, Date renewalDate, String name, String phoneNumber, String address, String email, boolean gender, String image, String birthDate, String hireDate, int userId) {
        this.insuranceId = insuranceId;
        this.employeeId = employeeId;
        this.insuranceCompany = insuranceCompany;
        this.policyNumber = policyNumber;
        this.coverageType = coverageType;
        this.startDate = startDate;
        this.endDate = endDate;
        this.premiumAmount = premiumAmount;
        this.deductible = deductible;
        this.coPay = coPay;
        this.coverageDetails = coverageDetails;
        this.policyType = policyType;
        this.policyIssuer = policyIssuer;
        this.beneficiary = beneficiary;
        this.coverageLimit = coverageLimit;
        this.renewalDate = renewalDate;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.email = email;
        this.gender = gender;
        this.image = image;
        this.birthDate = birthDate;
        this.hireDate = hireDate;
        this.userId = userId;
    }

    public int getInsuranceId() {
        return insuranceId;
    }

    public void setInsuranceId(int insuranceId) {
        this.insuranceId = insuranceId;
    }

    public int getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(int employeeId) {
        this.employeeId = employeeId;
    }

    public String getInsuranceCompany() {
        return insuranceCompany;
    }

    public void setInsuranceCompany(String insuranceCompany) {
        this.insuranceCompany = insuranceCompany;
    }

    public String getPolicyNumber() {
        return policyNumber;
    }

    public void setPolicyNumber(String policyNumber) {
        this.policyNumber = policyNumber;
    }

    public String getCoverageType() {
        return coverageType;
    }

    public void setCoverageType(String coverageType) {
        this.coverageType = coverageType;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public double getPremiumAmount() {
        return premiumAmount;
    }

    public void setPremiumAmount(double premiumAmount) {
        this.premiumAmount = premiumAmount;
    }

    public double getDeductible() {
        return deductible;
    }

    public void setDeductible(double deductible) {
        this.deductible = deductible;
    }

    public double getCoPay() {
        return coPay;
    }

    public void setCoPay(double coPay) {
        this.coPay = coPay;
    }

    public String getCoverageDetails() {
        return coverageDetails;
    }

    public void setCoverageDetails(String coverageDetails) {
        this.coverageDetails = coverageDetails;
    }

    public String getPolicyType() {
        return policyType;
    }

    public void setPolicyType(String policyType) {
        this.policyType = policyType;
    }

    public String getPolicyIssuer() {
        return policyIssuer;
    }

    public void setPolicyIssuer(String policyIssuer) {
        this.policyIssuer = policyIssuer;
    }

    public String getBeneficiary() {
        return beneficiary;
    }

    public void setBeneficiary(String beneficiary) {
        this.beneficiary = beneficiary;
    }

    public double getCoverageLimit() {
        return coverageLimit;
    }

    public void setCoverageLimit(double coverageLimit) {
        this.coverageLimit = coverageLimit;
    }

    public Date getRenewalDate() {
        return renewalDate;
    }

    public void setRenewalDate(Date renewalDate) {
        this.renewalDate = renewalDate;
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

    @Override
    public String toString() {
        return "InsuranceEmployeeDTO{" + "insuranceId=" + insuranceId + ", employeeId=" + employeeId + ", insuranceCompany=" + insuranceCompany + ", policyNumber=" + policyNumber + ", coverageType=" + coverageType + ", startDate=" + startDate + ", endDate=" + endDate + ", premiumAmount=" + premiumAmount + ", deductible=" + deductible + ", coPay=" + coPay + ", coverageDetails=" + coverageDetails + ", policyType=" + policyType + ", policyIssuer=" + policyIssuer + ", beneficiary=" + beneficiary + ", coverageLimit=" + coverageLimit + ", renewalDate=" + renewalDate + ", name=" + name + ", phoneNumber=" + phoneNumber + ", address=" + address + ", email=" + email + ", gender=" + gender + ", image=" + image + ", birthDate=" + birthDate + ", hireDate=" + hireDate + ", userId=" + userId + '}';
    }

}

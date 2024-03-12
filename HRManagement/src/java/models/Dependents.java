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
public class Dependents {

    private int dependentId;
    private int employeeId;
    private String name;
    private boolean gender;
    private String dateOfBirth;
    private String relationship;

    public Dependents() {
    }

    public Dependents(int dependentId, int employeeId, String name, boolean gender, String dateOfBirth, String relationship) {
        this.dependentId = dependentId;
        this.employeeId = employeeId;
        this.name = name;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.relationship = relationship;
    }

    public int getDependentId() {
        return dependentId;
    }

    public void setDependentId(int dependentId) {
        this.dependentId = dependentId;
    }

    public int getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(int employeeId) {
        this.employeeId = employeeId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public String getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(String dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getRelationship() {
        return relationship;
    }

    public void setRelationship(String relationship) {
        this.relationship = relationship;
    }

    @Override
    public String toString() {
        return "Dependents{" + "dependentId=" + dependentId + ", employeeId=" + employeeId + ", name=" + name + ", gender=" + gender + ", dateOfBirth=" + dateOfBirth + ", relationship=" + relationship + '}';
    }

}

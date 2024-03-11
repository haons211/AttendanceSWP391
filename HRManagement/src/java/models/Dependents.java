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
    private String firstName;
    private String lastName;
    private Date dateOfBirth;
    private String relationship;

    public Dependents() {
    }

    public Dependents(int dependentId, int employeeId, String firstName, String lastName, Date dateOfBirth, String relationship) {
        this.dependentId = dependentId;
        this.employeeId = employeeId;
        this.firstName = firstName;
        this.lastName = lastName;
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

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
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
        return "Dependents{" + "dependentId=" + dependentId + ", employeeId=" + employeeId + ", firstName=" + firstName + ", lastName=" + lastName + ", dateOfBirth=" + dateOfBirth + ", relationship=" + relationship + '}';
    }
    
}

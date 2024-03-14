/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Admin
 */
public class EmployeeDTO {

    private int employeeId;
    private String name;
    private String departmentName;

    public EmployeeDTO() {
    }

    public EmployeeDTO(int employeeId, String name) {
        this.employeeId = employeeId;
        this.name = name;
    }

    public EmployeeDTO(int employeeId, String name, String departmentName) {
        this.employeeId = employeeId;
        this.name = name;
        this.departmentName = departmentName;
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

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

}

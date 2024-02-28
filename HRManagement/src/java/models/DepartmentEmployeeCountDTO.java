/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author andep
 */
public class DepartmentEmployeeCountDTO {

    private String departmentName;
    private int employeeCount;

    public DepartmentEmployeeCountDTO() {
    }

    public DepartmentEmployeeCountDTO(String departmentName, int employeeCount) {
        this.departmentName = departmentName;
        this.employeeCount = employeeCount;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public int getEmployeeCount() {
        return employeeCount;
    }

    public void setEmployeeCount(int employeeCount) {
        this.employeeCount = employeeCount;
    }

    @Override
    public String toString() {
        return "DepartmentEmployeeCountDTO{" + "departmentName=" + departmentName + ", employeeCount=" + employeeCount + '}';
    }
    
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author andep
 */
public class DepartmentAttendanceDTO {

    private String departmentName;
    private double attendancePercentage;

    public DepartmentAttendanceDTO() {
    }

    public DepartmentAttendanceDTO(String departmentName, double attendancePercentage) {
        this.departmentName = departmentName;
        this.attendancePercentage = attendancePercentage;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public double getAttendancePercentage() {
        return attendancePercentage;
    }

    public void setAttendancePercentage(double attendancePercentage) {
        this.attendancePercentage = attendancePercentage;
    }

    @Override
    public String toString() {
        return "DepartmentAttendanceDTO{" + "departmentName=" + departmentName + ", attendancePercentage=" + attendancePercentage + '}';
    }

}

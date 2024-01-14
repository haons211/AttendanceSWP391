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
public class attendance {

    int attendance_id;
    int employee_id;
    Date in_time;
    Date out_time;
    String notes;
    String image;
    String status;
    String in_status;
    String out_status;
    int remainDay_id;
    int department_id;

    public attendance() {
    }

    public attendance(int attendance_id, int employee_id, Date in_time, Date out_time, String notes, String image, String status, String in_status, String out_status, int remainDay_id, int department_id) {
        this.attendance_id = attendance_id;
        this.employee_id = employee_id;
        this.in_time = in_time;
        this.out_time = out_time;
        this.notes = notes;
        this.image = image;
        this.status = status;
        this.in_status = in_status;
        this.out_status = out_status;
        this.remainDay_id = remainDay_id;
        this.department_id = department_id;
    }

    public int getAttendance_id() {
        return attendance_id;
    }

    public void setAttendance_id(int attendance_id) {
        this.attendance_id = attendance_id;
    }

    public int getEmployee_id() {
        return employee_id;
    }

    public void setEmployee_id(int employee_id) {
        this.employee_id = employee_id;
    }

    public Date getIn_time() {
        return in_time;
    }

    public void setIn_time(Date in_time) {
        this.in_time = in_time;
    }

    public Date getOut_time() {
        return out_time;
    }

    public void setOut_time(Date out_time) {
        this.out_time = out_time;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getIn_status() {
        return in_status;
    }

    public void setIn_status(String in_status) {
        this.in_status = in_status;
    }

    public String getOut_status() {
        return out_status;
    }

    public void setOut_status(String out_status) {
        this.out_status = out_status;
    }

    public int getRemainDay_id() {
        return remainDay_id;
    }

    public void setRemainDay_id(int remainDay_id) {
        this.remainDay_id = remainDay_id;
    }

    public int getDepartment_id() {
        return department_id;
    }

    public void setDepartment_id(int department_id) {
        this.department_id = department_id;
    }

    @Override
    public String toString() {
        return "Attendance{" + "attendance_id=" + attendance_id + ", employee_id=" + employee_id + ", in_time=" + in_time + ", out_time=" + out_time + ", notes=" + notes + ", image=" + image + ", status=" + status + ", in_status=" + in_status + ", out_status=" + out_status + ", remainDay_id=" + remainDay_id + ", department_id=" + department_id + '}';
    }
    
}

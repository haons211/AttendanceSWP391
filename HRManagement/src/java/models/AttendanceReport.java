/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.util.Date;

/**
 *
 * @author ThuyVy
 */
public class AttendanceReport {

    int attendance_id;
    String em_name;
    String dep_name;
    Date date;
    String status;
    String notes;
    String in_time;
    String in_status;
    String out_time;
    String out_status;
    int remainDay;
    int approvedLeaveDays;

    public AttendanceReport() {
    }

    public AttendanceReport(int attendance_id, String em_name, String dep_name, Date date, String status, String notes, String in_time, String in_status, String out_time, String out_status, int remainDay, int approvedLeaveDays) {
        this.attendance_id = attendance_id;
        this.em_name = em_name;
        this.dep_name = dep_name;
        this.date = date;
        this.status = status;
        this.notes = notes;
        this.in_time = in_time;
        this.in_status = in_status;
        this.out_time = out_time;
        this.out_status = out_status;
        this.remainDay = remainDay;
        this.approvedLeaveDays = approvedLeaveDays;
    }

    public AttendanceReport(int attendance_id, String em_name, String dep_name, Date date, String status, String notes, String in_time, String in_status, String out_time, String out_status, int remainDay) {
        this.attendance_id = attendance_id;
        this.em_name = em_name;
        this.dep_name = dep_name;
        this.date = date;
        this.status = status;
        this.notes = notes;
        this.in_time = in_time;
        this.in_status = in_status;
        this.out_time = out_time;
        this.out_status = out_status;
        this.remainDay = remainDay;
    }

    public int getAttendance_id() {
        return attendance_id;
    }

    public void setAttendance_id(int attendance_id) {
        this.attendance_id = attendance_id;
    }

    public String getEm_name() {
        return em_name;
    }

    public void setEm_name(String em_name) {
        this.em_name = em_name;
    }

    public String getDep_name() {
        return dep_name;
    }

    public void setDep_name(String dep_name) {
        this.dep_name = dep_name;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getIn_time() {
        return in_time;
    }

    public void setIn_time(String in_time) {
        this.in_time = in_time;
    }

    public String getIn_status() {
        return in_status;
    }

    public void setIn_status(String in_status) {
        this.in_status = in_status;
    }

    public String getOut_time() {
        return out_time;
    }

    public void setOut_time(String out_time) {
        this.out_time = out_time;
    }

    public String getOut_status() {
        return out_status;
    }

    public void setOut_status(String out_status) {
        this.out_status = out_status;
    }

    public int getRemainDay() {
        return remainDay;
    }

    public void setRemainDay(int remainDay) {
        this.remainDay = remainDay;
    }

    public int getApprovedLeaveDays() {
        return approvedLeaveDays;
    }

    public void setApprovedLeaveDays(int approvedLeaveDays) {
        this.approvedLeaveDays = approvedLeaveDays;
    }

    @Override
    public String toString() {
        return "AttendanceReport{" + "attendance_id=" + attendance_id + ", em_name=" + em_name + ", dep_name=" + dep_name + ", date=" + date + ", status=" + status + ", notes=" + notes + ", in_time=" + in_time + ", in_status=" + in_status + ", out_time=" + out_time + ", out_status=" + out_status + ", remainDay=" + remainDay + '}';
    }

}

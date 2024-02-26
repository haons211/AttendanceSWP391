/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.io.InputStream;
import java.sql.Timestamp;
import java.util.Date;

/**
 *
 * @author NCM
 */
public class Notification {

    private int notificationId;
    private int employeeid;
    private String description;
    private String subject;
    private Timestamp sendTime;
    private InputStream inputStream;

    public Notification(int notificationId, int employeeid, String description, String subject, Timestamp sendTime, InputStream inputStream) {
        this.notificationId = notificationId;
        this.employeeid = employeeid;
        this.description = description;
        this.subject = subject;
        this.sendTime = sendTime;
        this.inputStream = inputStream;
    }

    public int getNotificationId() {
        return notificationId;
    }

    public void setNotificationId(int notificationId) {
        this.notificationId = notificationId;
    }

    public int getEmployeeid() {
        return employeeid;
    }

    public void setEmployeeid(int employeeid) {
        this.employeeid = employeeid;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public Date getSendTime() {
        return sendTime;
    }

    public void setSendTime(Timestamp sendTime) {
        this.sendTime = sendTime;
    }

    public InputStream getInputStream() {
        return inputStream;
    }

    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }

}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.util.Date;

/**
 *
 * @author NCM
 */
public class Task {

    int taskId;
    int employee_id;
    int MaId;
    String EName;
    String taskName;
    String description;
    Date dateStart;
    Date dateEnd;
    int lol;

    public Task() {
    }

    public Task(int taskId, int employee_id, int MaId, String EName, String taskName, String description, Date dateStart, Date dateEnd, int lol) {
        this.taskId = taskId;
        this.employee_id = employee_id;
        this.MaId = MaId;
        this.EName = EName;
        this.taskName = taskName;
        this.description = description;
        this.dateStart = dateStart;
        this.dateEnd = dateEnd;
        this.lol = lol;
    }

    public int getTaskId() {
        return taskId;
    }

    public void setTaskId(int taskId) {
        this.taskId = taskId;
    }

    public int getEmployee_id() {
        return employee_id;
    }

    public void setEmployee_id(int employee_id) {
        this.employee_id = employee_id;
    }

    public int getMaId() {
        return MaId;
    }

    public void setMaId(int MaId) {
        this.MaId = MaId;
    }

    public String getEName() {
        return EName;
    }

    public void setEName(String EName) {
        this.EName = EName;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDateStart() {
        return dateStart;
    }

    public void setDateStart(Date dateStart) {
        this.dateStart = dateStart;
    }

    public Date getDateEnd() {
        return dateEnd;
    }

    public void setDateEnd(Date dateEnd) {
        this.dateEnd = dateEnd;
    }

    public int getLol() {
        return lol;
    }

    public void setLol(int lol) {
        this.lol = lol;
    }

}

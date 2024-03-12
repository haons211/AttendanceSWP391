/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Timestamp;
import java.util.Date;

/**
 *
 * @author NCM
 */
public class Project {
    private int projectId;
    private int employee_id_created;
    private String projectName;
       private String description;
    private Date dateStart;
     private Date dateEnd;
     private int lol;

    public Project(int projectId, int employee_id_created, String projectName, String description, Date dateStart, Date dateEnd, int lol) {
        this.projectId = projectId;
        this.employee_id_created = employee_id_created;
        this.projectName = projectName;
        this.description = description;
        this.dateStart = dateStart;
        this.dateEnd = dateEnd;
        this.lol = lol;
    }

    public int getProjectId() {
        return projectId;
    }

    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    public int getEmployee_id_created() {
        return employee_id_created;
    }

    public void setEmployee_id_created(int employee_id_created) {
        this.employee_id_created = employee_id_created;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
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

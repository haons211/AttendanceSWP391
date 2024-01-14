/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author andep
 */
public class department {
    int department_id;
    String name;

    public department() {
    }

    public department(int department_id, String name) {
        this.department_id = department_id;
        this.name = name;
    }

    public int getDepartment_id() {
        return department_id;
    }

    public void setDepartment_id(int department_id) {
        this.department_id = department_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Departments{" + "department_id=" + department_id + ", name=" + name + '}';
    }
    
    
}

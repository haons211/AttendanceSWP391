/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author andep
 */
public class Department {

    int department_id;
    String name;
    String dep_code;

    public Department() {
    }

    public Department(int department_id, String name, String dep_code) {
        this.department_id = department_id;
        this.name = name;
        this.dep_code = dep_code;
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

    public String getDep_code() {
        return dep_code;
    }

    public void setDep_code(String dep_code) {
        this.dep_code = dep_code;
    }

    @Override
    public String toString() {
        return "Department{" + "department_id=" + department_id + ", name=" + name + ", dep_code=" + dep_code + '}';
    }

    
}

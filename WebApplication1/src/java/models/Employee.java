/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 *
 * @author Dan
 */
//     employee_id INT NOT NULL AUTO_INCREMENT,
//  name VARCHAR(50) NOT NULL,
//  phoneNumber VARCHAR(15),
//  address VARCHAR(255),
//  email VARCHAR(128) NOT NULL,
//  gender BIT NOT NULL,
//  image VARCHAR(128) NOT NULL,
//  birth_date DATE NOT NULL,
//  hire_date DATE NOT NULL,
//  user_id INT,
//  PRIMARY KEY (employee_id),
//  FOREIGN KEY (user_id) REFERENCES users (user_id)
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Employee {

    private int employeeId;
    private String name;
    private String phoneNumber;
    private String address;
    private String email;
    private boolean gender;
    private String image;
    private String birthDate;
    private String hireDate;
    private int userId;
    public String isGender() {
        if(gender == true){
            return "female";
        }
        return "male";
    }
}

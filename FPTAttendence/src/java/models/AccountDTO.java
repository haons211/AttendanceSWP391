/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author NCM
 */
public class AccountDTO {

    private int UserID;
    private String UserName;
    private String PassWord;
    private int Role;

    public AccountDTO() {
    }

    public AccountDTO(int UserID, String UserName, String PassWord, int Role) {
        this.UserID = UserID;
        this.UserName = UserName;
        this.PassWord = PassWord;
        this.Role = Role;
    }

    public int getUserID() {
        return UserID;
    }

    public void setUserID(int UserID) {
        this.UserID = UserID;
    }

    public String getUserName() {
        return UserName;
    }

    public void setUserName(String UserName) {
        this.UserName = UserName;
    }

    public String getPassWord() {
        return PassWord;
    }

    public void setPassWord(String PassWord) {
        this.PassWord = PassWord;
    }

    public int getRole() {
        return Role;
    }

    public void setRole(int Role) {
        this.Role = Role;
    }

    @Override
    public String toString() {
        return "AccountDTO{" + "UserID=" + UserID + ", UserName=" + UserName + ", PassWord=" + PassWord + ", Role=" + Role + '}';
    }

}

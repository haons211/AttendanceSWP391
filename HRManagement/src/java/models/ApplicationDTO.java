/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.util.Date;

/**
 * @author Admin
 */
public class ApplicationDTO {
    private int application_id;
    private String type_name;
    private String title;
    private String sender_name;
    private String receiver_name;
    private Date create_date;
    private String status;
    private String content;
    private String file;
    private Date complete_date;

    public ApplicationDTO() {
    }

    public ApplicationDTO(int application_id, String type_name, String title, Date create_date, String status, String content, String file, Date complete_date) {
        this.application_id = application_id;
        this.type_name = type_name;
        this.title = title;
        this.create_date = create_date;
        this.status = status;
        this.content = content;
        this.file = file;
        this.complete_date = complete_date;
    }

    public ApplicationDTO(int application_id, String type_name, String title, String sender_name, String receiver_name, Date create_date, String status, String content, String file, Date complete_date) {
        this.application_id = application_id;
        this.type_name = type_name;
        this.title = title;
        this.sender_name = sender_name;
        this.receiver_name = receiver_name;
        this.create_date = create_date;
        this.status = status;
        this.content = content;
        this.file = file;
        this.complete_date = complete_date;
    }

    public String getSender_name() {
        return sender_name;
    }

    public void setSender_name(String sender_name) {
        this.sender_name = sender_name;
    }

    public String getReceiver_name() {
        return receiver_name;
    }

    public void setReceiver_name(String receiver_name) {
        this.receiver_name = receiver_name;
    }

    public int getApplication_id() {
        return application_id;
    }

    public void setApplication_id(int application_id) {
        this.application_id = application_id;
    }

    public String getType_name() {
        return type_name;
    }

    public void setType_name(String type_name) {
        this.type_name = type_name;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getCreate_date() {
        return create_date;
    }

    public void setCreate_date(Date create_date) {
        this.create_date = create_date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getFile() {
        return file;
    }

    public void setFile(String file) {
        this.file = file;
    }

    public Date getComplete_date() {
        return complete_date;
    }

    public void setComplete_date(Date complete_date) {
        this.complete_date = complete_date;
    }
}

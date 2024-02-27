/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.util.Date;

/**
 * @author Admin
 */
public class Application {
    private int application_id;
    private int sender_id;
    private int type_id;
    private int receiver_id;
    private String file;
    private String title;
    private String content;
    private String status;
    private Date create_date;
    private Date complete_date;
    private String replyContent;

    public Application() {
    }

    public Application(int application_id, int sender_id, int type_id, int receiver_id, String file, String title, String content, String status, Date create_date, Date complete_date) {
        this.application_id = application_id;
        this.sender_id = sender_id;
        this.type_id = type_id;
        this.receiver_id = receiver_id;
        this.file = file;
        this.title = title;
        this.content = content;
        this.status = status;
        this.create_date = create_date;
        this.complete_date = complete_date;
    }

    public Application(int application_id, int sender_id, int type_id, int receiver_id, String file, String title, String content, String status, Date create_date, Date complete_date, String replyContent) {
        this.application_id = application_id;
        this.sender_id = sender_id;
        this.type_id = type_id;
        this.receiver_id = receiver_id;
        this.file = file;
        this.title = title;
        this.content = content;
        this.status = status;
        this.create_date = create_date;
        this.complete_date = complete_date;
        this.replyContent = replyContent;
    }

    public String getReplyContent() {
        return replyContent;
    }

    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    public int getApplication_id() {
        return application_id;
    }

    public void setApplication_id(int application_id) {
        this.application_id = application_id;
    }

    public int getSender_id() {
        return sender_id;
    }

    public void setSender_id(int sender_id) {
        this.sender_id = sender_id;
    }

    public int getType_id() {
        return type_id;
    }

    public void setType_id(int type_id) {
        this.type_id = type_id;
    }

    public int getReceiver_id() {
        return receiver_id;
    }

    public void setReceiver_id(int receiver_id) {
        this.receiver_id = receiver_id;
    }

    public String getFile() {
        return file;
    }

    public void setFile(String file) {
        this.file = file;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreate_date() {
        return create_date;
    }

    public void setCreate_date(Date create_date) {
        this.create_date = create_date;
    }

    public Date getComplete_date() {
        return complete_date;
    }

    public void setComplete_date(Date complete_date) {
        this.complete_date = complete_date;
    }


}

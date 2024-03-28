/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import dal.ConversationDAO;
import java.util.Date;

/**
 *
 * @author Admin
 */
public class MessageJson {

    int sender_id;
    String content;
    long timestamp;
    String sender_name;
    String sender_image;

    public MessageJson() {
    }

    public MessageJson(int sender_id, String content, long timestamp, String sender_name) {
        this.sender_id = sender_id;
        this.content = content;
        this.timestamp = timestamp;
        this.sender_name = sender_name;
    }

    public String getSender_image() {
        return sender_image;
    }

    public void setSender_image(String sender_image) {
        this.sender_image = sender_image;
    }

    public MessageJson(int sender_id, String content, long timestamp, String sender_name, String sender_image) {
        this.sender_id = sender_id;
        this.content = content;
        this.timestamp = timestamp;
        this.sender_name = sender_name;
        this.sender_image = sender_image;
    }

    public int getSender_id() {
        return sender_id;
    }

    public void setSender_id(int sender_id) {
        this.sender_id = sender_id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(long timestamp) {
        this.timestamp = timestamp;
    }

    public String getSender_name() {
        return sender_name;
    }

    public void setSender_name(int sender_id) {
        ConversationDAO cd = new ConversationDAO();
        String name = cd.getNameByEmployeeId(sender_id);
        this.sender_name = name;
    }

}

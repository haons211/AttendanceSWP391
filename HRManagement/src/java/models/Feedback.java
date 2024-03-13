/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Dan
 */
public class Feedback {
    private int feedbackId;
    private int userId;
    private String title;
    private String content;
    private String feedbackDate;

    public int getFeedbackId() {
        return feedbackId;
    }

    public Feedback(String title) {
        this.title = title;
    }

    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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

    public String getFeedbackDate() {
        return feedbackDate;
    }

    public void setFeedbackDate(String feedbackDate) {
        this.feedbackDate = feedbackDate;
    }

    public Feedback() {
    }

    public Feedback(int feedbackId, int userId, String title, String content, String feedbackDate) {
        this.feedbackId = feedbackId;
        this.userId = userId;
        this.title = title;
        this.content = content;
        this.feedbackDate = feedbackDate;
    }

    public Feedback(int userId, String title, String content, String feedbackDate) {
        this.userId = userId;
        this.title = title;
        this.content = content;
        this.feedbackDate = feedbackDate;
    }
    
    
}

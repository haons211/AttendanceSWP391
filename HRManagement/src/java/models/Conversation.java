/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Admin
 */
public class Conversation {
    private int conversation_id;
    private String name;
    private int typeConversationId;

    public Conversation() {
    }

    public Conversation(int conversation_id, String name, int typeConversationId) {
        this.conversation_id = conversation_id;
        this.name = name;
        this.typeConversationId = typeConversationId;
    }

    public Conversation(String name, int typeConversationId) {
        this.name = name;
        this.typeConversationId = typeConversationId;
    }

    public int getConversation_id() {
        return conversation_id;
    }

    public void setConversation_id(int conversation_id) {
        this.conversation_id = conversation_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getTypeConversationId() {
        return typeConversationId;
    }

    public void setTypeConversationId(int typeConversationId) {
        this.typeConversationId = typeConversationId;
    }
}

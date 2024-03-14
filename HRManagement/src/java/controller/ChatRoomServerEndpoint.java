package controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import dal.ConversationDAO;
import jakarta.websocket.EncodeException;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Message;
import models.MessageDTO;
import models.MessageJson;

@ServerEndpoint(value = "/chatRoomServer", encoders = {MessageJsonEncoder.class})
public class ChatRoomServerEndpoint {
    static Set<Session> users = Collections.synchronizedSet(new HashSet<>());

    @OnOpen
    public void handleOpen(Session session) {
        users.add(session);
    }

    @OnMessage
    public void handleMessage(String json, Session userSession) throws IOException, EncodeException {
        try {
            if (userSession != null) {
                Gson gson = new Gson();
                MessageJson message = gson.fromJson(json, MessageJson.class);
                Integer userId = (Integer) userSession.getUserProperties().get("userId");
                if (userId == null) {
                    userId = message.getSender_id();
                    userSession.getUserProperties().put("userId", userId);
                }
                ConversationDAO cd = new ConversationDAO();
                cd.insertMessage(userId, message.getContent());
                MessageJsonEncoder encoder = new MessageJsonEncoder();
//                String encodedMessage = encoder.encode(message);
                for (Session session : users) {
                    if (session.isOpen()) {
                        session.getBasicRemote().sendObject(message);
                    }
                }
            }
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }

    @OnClose
    public void handleClose(Session session) {
        users.remove(session);
    }

    @OnError
    public void handleError(Throwable t) {
        t.printStackTrace();
    }
}
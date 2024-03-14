package controller;

import com.google.gson.Gson;
import jakarta.websocket.EncodeException;
import jakarta.websocket.Encoder;
import jakarta.websocket.EndpointConfig;
import models.MessageJson;

public class MessageJsonEncoder implements Encoder.Text<MessageJson> {
    private final Gson gson = new Gson(); // Sử dụng final và đặt là biến instance

    @Override
    public String encode(MessageJson messageJson) throws EncodeException {
        return gson.toJson(messageJson); // Chuyển đối tượng thành chuỗi JSON
    }

    @Override
    public void init(EndpointConfig config) {
        // Không cần thực hiện bất kỳ hành động cụ thể nào trong phương thức này.
    }

    @Override
    public void destroy() {
        // Không cần thực hiện bất kỳ hành động cụ thể nào trong phương thức này.
    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package configs;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 *
 * @author Dan
 */
public class PasswordEncryption {
    public  String hashPasswordMD5(String password) {
        // Tạo đối tượng MessageDigest với thuật toán MD5
        MessageDigest md;
        StringBuilder hexString = new StringBuilder();
        try {
            md = MessageDigest.getInstance("MD5");
            md.update(password.getBytes());
            // Nhận giá trị băm dưới dạng mảng byte
            byte[] mdBytes = md.digest();
            // Chuyển đổi mảng byte thành chuỗi hex
            for (byte mdByte : mdBytes) {
                hexString.append(String.format("%02x", mdByte));
            }
        } catch (NoSuchAlgorithmException ex) {
            
        }
        // Cập nhật dữ liệu đầu vào
        return hexString.toString();
    }
  
}

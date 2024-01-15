
package dal;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;


public class DBContext1 {
   
 private static final String DB_NAME="swp";
    
    public Connection connection;

    public DBContext1() {
        try {
            //Change the username password and url to connect your own database
            String username = "root";
            String password = "An@20042003";
            String url = "jdbc:mysql://localhost:3306/"+ DB_NAME;
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext1.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void main(String[] args) {
        try {
            System.out.println(new DBContext1().connection);
        } catch (Exception e) {
        }
    }
}
 
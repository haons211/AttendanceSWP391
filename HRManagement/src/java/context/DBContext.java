package context;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {

    private static final String DB_NAME = "swp";

    public static Connection getConnection() throws ClassNotFoundException, SQLException {

        Connection conn = null;

        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/" + DB_NAME;
<<<<<<< HEAD
        conn = DriverManager.getConnection(url, "root", "123456");
=======
        conn = DriverManager.getConnection(url, "root", "1111");
>>>>>>> 616b00fc44c3b814b47152c782a8947b501639ec
        return conn;
    }
}

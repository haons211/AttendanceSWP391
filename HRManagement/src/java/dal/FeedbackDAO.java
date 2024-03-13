/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.Feedback;

/**
 *
 * @author Dan
 */
public class FeedbackDAO {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public void addFeedback(
            Feedback feedback
    ) throws SQLException {
        String query = "INSERT INTO Feedback (user_id, title, "
                + "content, feedback_date) VALUES (?, ?, ?, ?)";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, feedback.getUserId());

            ps.setString(2, feedback.getTitle());
            ps.setString(3, feedback.getContent());
            ps.setString(4, feedback.getFeedbackDate());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }

    }

    public List<Feedback> getAllFeedbacks(String search, int id) throws ClassNotFoundException {
        List<Feedback> list = new ArrayList<>();

        String query = "SELECT * FROM Feedback where title like ? and user_id = ? ";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, "%" + search + "%");
            ps.setInt(2, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                Feedback feedback = new Feedback(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5)
                );
                list.add(feedback);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
        return list;
    }
    
    public List<Feedback> getAllFeedbacks(String search) throws ClassNotFoundException {
        List<Feedback> list = new ArrayList<>();

        String query = "SELECT * FROM Feedback where title like ? ";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, "%" + search + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                Feedback feedback = new Feedback(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5)
                );
                list.add(feedback);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
        return list;
    }
    
    public List<Feedback> getAllTitles(String search, int id) throws ClassNotFoundException {
        List<Feedback> list = new ArrayList<>();

        String query = "SELECT DISTINCT title FROM Feedback where title like ? and user_id = ? ";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, "%" + search + "%");
            ps.setInt(2, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                Feedback feedback = new Feedback(
                      
                      
                        rs.getString(1)
                );
                list.add(feedback);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
        return list;
    }
    
     

    public void updateFeedback(Feedback feedback, int id) throws SQLException {
        String query = "UPDATE Feedback SET user_id = ?, title = ?, content = ?, feedback_date = ? WHERE feedback_id = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, feedback.getUserId());

            ps.setString(2, feedback.getTitle());
            ps.setString(3, feedback.getContent());
            ps.setString(4, feedback.getFeedbackDate());
            ps.setInt(5, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }

    }

    public void deleteFeedBack(int id) throws ClassNotFoundException {
        String query = "  DELETE FROM Feedback  WHERE feedback_id =?";
        try {       
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
    }

    public Feedback getFeedbackById(int id) throws ClassNotFoundException {
        String query = "SELECT * FROM Feedback WHERE feedback_id = ?";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                Feedback feedback = new Feedback(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5)
                );
                return feedback;

            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions if any
        } finally {
            // Close resources in a finally block
            closeResources();
        }
        return null;
    }

    private void closeResources() {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        FeedbackDAO dao = new FeedbackDAO();
      
        
        System.out.println(dao.getAllTitles("", 2));
        
        
    }
}

package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import models.department;

/**
 *
 * @author ThuyVy
 */
public class DepartmentDAO extends DBContext1 {

    public void DeleteDepartment(int id) {
        String sql = "  DELETE FROM department WHERE department_id =?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void UpdateDepartment(int id, String name) {
        String sql = "  UPDATE [department]  set [name]= ? "
                + "  where department_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void AddDeparment(int id, String name) {
        String sql = "insert into department (department_id,name) values (?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.setString(2, name);

            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public ArrayList<department> getAllDepartment(String search) {
        ArrayList<department> list = new ArrayList<>();
        String sql = "  select department_id, name  from department where name like ? order by department_id asc";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new department(rs.getInt("department_id"), rs.getString("name")));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public static void main(String[] args) {
        DepartmentDAO d = new DepartmentDAO();
        ArrayList<department> list = new ArrayList<>();
        list = d.getAllDepartment("");
//        for (Department product : list) {
//            System.out.println(product);
//        }
        d.AddDeparment(8, "fgh");
        for (department product : list) {
            System.out.println(product);
        }

    }

}

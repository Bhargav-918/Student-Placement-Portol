package org.example.placement.dao;

import org.example.placement.model.Student;
import org.example.placement.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {

    public boolean saveStudent(Student student) {

        String sql = """
                INSERT INTO students
                (user_id, roll_no, phone, branch, cgpa, graduation_year, resume)
                VALUES (?, ?, ?, ?, ?, ?, ?)
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, student.getUserId());
            statement.setString(2, student.getRollNo());
            statement.setString(3, student.getPhone());
            statement.setString(4, student.getBranch());
            statement.setDouble(5, student.getCgpa());
            statement.setInt(6, student.getGraduationYear());
            statement.setString(7, student.getResume());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    public Student getStudentByUserId(int userId) {

        String sql = """
                SELECT *
                FROM students
                WHERE user_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            ResultSet rs = statement.executeQuery();

            if (rs.next()) {

                Student student = new Student();

                student.setId(rs.getInt("id"));
                student.setUserId(rs.getInt("user_id"));
                student.setRollNo(rs.getString("roll_no"));
                student.setPhone(rs.getString("phone"));
                student.setBranch(rs.getString("branch"));
                student.setCgpa(rs.getDouble("cgpa"));
                student.setGraduationYear(
                        rs.getInt("graduation_year")
                );
                student.setResume(rs.getString("resume"));

                return student;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    public boolean updateStudent(Student student) {

        String sql = """
                UPDATE students
                SET roll_no = ?,
                    phone = ?,
                    branch = ?,
                    cgpa = ?,
                    graduation_year = ?,
                    resume = ?
                WHERE user_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, student.getRollNo());
            statement.setString(2, student.getPhone());
            statement.setString(3, student.getBranch());
            statement.setDouble(4, student.getCgpa());
            statement.setInt(5, student.getGraduationYear());
            statement.setString(6, student.getResume());
            statement.setInt(7, student.getUserId());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // Get all students for Admin Dashboard
    public List<Student> getAllStudents() {

        List<Student> students = new ArrayList<>();

        String sql = """
                SELECT
                    s.id,
                    s.user_id,
                    s.roll_no,
                    s.phone,
                    s.branch,
                    s.cgpa,
                    s.graduation_year,
                    s.resume
                FROM students s
                ORDER BY s.id DESC
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {

                Student student = new Student();

                student.setId(rs.getInt("id"));
                student.setUserId(rs.getInt("user_id"));
                student.setRollNo(rs.getString("roll_no"));
                student.setPhone(rs.getString("phone"));
                student.setBranch(rs.getString("branch"));
                student.setCgpa(rs.getDouble("cgpa"));
                student.setGraduationYear(
                        rs.getInt("graduation_year")
                );
                student.setResume(rs.getString("resume"));

                students.add(student);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return students;
    }
}
package org.example.placement.dao;

import org.example.placement.model.Application;
import org.example.placement.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ApplicationDAO {

    public boolean hasApplied(int studentId, int jobId) {

        String sql = """
                SELECT id
                FROM applications
                WHERE student_id = ?
                  AND job_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, studentId);
            statement.setInt(2, jobId);

            ResultSet rs = statement.executeQuery();

            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    public boolean applyForJob(int studentId, int jobId) {

        String sql = """
                INSERT INTO applications
                (student_id, job_id)
                VALUES (?, ?)
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, studentId);
            statement.setInt(2, jobId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    public List<Application> getApplicationsByStudent(int studentId) {

        List<Application> applications = new ArrayList<>();

        String sql = """
                SELECT
                    a.id,
                    a.student_id,
                    a.job_id,
                    c.company_name,
                    j.title,
                    a.applied_date,
                    a.status
                FROM applications a
                JOIN jobs j
                    ON a.job_id = j.id
                JOIN companies c
                    ON j.company_id = c.id
                WHERE a.student_id = ?
                ORDER BY a.applied_date DESC
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, studentId);

            ResultSet rs = statement.executeQuery();

            while (rs.next()) {

                Application application = new Application();

                application.setId(rs.getInt("id"));

                application.setStudentId(
                        rs.getInt("student_id")
                );

                application.setJobId(
                        rs.getInt("job_id")
                );

                application.setCompanyName(
                        rs.getString("company_name")
                );

                application.setJobTitle(
                        rs.getString("title")
                );

                application.setAppliedDate(
                        rs.getTimestamp("applied_date")
                );

                application.setStatus(
                        rs.getString("status")
                );

                applications.add(application);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return applications;
    }


    // =====================================================
    // GET APPLICATIONS FOR RECRUITER
    // =====================================================

    public List<Application> getApplicationsByRecruiter(int userId) {

        List<Application> applications = new ArrayList<>();

        String sql = """
                SELECT
                    a.id,
                    a.student_id,
                    a.job_id,
                    c.company_name,
                    j.title,
                    a.applied_date,
                    a.status
                FROM applications a
                JOIN jobs j
                    ON a.job_id = j.id
                JOIN companies c
                    ON j.company_id = c.id
                WHERE c.user_id = ?
                ORDER BY a.applied_date DESC
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            ResultSet rs = statement.executeQuery();

            while (rs.next()) {

                Application application = new Application();

                application.setId(
                        rs.getInt("id")
                );

                application.setStudentId(
                        rs.getInt("student_id")
                );

                application.setJobId(
                        rs.getInt("job_id")
                );

                application.setCompanyName(
                        rs.getString("company_name")
                );

                application.setJobTitle(
                        rs.getString("title")
                );

                application.setAppliedDate(
                        rs.getTimestamp("applied_date")
                );

                application.setStatus(
                        rs.getString("status")
                );

                applications.add(application);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return applications;
    }


    // =====================================================
    // UPDATE APPLICATION STATUS
    // =====================================================

    public boolean updateApplicationStatus(
            int applicationId,
            String status) {

        String sql = """
                UPDATE applications
                SET status = ?
                WHERE id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, status);
            statement.setInt(2, applicationId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    public List<Application> getAllApplications() {

        List<Application> applications = new ArrayList<>();

        String sql = """
            SELECT
                a.id,
                a.student_id,
                a.job_id,
                c.company_name,
                j.title,
                a.applied_date,
                a.status
            FROM applications a
            JOIN jobs j
                ON a.job_id = j.id
            JOIN companies c
                ON j.company_id = c.id
            ORDER BY a.applied_date DESC
            """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {

                Application application =
                        new Application();

                application.setId(
                        rs.getInt("id")
                );

                application.setStudentId(
                        rs.getInt("student_id")
                );

                application.setJobId(
                        rs.getInt("job_id")
                );

                application.setCompanyName(
                        rs.getString("company_name")
                );

                application.setJobTitle(
                        rs.getString("title")
                );

                application.setAppliedDate(
                        rs.getTimestamp("applied_date")
                );

                application.setStatus(
                        rs.getString("status")
                );

                applications.add(application);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return applications;
    }
}
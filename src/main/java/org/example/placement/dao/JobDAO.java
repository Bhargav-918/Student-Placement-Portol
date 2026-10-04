package org.example.placement.dao;

import org.example.placement.model.Job;
import org.example.placement.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class JobDAO {

    public List<Job> getOpenJobs() {

        List<Job> jobs = new ArrayList<>();

        String sql = """
                SELECT
                    j.id,
                    j.company_id,
                    c.company_name,
                    j.title,
                    j.description,
                    j.salary,
                    j.location,
                    j.min_cgpa,
                    j.eligible_branch,
                    j.graduation_year,
                    j.deadline,
                    j.status
                FROM jobs j
                JOIN companies c
                    ON j.company_id = c.id
                WHERE j.status = 'OPEN'
                ORDER BY j.created_at DESC
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {

                Job job = new Job();

                job.setId(rs.getInt("id"));
                job.setCompanyId(rs.getInt("company_id"));
                job.setCompanyName(
                        rs.getString("company_name")
                );
                job.setTitle(rs.getString("title"));
                job.setDescription(
                        rs.getString("description")
                );
                job.setSalary(rs.getString("salary"));
                job.setLocation(rs.getString("location"));
                job.setMinCgpa(rs.getDouble("min_cgpa"));
                job.setEligibleBranch(
                        rs.getString("eligible_branch")
                );
                job.setGraduationYear(
                        rs.getInt("graduation_year")
                );
                job.setDeadline(
                        rs.getDate("deadline")
                );
                job.setStatus(
                        rs.getString("status")
                );

                jobs.add(job);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return jobs;
    }


    public List<Job> getCompanyJobs(int userId) {

        List<Job> jobs = new ArrayList<>();

        String sql = """
                SELECT
                    j.id,
                    j.company_id,
                    c.company_name,
                    j.title,
                    j.description,
                    j.salary,
                    j.location,
                    j.min_cgpa,
                    j.eligible_branch,
                    j.graduation_year,
                    j.deadline,
                    j.status
                FROM jobs j
                JOIN companies c
                    ON j.company_id = c.id
                WHERE c.user_id = ?
                ORDER BY j.created_at DESC
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            ResultSet rs = statement.executeQuery();

            while (rs.next()) {

                Job job = new Job();

                job.setId(rs.getInt("id"));
                job.setCompanyId(rs.getInt("company_id"));
                job.setCompanyName(
                        rs.getString("company_name")
                );
                job.setTitle(rs.getString("title"));
                job.setDescription(
                        rs.getString("description")
                );
                job.setSalary(rs.getString("salary"));
                job.setLocation(rs.getString("location"));
                job.setMinCgpa(rs.getDouble("min_cgpa"));
                job.setEligibleBranch(
                        rs.getString("eligible_branch")
                );
                job.setGraduationYear(
                        rs.getInt("graduation_year")
                );
                job.setDeadline(
                        rs.getDate("deadline")
                );
                job.setStatus(
                        rs.getString("status")
                );

                jobs.add(job);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return jobs;
    }


    public boolean saveJob(Job job) {

        String sql = """
                INSERT INTO jobs
                (
                    company_id,
                    title,
                    description,
                    salary,
                    location,
                    min_cgpa,
                    eligible_branch,
                    graduation_year,
                    deadline,
                    status
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, job.getCompanyId());
            statement.setString(2, job.getTitle());
            statement.setString(3, job.getDescription());
            statement.setString(4, job.getSalary());
            statement.setString(5, job.getLocation());
            statement.setDouble(6, job.getMinCgpa());
            statement.setString(7, job.getEligibleBranch());
            statement.setInt(8, job.getGraduationYear());
            statement.setDate(9, job.getDeadline());
            statement.setString(10, job.getStatus());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    public Job getJobById(int jobId) {

        String sql = """
                SELECT
                    j.id,
                    j.company_id,
                    c.company_name,
                    j.title,
                    j.description,
                    j.salary,
                    j.location,
                    j.min_cgpa,
                    j.eligible_branch,
                    j.graduation_year,
                    j.deadline,
                    j.status
                FROM jobs j
                JOIN companies c
                    ON j.company_id = c.id
                WHERE j.id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, jobId);

            ResultSet rs = statement.executeQuery();

            if (rs.next()) {

                Job job = new Job();

                job.setId(rs.getInt("id"));
                job.setCompanyId(rs.getInt("company_id"));
                job.setCompanyName(
                        rs.getString("company_name")
                );
                job.setTitle(rs.getString("title"));
                job.setDescription(
                        rs.getString("description")
                );
                job.setSalary(rs.getString("salary"));
                job.setLocation(rs.getString("location"));
                job.setMinCgpa(rs.getDouble("min_cgpa"));
                job.setEligibleBranch(
                        rs.getString("eligible_branch")
                );
                job.setGraduationYear(
                        rs.getInt("graduation_year")
                );
                job.setDeadline(
                        rs.getDate("deadline")
                );
                job.setStatus(
                        rs.getString("status")
                );

                return job;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    public boolean updateJob(Job job) {

        String sql = """
                UPDATE jobs
                SET title = ?,
                    description = ?,
                    salary = ?,
                    location = ?,
                    min_cgpa = ?,
                    eligible_branch = ?,
                    graduation_year = ?,
                    deadline = ?
                WHERE id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, job.getTitle());
            statement.setString(2, job.getDescription());
            statement.setString(3, job.getSalary());
            statement.setString(4, job.getLocation());
            statement.setDouble(5, job.getMinCgpa());
            statement.setString(6, job.getEligibleBranch());
            statement.setInt(7, job.getGraduationYear());
            statement.setDate(8, job.getDeadline());
            statement.setInt(9, job.getId());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    public boolean closeJob(int jobId) {

        String sql = """
                UPDATE jobs
                SET status = 'CLOSED'
                WHERE id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, jobId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // Get all jobs for Admin Dashboard
    public List<Job> getAllJobs() {

        List<Job> jobs = new ArrayList<>();

        String sql = """
                SELECT
                    j.id,
                    j.company_id,
                    c.company_name,
                    j.title,
                    j.description,
                    j.salary,
                    j.location,
                    j.min_cgpa,
                    j.eligible_branch,
                    j.graduation_year,
                    j.deadline,
                    j.status
                FROM jobs j
                JOIN companies c
                    ON j.company_id = c.id
                ORDER BY j.created_at DESC
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {

                Job job = new Job();

                job.setId(rs.getInt("id"));
                job.setCompanyId(
                        rs.getInt("company_id")
                );
                job.setCompanyName(
                        rs.getString("company_name")
                );
                job.setTitle(
                        rs.getString("title")
                );
                job.setDescription(
                        rs.getString("description")
                );
                job.setSalary(
                        rs.getString("salary")
                );
                job.setLocation(
                        rs.getString("location")
                );
                job.setMinCgpa(
                        rs.getDouble("min_cgpa")
                );
                job.setEligibleBranch(
                        rs.getString("eligible_branch")
                );
                job.setGraduationYear(
                        rs.getInt("graduation_year")
                );
                job.setDeadline(
                        rs.getDate("deadline")
                );
                job.setStatus(
                        rs.getString("status")
                );

                jobs.add(job);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return jobs;
    }
}
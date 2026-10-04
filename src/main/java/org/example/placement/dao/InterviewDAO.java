package org.example.placement.dao;

import org.example.placement.model.Interview;
import org.example.placement.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class InterviewDAO {

    // =====================================================
    // GET INTERVIEWS FOR A RECRUITER
    // =====================================================

    public List<Interview> getInterviewsByRecruiter(int userId) {

        List<Interview> interviews = new ArrayList<>();

        String sql = """
                SELECT
                    i.id,
                    i.application_id,
                    i.interview_date,
                    i.mode,
                    i.meeting_link,
                    i.result,
                    u.name AS student_name,
                    j.title AS job_title,
                    c.company_name
                FROM interviews i
                JOIN applications a
                    ON i.application_id = a.id
                JOIN students s
                    ON a.student_id = s.id
                JOIN users u
                    ON s.user_id = u.id
                JOIN jobs j
                    ON a.job_id = j.id
                JOIN companies c
                    ON j.company_id = c.id
                WHERE c.user_id = ?
                ORDER BY i.interview_date DESC
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            ResultSet rs = statement.executeQuery();

            while (rs.next()) {

                Interview interview = new Interview();

                interview.setId(
                        rs.getInt("id")
                );

                interview.setApplicationId(
                        rs.getInt("application_id")
                );

                interview.setInterviewDate(
                        rs.getTimestamp("interview_date")
                );

                interview.setMode(
                        rs.getString("mode")
                );

                interview.setMeetingLink(
                        rs.getString("meeting_link")
                );

                interview.setResult(
                        rs.getString("result")
                );

                interview.setStudentName(
                        rs.getString("student_name")
                );

                interview.setJobTitle(
                        rs.getString("job_title")
                );

                interview.setCompanyName(
                        rs.getString("company_name")
                );

                interviews.add(interview);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return interviews;
    }


    // =====================================================
    // GET INTERVIEWS FOR A STUDENT
    // =====================================================

    public List<Interview> getInterviewsByStudent(int studentId) {

        List<Interview> interviews = new ArrayList<>();

        String sql = """
                SELECT
                    i.id,
                    i.application_id,
                    i.interview_date,
                    i.mode,
                    i.meeting_link,
                    i.result,
                    u.name AS student_name,
                    j.title AS job_title,
                    c.company_name
                FROM interviews i
                JOIN applications a
                    ON i.application_id = a.id
                JOIN students s
                    ON a.student_id = s.id
                JOIN users u
                    ON s.user_id = u.id
                JOIN jobs j
                    ON a.job_id = j.id
                JOIN companies c
                    ON j.company_id = c.id
                WHERE s.id = ?
                ORDER BY i.interview_date DESC
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, studentId);

            ResultSet rs = statement.executeQuery();

            while (rs.next()) {

                Interview interview = new Interview();

                interview.setId(
                        rs.getInt("id")
                );

                interview.setApplicationId(
                        rs.getInt("application_id")
                );

                interview.setInterviewDate(
                        rs.getTimestamp("interview_date")
                );

                interview.setMode(
                        rs.getString("mode")
                );

                interview.setMeetingLink(
                        rs.getString("meeting_link")
                );

                interview.setResult(
                        rs.getString("result")
                );

                interview.setStudentName(
                        rs.getString("student_name")
                );

                interview.setJobTitle(
                        rs.getString("job_title")
                );

                interview.setCompanyName(
                        rs.getString("company_name")
                );

                interviews.add(interview);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return interviews;
    }


    // =====================================================
    // SCHEDULE INTERVIEW
    // =====================================================

    public boolean scheduleInterview(
            int applicationId,
            Timestamp interviewDate,
            String mode,
            String meetingLink) {

        String sql = """
                INSERT INTO interviews
                (
                    application_id,
                    interview_date,
                    mode,
                    meeting_link,
                    result
                )
                VALUES (?, ?, ?, ?, 'PENDING')
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, applicationId);
            statement.setTimestamp(2, interviewDate);
            statement.setString(3, mode);
            statement.setString(4, meetingLink);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    // =====================================================
    // UPDATE INTERVIEW RESULT
    // =====================================================

    public boolean updateInterviewResult(
            int interviewId,
            String result) {

        String sql = """
                UPDATE interviews
                SET result = ?
                WHERE id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, result);
            statement.setInt(2, interviewId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }
}
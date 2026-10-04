package org.example.placement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.example.placement.util.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/admin/statistics")
public class AdminStatisticsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // Check login
        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/login.jsp"
            );
            return;
        }

        // Check admin role
        if (!"ADMIN".equals(
                session.getAttribute("userRole"))) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/login.jsp"
            );
            return;
        }

        int totalStudents = getCount(
                "SELECT COUNT(*) FROM students"
        );

        int totalRecruiters = getCount(
                "SELECT COUNT(*) FROM companies"
        );

        int totalJobs = getCount(
                "SELECT COUNT(*) FROM jobs"
        );

        int totalApplications = getCount(
                "SELECT COUNT(*) FROM applications"
        );

        int shortlistedApplications = getCount(
                "SELECT COUNT(*) FROM applications WHERE status = 'SHORTLISTED'"
        );

        int selectedApplications = getCount(
                "SELECT COUNT(*) FROM applications WHERE status = 'SELECTED'"
        );

        int rejectedApplications = getCount(
                "SELECT COUNT(*) FROM applications WHERE status = 'REJECTED'"
        );

        int totalInterviews = getCount(
                "SELECT COUNT(*) FROM interviews"
        );

        request.setAttribute(
                "totalStudents",
                totalStudents
        );

        request.setAttribute(
                "totalRecruiters",
                totalRecruiters
        );

        request.setAttribute(
                "totalJobs",
                totalJobs
        );

        request.setAttribute(
                "totalApplications",
                totalApplications
        );

        request.setAttribute(
                "shortlistedApplications",
                shortlistedApplications
        );

        request.setAttribute(
                "selectedApplications",
                selectedApplications
        );

        request.setAttribute(
                "rejectedApplications",
                rejectedApplications
        );

        request.setAttribute(
                "totalInterviews",
                totalInterviews
        );

        request.getRequestDispatcher(
                "/admin/statistics.jsp"
        ).forward(request, response);
    }

    private int getCount(String sql) {

        try (Connection connection =
                     DBConnection.getConnection();

             PreparedStatement statement =
                     connection.prepareStatement(sql);

             ResultSet rs =
                     statement.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}
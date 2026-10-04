package org.example.placement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.example.placement.dao.JobDAO;
import org.example.placement.model.Job;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/jobs")
public class AdminJobServlet extends HttpServlet {

    private final JobDAO jobDAO = new JobDAO();

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

        // Check ADMIN role
        if (!"ADMIN".equals(
                session.getAttribute("userRole"))) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/login.jsp"
            );
            return;
        }

        // Get all jobs
        List<Job> jobs =
                jobDAO.getAllJobs();

        request.setAttribute(
                "jobs",
                jobs
        );

        // Open admin jobs page
        request.getRequestDispatcher(
                "/admin/jobs.jsp"
        ).forward(request, response);
    }
}
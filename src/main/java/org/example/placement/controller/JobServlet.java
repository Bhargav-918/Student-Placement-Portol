package org.example.placement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.example.placement.dao.JobDAO;
import org.example.placement.dao.StudentDAO;
import org.example.placement.model.Job;
import org.example.placement.model.Student;

import java.io.IOException;
import java.util.List;

@WebServlet("/student/jobs")
public class JobServlet extends HttpServlet {

    private final JobDAO jobDAO = new JobDAO();
    private final StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        int userId =
                (Integer) session.getAttribute("userId");

        Student student =
                studentDAO.getStudentByUserId(userId);

        List<Job> jobs =
                jobDAO.getOpenJobs();

        request.setAttribute("jobs", jobs);
        request.setAttribute("student", student);

        request.getRequestDispatcher(
                "/student/jobs.jsp"
        ).forward(request, response);
    }
}
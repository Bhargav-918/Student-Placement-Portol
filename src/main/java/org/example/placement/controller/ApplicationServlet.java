package org.example.placement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.example.placement.dao.ApplicationDAO;
import org.example.placement.model.Application;

import java.io.IOException;
import java.util.List;

@WebServlet("/student/applications")
public class ApplicationServlet extends HttpServlet {

    private final ApplicationDAO applicationDAO =
            new ApplicationDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        int userId =
                (Integer) session.getAttribute("userId");

        /*
         * The applications table stores student_id,
         * not user_id.
         *
         * Get the student record first.
         */

        org.example.placement.dao.StudentDAO studentDAO =
                new org.example.placement.dao.StudentDAO();

        org.example.placement.model.Student student =
                studentDAO.getStudentByUserId(userId);

        if (student == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/student/profile?error=Please+complete+your+profile+first"
            );

            return;
        }

        int studentId = student.getId();

        List<Application> applications =
                applicationDAO.getApplicationsByStudent(studentId);

        request.setAttribute(
                "applications",
                applications
        );

        request.getRequestDispatcher(
                "/student/applications.jsp"
        ).forward(request, response);
    }
}

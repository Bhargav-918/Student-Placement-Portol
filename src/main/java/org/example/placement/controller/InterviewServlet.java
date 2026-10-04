package org.example.placement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.example.placement.dao.InterviewDAO;
import org.example.placement.dao.StudentDAO;
import org.example.placement.model.Interview;
import org.example.placement.model.Student;

import java.io.IOException;
import java.util.List;

@WebServlet("/student/interviews")
public class InterviewServlet extends HttpServlet {

    private final InterviewDAO interviewDAO =
            new InterviewDAO();

    private final StudentDAO studentDAO =
            new StudentDAO();


    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);


        // =====================================================
        // CHECK LOGIN
        // =====================================================

        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/login.jsp"
            );

            return;
        }


        // =====================================================
        // CHECK STUDENT ROLE
        // =====================================================

        if (!"STUDENT".equals(
                session.getAttribute("userRole"))) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/login.jsp"
            );

            return;
        }


        // =====================================================
        // GET LOGGED-IN USER
        // =====================================================

        int userId =
                (Integer) session.getAttribute("userId");


        // =====================================================
        // GET STUDENT PROFILE
        // =====================================================

        Student student =
                studentDAO.getStudentByUserId(userId);


        if (student == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/student/profile"
                            + "?error=Please+complete+your+profile+first"
            );

            return;
        }


        // =====================================================
        // GET INTERVIEWS
        // =====================================================

        int studentId =
                student.getId();

        List<Interview> interviews =
                interviewDAO.getInterviewsByStudent(
                        studentId
                );


        // =====================================================
        // SEND DATA TO JSP
        // =====================================================

        request.setAttribute(
                "interviews",
                interviews
        );


        // =====================================================
        // OPEN STUDENT INTERVIEW PAGE
        // =====================================================

        request.getRequestDispatcher(
                "/student/interview.jsp"
        ).forward(request, response);
    }
}
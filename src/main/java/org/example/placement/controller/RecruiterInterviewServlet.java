package org.example.placement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.example.placement.dao.InterviewDAO;
import org.example.placement.model.Interview;

import java.io.IOException;
import java.util.List;

@WebServlet("/recruiter/interviews")
public class RecruiterInterviewServlet extends HttpServlet {

    private final InterviewDAO interviewDAO =
            new InterviewDAO();


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
        // CHECK RECRUITER ROLE
        // =====================================================

        if (!"RECRUITER".equals(
                session.getAttribute("userRole"))) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/login.jsp"
            );

            return;
        }


        // =====================================================
        // GET LOGGED-IN RECRUITER
        // =====================================================

        int userId =
                (Integer) session.getAttribute("userId");


        // =====================================================
        // GET INTERVIEWS
        // =====================================================

        List<Interview> interviews =
                interviewDAO.getInterviewsByRecruiter(
                        userId
                );


        // =====================================================
        // SEND DATA TO JSP
        // =====================================================

        request.setAttribute(
                "interviews",
                interviews
        );


        // =====================================================
        // OPEN RECRUITER INTERVIEW PAGE
        // =====================================================

        request.getRequestDispatcher(
                "/recruiter/interviews.jsp"
        ).forward(request, response);
    }
}
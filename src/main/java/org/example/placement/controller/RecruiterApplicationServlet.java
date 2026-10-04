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

@WebServlet("/recruiter/applications")
public class RecruiterApplicationServlet extends HttpServlet {

    private final ApplicationDAO applicationDAO =
            new ApplicationDAO();

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

        // Check recruiter role
        if (!"RECRUITER".equals(
                session.getAttribute("userRole"))) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/login.jsp"
            );
            return;
        }

        // Get logged-in recruiter
        int userId =
                (Integer) session.getAttribute("userId");

        // Get applications for this recruiter's company
        List<Application> applications =
                applicationDAO.getApplicationsByRecruiter(
                        userId
                );

        // Send applications to JSP
        request.setAttribute(
                "applications",
                applications
        );

        // Use existing applicant.jsp
        request.getRequestDispatcher(
                "/recruiter/applicant.jsp"
        ).forward(request, response);
    }
}
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

@WebServlet("/admin/applications")
public class AdminApplicationServlet extends HttpServlet {

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

        // Check admin role
        if (!"ADMIN".equals(
                session.getAttribute("userRole"))) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/login.jsp"
            );
            return;
        }

        // Get all applications
        List<Application> applications =
                applicationDAO.getAllApplications();

        request.setAttribute(
                "applications",
                applications
        );

        // Open admin applications page
        request.getRequestDispatcher(
                "/admin/applications.jsp"
        ).forward(request, response);
    }
}
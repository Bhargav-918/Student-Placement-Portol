package org.example.placement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.example.placement.dao.CompanyDAO;
import org.example.placement.model.Company;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/recruiters")
public class AdminCompanyServlet extends HttpServlet {

    private final CompanyDAO companyDAO =
            new CompanyDAO();

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

        // Get all companies
        List<Company> companies =
                companyDAO.getAllCompanies();

        request.setAttribute(
                "companies",
                companies
        );

        // Open admin recruiters page
        request.getRequestDispatcher(
                "/admin/recruiters.jsp"
        ).forward(request, response);
    }
}
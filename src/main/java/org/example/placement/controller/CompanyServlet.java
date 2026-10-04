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

@WebServlet("/recruiter/profile")
public class CompanyServlet extends HttpServlet {

    private final CompanyDAO companyDAO = new CompanyDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        String role =
                (String) session.getAttribute("userRole");

        if (!"RECRUITER".equals(role)) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        int userId =
                (Integer) session.getAttribute("userId");

        Company company =
                companyDAO.getCompanyByUserId(userId);

        request.setAttribute("company", company);

        request.getRequestDispatcher(
                "/recruiter/profile.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        String role =
                (String) session.getAttribute("userRole");

        if (!"RECRUITER".equals(role)) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        int userId =
                (Integer) session.getAttribute("userId");

        String companyName =
                request.getParameter("companyName");

        String description =
                request.getParameter("description");

        String website =
                request.getParameter("website");

        if (companyName == null ||
                companyName.isBlank()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/recruiter/profile.jsp?error=Company+name+is+required"
            );
            return;
        }

        Company company =
                companyDAO.getCompanyByUserId(userId);

        boolean success;

        if (company == null) {

            company = new Company(
                    userId,
                    companyName.trim(),
                    description,
                    website
            );

            success = companyDAO.saveCompany(company);

        } else {

            company.setCompanyName(companyName.trim());
            company.setDescription(description);
            company.setWebsite(website);

            success = companyDAO.updateCompany(company);
        }

        if (success) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/recruiter/profile?success=Company+profile+saved"
            );

        } else {

            response.sendRedirect(
                    request.getContextPath()
                            + "/recruiter/profile?error=Unable+to+save+company"
            );
        }
    }
}
package org.example.placement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.example.placement.dao.CompanyDAO;
import org.example.placement.dao.JobDAO;
import org.example.placement.model.Company;
import org.example.placement.model.Job;

import java.io.IOException;

@WebServlet("/recruiter/close-job")
public class CloseJobServlet extends HttpServlet {

    private final JobDAO jobDAO = new JobDAO();
    private final CompanyDAO companyDAO = new CompanyDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // -------------------------------------------------
        // Check login
        // -------------------------------------------------

        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }


        // -------------------------------------------------
        // Check recruiter role
        // -------------------------------------------------

        if (!"RECRUITER".equals(
                session.getAttribute("userRole"))) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }


        // -------------------------------------------------
        // Get job ID
        // -------------------------------------------------

        String idText =
                request.getParameter("id");

        if (idText == null ||
                idText.isBlank()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/recruiter/jobs"
            );
            return;
        }


        try {

            int jobId =
                    Integer.parseInt(idText);


            // -------------------------------------------------
            // Get logged-in recruiter
            // -------------------------------------------------

            int userId =
                    (Integer) session.getAttribute("userId");


            Company company =
                    companyDAO.getCompanyByUserId(userId);


            if (company == null) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/profile"
                );
                return;
            }


            // -------------------------------------------------
            // Get job
            // -------------------------------------------------

            Job job =
                    jobDAO.getJobById(jobId);


            if (job == null) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/jobs?error=Job+not+found"
                );
                return;
            }


            // -------------------------------------------------
            // SECURITY CHECK
            //
            // Make sure this job belongs to the
            // currently logged-in recruiter.
            // -------------------------------------------------

            if (job.getCompanyId()
                    != company.getId()) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/jobs?error=Unauthorized+job"
                );
                return;
            }


            // -------------------------------------------------
            // Check if already closed
            // -------------------------------------------------

            if ("CLOSED".equalsIgnoreCase(
                    job.getStatus())) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/jobs?error=Job+is+already+closed"
                );
                return;
            }


            // -------------------------------------------------
            // Close job
            // -------------------------------------------------

            boolean success =
                    jobDAO.closeJob(jobId);


            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/jobs?success=Job+closed+successfully"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/jobs?error=Unable+to+close+job"
                );
            }


        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/recruiter/jobs?error=Invalid+job+ID"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                            + "/recruiter/jobs?error=Something+went+wrong"
            );
        }
    }
}
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
import java.sql.Date;

@WebServlet("/recruiter/edit-job")
public class EditJobServlet extends HttpServlet {

    private final JobDAO jobDAO = new JobDAO();
    private final CompanyDAO companyDAO = new CompanyDAO();


    // =========================================================
    // GET - OPEN EDIT JOB PAGE
    // =========================================================

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
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        // Check recruiter role
        if (!"RECRUITER".equals(
                session.getAttribute("userRole"))) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        // Get job ID
        String idText =
                request.getParameter("id");

        if (idText == null || idText.isBlank()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/recruiter/jobs"
            );
            return;
        }

        try {

            int jobId =
                    Integer.parseInt(idText);

            // Get job
            Job job =
                    jobDAO.getJobById(jobId);

            if (job == null) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/jobs"
                );
                return;
            }

            // Get logged-in recruiter
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

            // Security check:
            // Make sure this job belongs to this recruiter
            if (job.getCompanyId() != company.getId()) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/jobs"
                );
                return;
            }

            // Send job to JSP
            request.setAttribute(
                    "job",
                    job
            );

            request.getRequestDispatcher(
                    "/recruiter/edit-job.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/recruiter/jobs"
            );
        }
    }


    // =========================================================
    // POST - SAVE UPDATED JOB
    // =========================================================

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session =
                request.getSession(false);

        // Check login
        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        // Check recruiter role
        if (!"RECRUITER".equals(
                session.getAttribute("userRole"))) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        String idText =
                request.getParameter("id");

        String title =
                request.getParameter("title");

        String description =
                request.getParameter("description");

        String salary =
                request.getParameter("salary");

        String location =
                request.getParameter("location");

        String minCgpaText =
                request.getParameter("minCgpa");

        String eligibleBranch =
                request.getParameter("eligibleBranch");

        String graduationYearText =
                request.getParameter("graduationYear");

        String deadlineText =
                request.getParameter("deadline");


        // Check required fields
        if (idText == null ||
                idText.isBlank() ||
                title == null ||
                title.isBlank() ||
                minCgpaText == null ||
                minCgpaText.isBlank() ||
                eligibleBranch == null ||
                eligibleBranch.isBlank() ||
                graduationYearText == null ||
                graduationYearText.isBlank() ||
                deadlineText == null ||
                deadlineText.isBlank()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/recruiter/jobs"
            );
            return;
        }


        try {

            int jobId =
                    Integer.parseInt(idText);

            double minCgpa =
                    Double.parseDouble(minCgpaText);

            int graduationYear =
                    Integer.parseInt(
                            graduationYearText
                    );

            Date deadline =
                    Date.valueOf(deadlineText);


            // Validate CGPA
            if (minCgpa < 0 ||
                    minCgpa > 10) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/edit-job?id="
                                + jobId
                                + "&error=Invalid+CGPA"
                );
                return;
            }


            // Get existing job
            Job job =
                    jobDAO.getJobById(jobId);

            if (job == null) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/jobs"
                );
                return;
            }


            // Get logged-in recruiter
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


            // Security check
            if (job.getCompanyId()
                    != company.getId()) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/jobs"
                );
                return;
            }


            // Update job values
            job.setTitle(
                    title.trim()
            );

            job.setDescription(
                    description
            );

            job.setSalary(
                    salary
            );

            job.setLocation(
                    location
            );

            job.setMinCgpa(
                    minCgpa
            );

            job.setEligibleBranch(
                    eligibleBranch.trim()
            );

            job.setGraduationYear(
                    graduationYear
            );

            job.setDeadline(
                    deadline
            );


            // Save changes
            boolean success =
                    jobDAO.updateJob(job);


            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/jobs?success=Job+updated+successfully"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/edit-job?id="
                                + jobId
                                + "&error=Unable+to+update+job"
                );
            }


        } catch (NumberFormatException e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                            + "/recruiter/jobs?error=Invalid+number"
            );

        } catch (IllegalArgumentException e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                            + "/recruiter/jobs?error=Invalid+deadline"
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
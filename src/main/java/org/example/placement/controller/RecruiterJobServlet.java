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

@WebServlet("/recruiter/jobs")
public class RecruiterJobServlet extends HttpServlet {

    private final JobDAO jobDAO = new JobDAO();
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

        if (!"RECRUITER".equals(
                session.getAttribute("userRole"))) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

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

        request.setAttribute(
                "company",
                company
        );

        request.setAttribute(
                "jobs",
                jobDAO.getCompanyJobs(userId)
        );

        String success =
                request.getParameter("success");

        request.setAttribute(
                "success",
                success
        );

        request.getRequestDispatcher(
                "/recruiter/manage-jobs.jsp"
        ).forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        if (!"RECRUITER".equals(
                session.getAttribute("userRole"))) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

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


        if (title == null ||
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
                            + "/recruiter/post-job.jsp?error=Please+fill+all+required+fields"
            );
            return;
        }


        try {

            double minCgpa =
                    Double.parseDouble(minCgpaText);

            int graduationYear =
                    Integer.parseInt(graduationYearText);

            Date deadline =
                    Date.valueOf(deadlineText);


            if (minCgpa < 0 || minCgpa > 10) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/post-job.jsp?error=CGPA+must+be+between+0+and+10"
                );
                return;
            }


            Job job = new Job();

            job.setCompanyId(
                    company.getId()
            );

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

            job.setStatus(
                    "OPEN"
            );


            boolean success =
                    jobDAO.saveJob(job);


            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/jobs?success=Job+posted+successfully"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/post-job.jsp?error=Unable+to+save+job"
                );
            }

        } catch (NumberFormatException e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                            + "/recruiter/post-job.jsp?error=Invalid+CGPA+or+graduation+year"
            );

        } catch (IllegalArgumentException e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                            + "/recruiter/post-job.jsp?error=Invalid+deadline"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                            + "/recruiter/post-job.jsp?error=Something+went+wrong"
            );
        }
    }
}
package org.example.placement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.example.placement.dao.ApplicationDAO;
import org.example.placement.dao.StudentDAO;
import org.example.placement.dao.JobDAO;
import org.example.placement.model.Student;
import org.example.placement.model.Job;

import java.io.IOException;

@WebServlet("/student/apply")
public class ApplyJobServlet extends HttpServlet {

    private final ApplicationDAO applicationDAO =
            new ApplicationDAO();

    private final StudentDAO studentDAO =
            new StudentDAO();

    private final JobDAO jobDAO =
            new JobDAO();


    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

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
        // GET USER ID
        // =====================================================

        int userId =
                (Integer) session.getAttribute("userId");


        // =====================================================
        // GET JOB ID
        // =====================================================

        String jobIdText =
                request.getParameter("jobId");


        if (jobIdText == null ||
                jobIdText.isBlank()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/student/jobs"
                            + "?error=Invalid+job"
            );

            return;
        }


        try {

            int jobId =
                    Integer.parseInt(jobIdText);


            // =================================================
            // GET STUDENT PROFILE
            // =================================================

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


            int studentId =
                    student.getId();


            // =================================================
            // GET JOB
            // =================================================

            Job job =
                    jobDAO.getJobById(jobId);


            if (job == null) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/student/jobs"
                                + "?error=Job+not+found"
                );

                return;
            }


            // =================================================
            // CHECK JOB STATUS
            // =================================================

            if (!"OPEN".equalsIgnoreCase(
                    job.getStatus())) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/student/jobs"
                                + "?error=This+job+is+closed"
                );

                return;
            }


            // =================================================
            // CHECK ELIGIBILITY
            // =================================================

            boolean cgpaEligible =
                    student.getCgpa()
                            >= job.getMinCgpa();


            boolean branchEligible =
                    job.getEligibleBranch()
                            .equalsIgnoreCase(
                                    student.getBranch()
                            );


            boolean yearEligible =
                    student.getGraduationYear()
                            == job.getGraduationYear();


            if (!cgpaEligible ||
                    !branchEligible ||
                    !yearEligible) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/student/jobs"
                                + "?error=You+are+not+eligible+for+this+job"
                );

                return;
            }


            // =================================================
            // CHECK IF ALREADY APPLIED
            // =================================================

            if (applicationDAO.hasApplied(
                    studentId,
                    jobId)) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/student/jobs"
                                + "?error=You+have+already+applied+for+this+job"
                );

                return;
            }


            // =================================================
            // SAVE APPLICATION
            // =================================================

            boolean success =
                    applicationDAO.applyForJob(
                            studentId,
                            jobId
                    );


            // =================================================
            // RESULT
            // =================================================

            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/student/applications"
                                + "?success=Application+submitted+successfully"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                                + "/student/jobs"
                                + "?error=Unable+to+submit+application"
                );
            }


        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/student/jobs"
                            + "?error=Invalid+job+ID"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                            + "/student/jobs"
                            + "?error=Something+went+wrong"
            );
        }
    }
}
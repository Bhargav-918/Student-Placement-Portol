package org.example.placement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.example.placement.dao.ApplicationDAO;
import org.example.placement.dao.InterviewDAO;
import org.example.placement.model.Application;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/recruiter/schedule-interview")
public class ScheduleInterviewServlet extends HttpServlet {

    private final InterviewDAO interviewDAO =
            new InterviewDAO();

    private final ApplicationDAO applicationDAO =
            new ApplicationDAO();


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


        try {

            int userId =
                    (Integer) session.getAttribute("userId");


            // =================================================
            // GET FORM DATA
            // =================================================

            String applicationIdText =
                    request.getParameter("applicationId");

            String interviewDateText =
                    request.getParameter("interviewDate");

            String mode =
                    request.getParameter("mode");

            String meetingLink =
                    request.getParameter("meetingLink");


            if (applicationIdText == null ||
                    applicationIdText.isBlank() ||
                    interviewDateText == null ||
                    interviewDateText.isBlank() ||
                    mode == null ||
                    mode.isBlank()) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/applications"
                                + "?error=Please+fill+all+required+fields"
                );

                return;
            }


            // =================================================
            // VALIDATE MODE
            // =================================================

            if (!mode.equals("ONLINE") &&
                    !mode.equals("OFFLINE")) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/applications"
                                + "?error=Invalid+interview+mode"
                );

                return;
            }


            // =================================================
            // APPLICATION ID
            // =================================================

            int applicationId =
                    Integer.parseInt(applicationIdText);


            // =================================================
            // VERIFY APPLICATION BELONGS TO RECRUITER
            // =================================================

            List<Application> applications =
                    applicationDAO.getApplicationsByRecruiter(
                            userId
                    );

            boolean applicationBelongsToRecruiter =
                    false;

            for (Application application : applications) {

                if (application.getId() == applicationId) {

                    applicationBelongsToRecruiter = true;
                    break;
                }
            }


            if (!applicationBelongsToRecruiter) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/applications"
                                + "?error=Unauthorized+application"
                );

                return;
            }


            // =================================================
            // CONVERT DATE/TIME
            // =================================================

            LocalDateTime localDateTime =
                    LocalDateTime.parse(
                            interviewDateText
                    );

            Timestamp interviewDate =
                    Timestamp.valueOf(localDateTime);


            // =================================================
            // SCHEDULE INTERVIEW
            // =================================================

            boolean success =
                    interviewDAO.scheduleInterview(
                            applicationId,
                            interviewDate,
                            mode,
                            meetingLink
                    );


            // =================================================
            // RESULT
            // =================================================

            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/interviews"
                                + "?success=Interview+scheduled+successfully"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/applications"
                                + "?error=Unable+to+schedule+interview"
                );
            }


        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/recruiter/applications"
                            + "?error=Invalid+application+ID"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                            + "/recruiter/applications"
                            + "?error=Something+went+wrong"
            );
        }
    }
}
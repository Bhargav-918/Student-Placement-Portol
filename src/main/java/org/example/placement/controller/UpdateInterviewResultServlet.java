package org.example.placement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.example.placement.dao.InterviewDAO;

import java.io.IOException;

@WebServlet("/recruiter/update-interview-result")
public class UpdateInterviewResultServlet extends HttpServlet {

    private final InterviewDAO interviewDAO =
            new InterviewDAO();

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

        try {

            String interviewIdText =
                    request.getParameter("interviewId");

            String result =
                    request.getParameter("result");

            // Validate input
            if (interviewIdText == null ||
                    interviewIdText.isBlank() ||
                    result == null ||
                    result.isBlank()) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/interviews"
                                + "?error=Invalid+interview+data"
                );
                return;
            }

            int interviewId =
                    Integer.parseInt(interviewIdText);

            // Only allow valid results
            if (!result.equals("PENDING") &&
                    !result.equals("PASSED") &&
                    !result.equals("FAILED")) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/interviews"
                                + "?error=Invalid+result"
                );
                return;
            }

            boolean success =
                    interviewDAO.updateInterviewResult(
                            interviewId,
                            result
                    );

            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/interviews"
                                + "?success=Interview+result+updated"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/interviews"
                                + "?error=Unable+to+update+result"
                );
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/recruiter/interviews"
                            + "?error=Invalid+interview+ID"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                            + "/recruiter/interviews"
                            + "?error=Something+went+wrong"
            );
        }
    }
}

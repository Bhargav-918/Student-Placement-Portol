package org.example.placement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.example.placement.dao.ApplicationDAO;

import java.io.IOException;

@WebServlet("/recruiter/update-application")
public class UpdateApplicationStatusServlet extends HttpServlet {

    private final ApplicationDAO applicationDAO =
            new ApplicationDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // -----------------------------------------
        // Check login
        // -----------------------------------------

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/login.jsp"
            );
            return;
        }


        // -----------------------------------------
        // Check recruiter role
        // -----------------------------------------

        if (!"RECRUITER".equals(
                session.getAttribute("userRole"))) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/login.jsp"
            );
            return;
        }


        // -----------------------------------------
        // Get form values
        // -----------------------------------------

        String idText =
                request.getParameter("applicationId");

        String status =
                request.getParameter("status");


        // -----------------------------------------
        // Validate values
        // -----------------------------------------

        if (idText == null ||
                idText.isBlank() ||
                status == null ||
                status.isBlank()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/recruiter/applications"
                            + "?error=Invalid+request"
            );
            return;
        }


        try {

            int applicationId =
                    Integer.parseInt(idText);


            // -----------------------------------------
            // Allow only valid database statuses
            // -----------------------------------------

            if (!status.equals("APPLIED") &&
                    !status.equals("SHORTLISTED") &&
                    !status.equals("REJECTED") &&
                    !status.equals("SELECTED")) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/applications"
                                + "?error=Invalid+status"
                );
                return;
            }


            // -----------------------------------------
            // Update application
            // -----------------------------------------

            boolean success =
                    applicationDAO.updateApplicationStatus(
                            applicationId,
                            status
                    );


            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/applications"
                                + "?success=Application+status+updated"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                                + "/recruiter/applications"
                                + "?error=Unable+to+update+status"
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
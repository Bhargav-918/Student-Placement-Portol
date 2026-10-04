package org.example.placement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.example.placement.dao.UserDAO;
import org.example.placement.model.User;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword =
                request.getParameter("confirmPassword");
        String role = request.getParameter("role");

        // Check required fields
        if (name == null ||
                email == null ||
                password == null ||
                role == null ||
                name.isBlank() ||
                email.isBlank() ||
                password.isBlank() ||
                role.isBlank()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/register.jsp?error=Please+fill+all+required+fields"
            );
            return;
        }

        // Check password confirmation
        if (confirmPassword != null &&
                !password.equals(confirmPassword)) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/register.jsp?error=Passwords+do+not+match"
            );
            return;
        }

        // Allow only valid roles
        if (!role.equals("STUDENT") &&
                !role.equals("RECRUITER") &&
                !role.equals("ADMIN")) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/register.jsp?error=Invalid+role"
            );
            return;
        }

        // Check duplicate email
        if (userDAO.emailExists(email)) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/register.jsp?error=Email+already+registered"
            );
            return;
        }

        // Create user
        User user = new User(
                name.trim(),
                email.trim(),
                password,
                role
        );

        boolean success =
                userDAO.registerUser(user);

        if (success) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/login.jsp?success=Registration+successful"
            );

        } else {

            response.sendRedirect(
                    request.getContextPath()
                            + "/register.jsp?error=Registration+failed"
            );
        }
    }
}
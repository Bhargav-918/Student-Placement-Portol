package org.example.placement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.example.placement.dao.UserDAO;
import org.example.placement.model.User;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null ||
                email.isBlank() || password.isBlank()) {

            response.sendRedirect(
                    "login.jsp?error=Please+enter+email+and+password"
            );
            return;
        }

        User user = userDAO.loginUser(email, password);

        if (user == null) {

            response.sendRedirect(
                    "login.jsp?error=Invalid+email+or+password"
            );
            return;
        }

        HttpSession session = request.getSession();

        session.setAttribute("userId", user.getId());
        session.setAttribute("userName", user.getName());
        session.setAttribute("userEmail", user.getEmail());
        session.setAttribute("userRole", user.getRole());

        switch (user.getRole()) {

            case "STUDENT":
                response.sendRedirect("student/dashboard.jsp");
                break;

            case "RECRUITER":
                response.sendRedirect("recruiter/dashboard.jsp");
                break;

            case "ADMIN":
                response.sendRedirect("admin/dashboard.jsp");
                break;

            default:
                response.sendRedirect("login.jsp?error=Invalid+role");
        }
    }
}
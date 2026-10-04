package org.example.placement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.example.placement.dao.StudentDAO;
import org.example.placement.model.Student;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/students")
public class AdminStudentServlet extends HttpServlet {

    private final StudentDAO studentDAO = new StudentDAO();

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
                    request.getContextPath()
                            + "/login.jsp"
            );
            return;
        }

        // Check ADMIN role
        if (!"ADMIN".equals(
                session.getAttribute("userRole"))) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/login.jsp"
            );
            return;
        }

        // Get all students
        List<Student> students =
                studentDAO.getAllStudents();

        request.setAttribute(
                "students",
                students
        );

        // Open admin students page
        request.getRequestDispatcher(
                "/admin/students.jsp"
        ).forward(request, response);
    }
}
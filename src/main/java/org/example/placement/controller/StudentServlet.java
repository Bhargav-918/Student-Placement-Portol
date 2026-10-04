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

@WebServlet("/student/profile")
public class StudentServlet extends HttpServlet {

    private final StudentDAO studentDAO = new StudentDAO();

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

        int userId = (Integer) session.getAttribute("userId");

        Student student =
                studentDAO.getStudentByUserId(userId);

        request.setAttribute("student", student);

        request.getRequestDispatcher(
                "/student/profile.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
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

        int userId = (Integer) session.getAttribute("userId");

        String rollNo =
                request.getParameter("rollNo");

        String phone =
                request.getParameter("phone");

        String branch =
                request.getParameter("branch");

        String cgpaText =
                request.getParameter("cgpa");

        String graduationYearText =
                request.getParameter("graduationYear");

        String resume =
                request.getParameter("resume");

        try {

            double cgpa = Double.parseDouble(cgpaText);

            int graduationYear =
                    Integer.parseInt(graduationYearText);

            Student student =
                    studentDAO.getStudentByUserId(userId);

            boolean success;

            if (student == null) {

                student = new Student(
                        userId,
                        rollNo,
                        phone,
                        branch,
                        cgpa,
                        graduationYear,
                        resume
                );

                success = studentDAO.saveStudent(student);

            } else {

                student.setRollNo(rollNo);
                student.setPhone(phone);
                student.setBranch(branch);
                student.setCgpa(cgpa);
                student.setGraduationYear(graduationYear);
                student.setResume(resume);

                success = studentDAO.updateStudent(student);
            }

            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/student/profile?success=Profile+saved"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                                + "/student/profile?error=Unable+to+save+profile"
                );
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/student/profile?error=Invalid+CGPA+or+graduation+year"
            );
        }
    }
}
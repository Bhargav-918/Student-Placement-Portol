<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.placement.model.Student" %>

<%
    // Admin authentication
    if (session.getAttribute("userId") == null ||
            !"ADMIN".equals(session.getAttribute("userRole"))) {

        response.sendRedirect(
                request.getContextPath() + "/login.jsp"
        );
        return;
    }

    List<Student> students =
            (List<Student>) request.getAttribute("students");
%>

<!DOCTYPE html>
<html>

<head>

    <title>Manage Students</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f7fb;
        }

        .container {
            width: 94%;
            max-width: 1200px;
            margin: 35px auto;
        }

        .header {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
            margin-bottom: 25px;
        }

        .header h1 {
            margin: 0 0 10px;
        }

        .header p {
            color: #666;
        }

        .table-container {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th,
        td {
            padding: 13px;
            text-align: left;
            border-bottom: 1px solid #e5e7eb;
        }

        th {
            background: #f1f5f9;
            font-weight: bold;
        }

        tr:hover {
            background: #f8fafc;
        }

        .no-data {
            text-align: center;
            padding: 40px;
            color: #666;
        }

        .button {
            display: inline-block;
            padding: 10px 18px;
            background: #2563eb;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            margin-top: 20px;
        }

        .button:hover {
            background: #1d4ed8;
        }

        .cgpa {
            font-weight: bold;
        }

    </style>

</head>

<body>

<div class="container">

    <div class="header">

        <h1>👨‍🎓 Manage Students</h1>

        <p>
            View all registered student profiles.
        </p>

    </div>


    <div class="table-container">

        <% if (students == null || students.isEmpty()) { %>

            <div class="no-data">

                <h3>No Students Found</h3>

                <p>
                    There are currently no student profiles
                    registered in the portal.
                </p>

            </div>

        <% } else { %>

            <table>

                <thead>

                <tr>
                    <th>#</th>
                    <th>Student ID</th>
                    <th>Roll Number</th>
                    <th>Phone</th>
                    <th>Branch</th>
                    <th>CGPA</th>
                    <th>Graduation Year</th>
                    <th>Resume</th>
                </tr>

                </thead>

                <tbody>

                <%
                    int count = 1;

                    for (Student student : students) {
                %>

                <tr>

                    <td>
                        <%= count++ %>
                    </td>

                    <td>
                        <%= student.getId() %>
                    </td>

                    <td>
                        <%= student.getRollNo() != null
                                ? student.getRollNo()
                                : "-" %>
                    </td>

                    <td>
                        <%= student.getPhone() != null
                                ? student.getPhone()
                                : "-" %>
                    </td>

                    <td>
                        <%= student.getBranch() != null
                                ? student.getBranch()
                                : "-" %>
                    </td>

                    <td class="cgpa">
                        <%= student.getCgpa() %>
                    </td>

                    <td>
                        <%= student.getGraduationYear() %>
                    </td>

                    <td>

                        <% if (student.getResume() != null &&
                               !student.getResume().isBlank()) { %>

                            <span>Available</span>

                        <% } else { %>

                            <span>-</span>

                        <% } %>

                    </td>

                </tr>

                <%
                    }
                %>

                </tbody>

            </table>

        <% } %>

    </div>


    <a class="button"
       href="<%= request.getContextPath() %>/admin/dashboard.jsp">

        ← Back to Admin Dashboard

    </a>

</div>

</body>

</html
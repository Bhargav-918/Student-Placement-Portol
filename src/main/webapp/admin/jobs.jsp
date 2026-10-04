<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.placement.model.Job" %>

<%
    // Admin authentication
    if (session.getAttribute("userId") == null ||
            !"ADMIN".equals(session.getAttribute("userRole"))) {

        response.sendRedirect(
                request.getContextPath() + "/login.jsp"
        );
        return;
    }

    List<Job> jobs =
            (List<Job>) request.getAttribute("jobs");
%>

<!DOCTYPE html>
<html>

<head>

    <title>Manage Jobs</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f7fb;
        }

        .container {
            width: 96%;
            max-width: 1400px;
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
            min-width: 1100px;
        }

        th,
        td {
            padding: 12px;
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

        .description {
            max-width: 250px;
        }

        .status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: bold;
        }

        .open {
            background: #dcfce7;
            color: #166534;
        }

        .closed {
            background: #fee2e2;
            color: #991b1b;
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

    </style>

</head>

<body>

<div class="container">

    <div class="header">

        <h1>💼 Manage Jobs</h1>

        <p>
            View all placement jobs posted by recruiters.
        </p>

    </div>


    <div class="table-container">

        <% if (jobs == null || jobs.isEmpty()) { %>

            <div class="no-data">

                <h3>No Jobs Found</h3>

                <p>
                    There are currently no jobs posted
                    by recruiters.
                </p>

            </div>

        <% } else { %>

            <table>

                <thead>

                <tr>
                    <th>#</th>
                    <th>Job ID</th>
                    <th>Company</th>
                    <th>Job Title</th>
                    <th>Description</th>
                    <th>Salary</th>
                    <th>Location</th>
                    <th>Min CGPA</th>
                    <th>Branch</th>
                    <th>Graduation Year</th>
                    <th>Deadline</th>
                    <th>Status</th>
                </tr>

                </thead>

                <tbody>

                <%
                    int count = 1;

                    for (Job job : jobs) {
                %>

                <tr>

                    <td>
                        <%= count++ %>
                    </td>

                    <td>
                        <%= job.getId() %>
                    </td>

                    <td>
                        <strong>
                            <%= job.getCompanyName() %>
                        </strong>
                    </td>

                    <td>
                        <%= job.getTitle() %>
                    </td>

                    <td class="description">
                        <%= job.getDescription() != null
                                ? job.getDescription()
                                : "-" %>
                    </td>

                    <td>
                        <%= job.getSalary() != null
                                ? job.getSalary()
                                : "-" %>
                    </td>

                    <td>
                        <%= job.getLocation() != null
                                ? job.getLocation()
                                : "-" %>
                    </td>

                    <td>
                        <%= job.getMinCgpa() %>
                    </td>

                    <td>
                        <%= job.getEligibleBranch() != null
                                ? job.getEligibleBranch()
                                : "-" %>
                    </td>

                    <td>
                        <%= job.getGraduationYear() %>
                    </td>

                    <td>
                        <%= job.getDeadline() != null
                                ? job.getDeadline()
                                : "-" %>
                    </td>

                    <td>

                        <% if ("OPEN".equals(job.getStatus())) { %>

                            <span class="status open">
                                OPEN
                            </span>

                        <% } else { %>

                            <span class="status closed">
                                CLOSED
                            </span>

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

</html>
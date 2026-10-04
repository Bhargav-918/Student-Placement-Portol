<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.placement.model.Application" %>

<%
    // Admin authentication check
    if (session.getAttribute("userId") == null ||
            !"ADMIN".equals(session.getAttribute("userRole"))) {

        response.sendRedirect(
                request.getContextPath() + "/login.jsp"
        );
        return;
    }

    List<Application> applicationsList =
            (List<Application>) request.getAttribute("applications");
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Manage Applications</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f7fb;
            color: #1f2937;
        }

        .header {
            background: #1e3a8a;
            color: white;
            padding: 22px 35px;
        }

        .header h1 {
            margin: 0;
            font-size: 28px;
        }

        .header p {
            margin: 7px 0 0;
            opacity: 0.9;
        }

        .container {
            width: 95%;
            margin: 30px auto;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .top-bar h2 {
            margin: 0;
            color: #1e3a8a;
        }

        .back-button {
            text-decoration: none;
            background: #374151;
            color: white;
            padding: 10px 18px;
            border-radius: 6px;
            font-size: 14px;
        }

        .back-button:hover {
            background: #111827;
        }

        .count-box {
            margin-bottom: 18px;
            background: white;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            display: inline-block;
        }

        .count-number {
            font-size: 22px;
            font-weight: bold;
            color: #1e3a8a;
        }

        .table-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 900px;
        }

        th {
            background: #1e3a8a;
            color: white;
            padding: 14px;
            text-align: left;
            font-size: 14px;
        }

        td {
            padding: 13px 14px;
            border-bottom: 1px solid #e5e7eb;
            font-size: 14px;
        }

        tr:hover {
            background: #f8fafc;
        }

        .status {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }

        .applied {
            background: #dbeafe;
            color: #1d4ed8;
        }

        .shortlisted {
            background: #fef3c7;
            color: #92400e;
        }

        .selected {
            background: #dcfce7;
            color: #166534;
        }

        .rejected {
            background: #fee2e2;
            color: #991b1b;
        }

        .empty {
            text-align: center;
            padding: 50px;
            color: #6b7280;
            font-size: 16px;
        }

    </style>

</head>

<body>

<div class="header">

    <h1>Admin Panel</h1>

    <p>Student Applications Management</p>

</div>

<div class="container">

    <div class="top-bar">

        <h2>All Applications</h2>

        <a href="<%= request.getContextPath() %>/admin/dashboard.jsp"
           class="back-button">
            ← Back to Dashboard
        </a>

    </div>

    <div class="count-box">

        Total Applications:

        <span class="count-number">
            <%= applicationsList == null
                    ? 0
                    : applicationsList.size() %>
        </span>

    </div>

    <div class="table-container">

        <%
            if (applicationsList == null ||
                    applicationsList.isEmpty()) {
        %>

            <div class="empty">
                No applications found.
            </div>

        <%
            } else {
        %>

        <table>

            <thead>

            <tr>

                <th>#</th>
                <th>Application ID</th>
                <th>Student ID</th>
                <th>Job ID</th>
                <th>Company</th>
                <th>Job Title</th>
                <th>Applied Date</th>
                <th>Status</th>

            </tr>

            </thead>

            <tbody>

            <%
                int count = 1;

                for (Application app :
                        applicationsList) {

                    String status =
                            app.getStatus();

                    String statusClass =
                            status == null
                                    ? ""
                                    : status.toLowerCase();
            %>

            <tr>

                <td>
                    <%= count++ %>
                </td>

                <td>
                    <%= app.getId() %>
                </td>

                <td>
                    <%= app.getStudentId() %>
                </td>

                <td>
                    <%= app.getJobId() %>
                </td>

                <td>
                    <%= app.getCompanyName() %>
                </td>

                <td>
                    <%= app.getJobTitle() %>
                </td>

                <td>
                    <%= app.getAppliedDate() %>
                </td>

                <td>

                    <span class="status <%= statusClass %>">
                        <%= status %>
                    </span>

                </td>

            </tr>

            <%
                }
            %>

            </tbody>

        </table>

        <%
            }
        %>

    </div>

</div>

</body>
</html>
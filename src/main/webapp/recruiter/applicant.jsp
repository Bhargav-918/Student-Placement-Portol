<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.placement.model.Application" %>

<%
    if (session.getAttribute("userId") == null ||
            !"RECRUITER".equals(session.getAttribute("userRole"))) {

        response.sendRedirect(
                request.getContextPath() + "/login.jsp"
        );
        return;
    }

    List<Application> applications =
            (List<Application>) request.getAttribute("applications");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Applicant Management</title>

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
            padding: 18px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h2 {
            margin: 0;
        }

        .dashboard {
            color: white;
            text-decoration: none;
            background: #2563eb;
            padding: 9px 15px;
            border-radius: 6px;
        }

        .container {
            width: 95%;
            max-width: 1300px;
            margin: 35px auto;
        }

        .title-section {
            margin-bottom: 25px;
        }

        .title-section h1 {
            color: #1e3a8a;
            margin-bottom: 8px;
        }

        .message {
            padding: 13px 16px;
            margin-bottom: 20px;
            border-radius: 7px;
            background: #dcfce7;
            color: #166534;
        }

        .error {
            padding: 13px 16px;
            margin-bottom: 20px;
            border-radius: 7px;
            background: #fee2e2;
            color: #991b1b;
        }

        .table-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 18px rgba(0,0,0,0.08);
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1150px;
        }

        th {
            background: #1e3a8a;
            color: white;
            padding: 14px;
            text-align: left;
        }

        td {
            padding: 14px;
            border-bottom: 1px solid #e5e7eb;
            vertical-align: middle;
        }

        tr:hover {
            background: #f8fafc;
        }

        .status {
            display: inline-block;
            padding: 6px 10px;
            border-radius: 15px;
            font-size: 13px;
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

        .actions {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .action-form {
            margin: 0;
        }

        .action-button {
            width: 100%;
            border: none;
            padding: 8px 12px;
            border-radius: 6px;
            cursor: pointer;
            color: white;
            font-weight: bold;
        }

        .shortlist-button {
            background: #d97706;
        }

        .shortlist-button:hover {
            background: #b45309;
        }

        .select-button {
            background: #16a34a;
        }

        .select-button:hover {
            background: #15803d;
        }

        .reject-button {
            background: #dc2626;
        }

        .reject-button:hover {
            background: #b91c1c;
        }

        .schedule-box {
            background: #eff6ff;
            padding: 12px;
            border-radius: 8px;
            min-width: 260px;
        }

        .schedule-box h4 {
            margin: 0 0 10px 0;
            color: #1e3a8a;
        }

        .schedule-box input,
        .schedule-box select {
            width: 100%;
            padding: 8px;
            margin-bottom: 8px;
            border: 1px solid #cbd5e1;
            border-radius: 5px;
            font-size: 13px;
        }

        .schedule-button {
            width: 100%;
            padding: 9px;
            border: none;
            border-radius: 6px;
            background: #2563eb;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }

        .schedule-button:hover {
            background: #1d4ed8;
        }

        .empty {
            background: white;
            padding: 40px;
            text-align: center;
            border-radius: 12px;
            box-shadow: 0 5px 18px rgba(0,0,0,0.08);
        }

        .empty h2 {
            color: #1e3a8a;
        }

    </style>

</head>

<body>


<div class="header">

    <h2>Student Placement Portal</h2>

    <a class="dashboard"
       href="<%= request.getContextPath() %>/recruiter/dashboard.jsp">
        Dashboard
    </a>

</div>


<div class="container">


    <div class="title-section">

        <h1>Applicant Management</h1>

        <p>
            Review applications, update status and schedule interviews.
        </p>

    </div>


    <% if (request.getParameter("success") != null) { %>

        <div class="message">
            <%= request.getParameter("success") %>
        </div>

    <% } %>


    <% if (request.getParameter("error") != null) { %>

        <div class="error">
            <%= request.getParameter("error") %>
        </div>

    <% } %>


    <% if (applications == null || applications.isEmpty()) { %>

        <div class="empty">

            <h2>No applications submitted</h2>

            <p>
                Applications from students will appear here.
            </p>

        </div>

    <% } else { %>


        <div class="table-card">

            <table>

                <thead>

                <tr>

                    <th>#</th>
                    <th>Student ID</th>
                    <th>Job Title</th>
                    <th>Company</th>
                    <th>Applied Date</th>
                    <th>Status</th>
                    <th>Application Actions</th>
                    <th>Schedule Interview</th>

                </tr>

                </thead>


                <tbody>

                <%
                    int count = 1;

                    for (Application app : applications) {

                        String status =
                                app.getStatus();

                        String statusClass =
                                "applied";

                        if ("SHORTLISTED".equalsIgnoreCase(status)) {

                            statusClass =
                                    "shortlisted";

                        } else if ("SELECTED".equalsIgnoreCase(status)) {

                            statusClass =
                                    "selected";

                        } else if ("REJECTED".equalsIgnoreCase(status)) {

                            statusClass =
                                    "rejected";
                        }
                %>


                <tr>


                    <!-- Number -->

                    <td>
                        <%= count++ %>
                    </td>


                    <!-- Student ID -->

                    <td>
                        <strong>
                            <%= app.getStudentId() %>
                        </strong>
                    </td>


                    <!-- Job -->

                    <td>
                        <%= app.getJobTitle() %>
                    </td>


                    <!-- Company -->

                    <td>
                        <%= app.getCompanyName() %>
                    </td>


                    <!-- Applied Date -->

                    <td>
                        <%= app.getAppliedDate() %>
                    </td>


                    <!-- Status -->

                    <td>

                        <span class="status <%= statusClass %>">
                            <%= status %>
                        </span>

                    </td>


                    <!-- Application Actions -->

                    <td>

                        <div class="actions">


                            <!-- SHORTLIST -->

                            <form class="action-form"
                                  action="<%= request.getContextPath() %>/recruiter/update-application"
                                  method="post">

                                <input type="hidden"
                                       name="applicationId"
                                       value="<%= app.getId() %>">

                                <input type="hidden"
                                       name="status"
                                       value="SHORTLISTED">

                                <button
                                        type="submit"
                                        class="action-button shortlist-button">

                                    Shortlist

                                </button>

                            </form>


                            <!-- SELECT -->

                            <form class="action-form"
                                  action="<%= request.getContextPath() %>/recruiter/update-application"
                                  method="post"
                                  onsubmit="return confirm('Select this student?');">

                                <input type="hidden"
                                       name="applicationId"
                                       value="<%= app.getId() %>">

                                <input type="hidden"
                                       name="status"
                                       value="SELECTED">

                                <button
                                        type="submit"
                                        class="action-button select-button">

                                    Select

                                </button>

                            </form>


                            <!-- REJECT -->

                            <form class="action-form"
                                  action="<%= request.getContextPath() %>/recruiter/update-application"
                                  method="post"
                                  onsubmit="return confirm('Reject this application?');">

                                <input type="hidden"
                                       name="applicationId"
                                       value="<%= app.getId() %>">

                                <input type="hidden"
                                       name="status"
                                       value="REJECTED">

                                <button
                                        type="submit"
                                        class="action-button reject-button">

                                    Reject

                                </button>

                            </form>


                        </div>

                    </td>


                    <!-- SCHEDULE INTERVIEW -->

                    <td>

                        <div class="schedule-box">

                            <h4>
                                Schedule Interview
                            </h4>


                            <form
                                    action="<%= request.getContextPath() %>/recruiter/schedule-interview"
                                    method="post">


                                <input
                                        type="hidden"
                                        name="applicationId"
                                        value="<%= app.getId() %>">


                                <label>
                                    Date & Time
                                </label>

                                <input
                                        type="datetime-local"
                                        name="interviewDate"
                                        required>


                                <label>
                                    Mode
                                </label>

                                <select
                                        name="mode"
                                        required>

                                    <option value="">
                                        Select Mode
                                    </option>

                                    <option value="ONLINE">
                                        Online
                                    </option>

                                    <option value="OFFLINE">
                                        Offline
                                    </option>

                                </select>


                                <label>
                                    Meeting Link
                                </label>

                                <input
                                        type="url"
                                        name="meetingLink"
                                        placeholder="https://meet.google.com/...">


                                <button
                                        type="submit"
                                        class="schedule-button">

                                    Schedule Interview

                                </button>

                            </form>

                        </div>

                    </td>


                </tr>


                <% } %>

                </tbody>

            </table>

        </div>


    <% } %>


</div>

</body>

</html>
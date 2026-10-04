<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="org.example.placement.model.Application" %>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    List<Application> applications =
            (List<Application>) request.getAttribute("applications");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>My Applications</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f7fb;
            color: #222;
        }

        .header {
            background: #1f4e79;
            color: white;
            padding: 20px 40px;
        }

        .header h1 {
            margin: 0;
        }

        .container {
            width: 90%;
            max-width: 1100px;
            margin: 30px auto;
        }

        .message {
            padding: 12px 15px;
            margin-bottom: 20px;
            border-radius: 6px;
            background: #e5f7e5;
            color: #176b17;
            font-weight: bold;
        }

        .application-card {
            background: white;
            padding: 25px;
            margin-bottom: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }

        .application-card h2 {
            margin-top: 0;
            color: #1f4e79;
        }

        .company {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .details {
            line-height: 1.8;
        }

        .status {
            display: inline-block;
            margin-top: 5px;
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: bold;
        }

        /* APPLIED */

        .status-applied {
            background: #dbeafe;
            color: #1d4ed8;
        }

        /* SHORTLISTED */

        .status-shortlisted {
            background: #fef3c7;
            color: #92400e;
        }

        /* SELECTED */

        .status-selected {
            background: #dcfce7;
            color: #166534;
        }

        /* REJECTED */

        .status-rejected {
            background: #fee2e2;
            color: #991b1b;
        }

        .back-btn {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 18px;
            background: #555;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }

        .back-btn:hover {
            background: #333;
        }

        .empty {
            background: white;
            padding: 40px;
            text-align: center;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }

        .empty h2 {
            color: #1f4e79;
        }

        .status-message {
            margin-top: 8px;
            font-size: 14px;
            color: #666;
        }

    </style>

</head>

<body>


<div class="header">

    <h1>My Applications</h1>

</div>


<div class="container">


    <% if (request.getParameter("success") != null) { %>

        <div class="message">

            <%= request.getParameter("success") %>

        </div>

    <% } %>


    <% if (applications == null || applications.isEmpty()) { %>

        <div class="empty">

            <h2>No Applications Yet</h2>

            <p>
                You have not applied for any placement drives.
            </p>

            <a class="back-btn"
               href="<%= request.getContextPath() %>/student/jobs">

                View Placement Drives

            </a>

        </div>

    <% } else { %>


        <% for (Application app : applications) {

            String status = app.getStatus();

            String statusClass = "status-applied";

            if ("SHORTLISTED".equalsIgnoreCase(status)) {

                statusClass = "status-shortlisted";

            } else if ("SELECTED".equalsIgnoreCase(status)) {

                statusClass = "status-selected";

            } else if ("REJECTED".equalsIgnoreCase(status)) {

                statusClass = "status-rejected";

            }

        %>


            <div class="application-card">

                <h2>
                    <%= app.getJobTitle() %>
                </h2>


                <div class="company">

                    <%= app.getCompanyName() %>

                </div>


                <div class="details">


                    <p>

                        <strong>Applied Date:</strong>

                        <%= app.getAppliedDate() %>

                    </p>


                    <p>

                        <strong>Application ID:</strong>

                        <%= app.getId() %>

                    </p>


                    <p>

                        <strong>Application Status:</strong>

                    </p>


                    <span class="status <%= statusClass %>">

                        <%= status %>

                    </span>


                    <%
                        if ("APPLIED".equalsIgnoreCase(status)) {
                    %>

                        <div class="status-message">
                            Your application has been submitted successfully.
                        </div>

                    <%
                        } else if ("SHORTLISTED".equalsIgnoreCase(status)) {
                    %>

                        <div class="status-message">
                            Congratulations! You have been shortlisted.
                        </div>

                    <%
                        } else if ("SELECTED".equalsIgnoreCase(status)) {
                    %>

                        <div class="status-message">
                            Congratulations! You have been selected.
                        </div>

                    <%
                        } else if ("REJECTED".equalsIgnoreCase(status)) {
                    %>

                        <div class="status-message">
                            Unfortunately, your application was not selected.
                        </div>

                    <%
                        }
                    %>


                </div>

            </div>


        <% } %>


    <% } %>


    <a class="back-btn"
       href="<%= request.getContextPath() %>/student/dashboard.jsp">

        ← Back to Dashboard

    </a>


</div>

</body>

</html>
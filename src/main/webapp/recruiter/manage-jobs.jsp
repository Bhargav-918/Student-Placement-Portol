<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.placement.model.Job" %>

<%
    HttpSession currentSession = request.getSession(false);

    if (currentSession == null ||
            currentSession.getAttribute("userId") == null ||
            !"RECRUITER".equals(
                    currentSession.getAttribute("userRole"))) {

        response.sendRedirect(
                request.getContextPath() + "/login.jsp"
        );
        return;
    }

    List<Job> jobs =
            (List<Job>) request.getAttribute("jobs");

    String success =
            request.getParameter("success");

    String error =
            request.getParameter("error");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Manage Jobs</title>

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

        .header-links {
            display: flex;
            gap: 10px;
        }

        .header a {
            color: white;
            text-decoration: none;
            background: #2563eb;
            padding: 10px 16px;
            border-radius: 7px;
        }

        .container {
            width: 90%;
            max-width: 1100px;
            margin: 35px auto;
        }

        .top-section {
            background: white;
            padding: 25px;
            border-radius: 12px;

            box-shadow:
                    0 4px 15px rgba(0,0,0,0.08);

            margin-bottom: 25px;

            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .top-section h1 {
            margin: 0;
            color: #1e3a8a;
        }

        .post-button {
            background: #16a34a;
            color: white;

            padding: 11px 18px;

            border-radius: 7px;

            text-decoration: none;

            font-weight: bold;
        }

        .post-button:hover {
            background: #15803d;
        }

        .message {
            padding: 13px;
            border-radius: 7px;
            margin-bottom: 20px;
        }

        .success {
            background: #dcfce7;
            color: #166534;
        }

        .error {
            background: #fee2e2;
            color: #991b1b;
        }

        .job-card {
            background: white;

            padding: 25px;

            border-radius: 12px;

            margin-bottom: 20px;

            box-shadow:
                    0 4px 15px rgba(0,0,0,0.08);
        }

        .job-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;

            margin-bottom: 15px;
        }

        .job-title {
            margin: 0;
            color: #1e3a8a;
            font-size: 24px;
        }

        .status {
            padding: 6px 12px;
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

        .description {
            color: #4b5563;
            line-height: 1.6;

            margin-bottom: 20px;
        }

        .details {
            display: grid;

            grid-template-columns:
                    repeat(2, 1fr);

            gap: 12px;

            background: #f8fafc;

            padding: 18px;

            border-radius: 8px;
        }

        .detail {
            padding: 5px;
        }

        .detail strong {
            color: #374151;
        }

        .actions {
            margin-top: 20px;

            display: flex;

            gap: 10px;

            flex-wrap: wrap;
        }

        .action-button {
            display: inline-block;

            padding: 10px 18px;

            border-radius: 7px;

            text-decoration: none;

            font-weight: bold;
        }

        .edit-button {
            background: #2563eb;
            color: white;
        }

        .edit-button:hover {
            background: #1d4ed8;
        }

        .close-button {
            background: #dc2626;
            color: white;
        }

        .close-button:hover {
            background: #b91c1c;
        }

        .empty {
            background: white;

            padding: 50px;

            text-align: center;

            border-radius: 12px;

            box-shadow:
                    0 4px 15px rgba(0,0,0,0.08);
        }

        .empty h2 {
            color: #1e3a8a;
        }

        .empty p {
            color: #6b7280;
        }

        @media (max-width: 700px) {

            .header {
                padding: 15px 20px;
            }

            .container {
                width: 94%;
            }

            .top-section {
                flex-direction: column;
                gap: 20px;
                align-items: flex-start;
            }

            .details {
                grid-template-columns: 1fr;
            }

            .job-header {
                flex-direction: column;
                gap: 12px;
            }

        }

    </style>

</head>

<body>


<!-- HEADER -->

<div class="header">

    <h2>Recruiter Portal</h2>

    <div class="header-links">

        <a href="<%= request.getContextPath() %>/recruiter/dashboard.jsp">
            Dashboard
        </a>

    </div>

</div>


<div class="container">


    <!-- PAGE TITLE -->

    <div class="top-section">

        <h1>Manage Jobs</h1>

        <a
                class="post-button"
                href="<%= request.getContextPath() %>/recruiter/post-job.jsp"
        >
            + Post New Job
        </a>

    </div>


    <!-- SUCCESS MESSAGE -->

    <% if (success != null) { %>

        <div class="message success">

            <%= success.replace("+", " ") %>

        </div>

    <% } %>


    <!-- ERROR MESSAGE -->

    <% if (error != null) { %>

        <div class="message error">

            <%= error.replace("+", " ") %>

        </div>

    <% } %>


    <!-- JOB LIST -->

    <%
        if (jobs == null || jobs.isEmpty()) {
    %>

        <div class="empty">

            <h2>No Jobs Posted</h2>

            <p>
                You have not posted any jobs yet.
            </p>

            <br>

            <a
                    class="post-button"
                    href="<%= request.getContextPath() %>/recruiter/post-job.jsp"
            >
                Post Your First Job
            </a>

        </div>

    <%
        } else {

            for (Job job : jobs) {
    %>


        <!-- JOB CARD -->

        <div class="job-card">


            <div class="job-header">

                <h2 class="job-title">
                    <%= job.getTitle() %>
                </h2>


                <%
                    if ("OPEN".equalsIgnoreCase(
                            job.getStatus())) {
                %>

                    <span class="status open">
                        OPEN
                    </span>

                <%
                    } else {
                %>

                    <span class="status closed">
                        CLOSED
                    </span>

                <%
                    }
                %>

            </div>


            <!-- DESCRIPTION -->

            <div class="description">

                <strong>Description:</strong>

                <br>

                <%= job.getDescription() != null &&
                    !job.getDescription().isBlank()
                        ? job.getDescription()
                        : "No description provided." %>

            </div>


            <!-- DETAILS -->

            <div class="details">


                <div class="detail">

                    <strong>Salary:</strong>

                    <br>

                    <%= job.getSalary() != null &&
                        !job.getSalary().isBlank()
                            ? job.getSalary()
                            : "Not specified" %>

                </div>


                <div class="detail">

                    <strong>Location:</strong>

                    <br>

                    <%= job.getLocation() != null &&
                        !job.getLocation().isBlank()
                            ? job.getLocation()
                            : "Not specified" %>

                </div>


                <div class="detail">

                    <strong>Minimum CGPA:</strong>

                    <br>

                    <%= job.getMinCgpa() %>

                </div>


                <div class="detail">

                    <strong>Eligible Branch:</strong>

                    <br>

                    <%= job.getEligibleBranch() %>

                </div>


                <div class="detail">

                    <strong>Graduation Year:</strong>

                    <br>

                    <%= job.getGraduationYear() %>

                </div>


                <div class="detail">

                    <strong>Application Deadline:</strong>

                    <br>

                    <%= job.getDeadline() %>

                </div>


            </div>


            <!-- ACTION BUTTONS -->

            <div class="actions">


                <!-- EDIT BUTTON -->

                <a
                        class="action-button edit-button"
                        href="<%= request.getContextPath() %>/recruiter/edit-job?id=<%= job.getId() %>"
                >
                    ✏ Edit Job
                </a>


                <!-- CLOSE JOB -->

                <%
                    if ("OPEN".equalsIgnoreCase(
                            job.getStatus())) {
                %>

                    <a
                            class="action-button close-button"
                            href="<%= request.getContextPath() %>/recruiter/close-job?id=<%= job.getId() %>"
                            onclick="return confirm('Are you sure you want to close this job?');"
                    >
                        Close Job
                    </a>

                <%
                    }
                %>


            </div>


        </div>


    <%
            }
        }
    %>


</div>

</body>

</html>
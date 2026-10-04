<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="org.example.placement.model.Interview" %>

<%
    if (session.getAttribute("userId") == null ||
            !"STUDENT".equals(session.getAttribute("userRole"))) {

        response.sendRedirect(
                request.getContextPath() + "/login.jsp"
        );
        return;
    }

    List<Interview> interviews =
            (List<Interview>) request.getAttribute("interviews");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>My Interviews</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f7fb;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 40px auto;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .header h1 {
            margin: 0;
            color: #222;
        }

        .back-button {
            text-decoration: none;
            background: #333;
            color: white;
            padding: 10px 18px;
            border-radius: 6px;
        }

        .back-button:hover {
            background: #111;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        .no-interviews {
            text-align: center;
            padding: 50px 20px;
        }

        .no-interviews h2 {
            margin-bottom: 10px;
            color: #333;
        }

        .no-interviews p {
            color: #666;
        }

        .table-wrapper {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #f1f3f6;
            color: #333;
            padding: 14px;
            text-align: left;
            border-bottom: 2px solid #ddd;
        }

        td {
            padding: 14px;
            border-bottom: 1px solid #ddd;
            color: #444;
        }

        tr:hover {
            background: #fafafa;
        }

        .mode {
            font-weight: bold;
        }

        .online {
            color: #0066cc;
        }

        .offline {
            color: #008000;
        }

        .status {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: bold;
        }

        .pending {
            background: #fff3cd;
            color: #856404;
        }

        .passed {
            background: #d4edda;
            color: #155724;
        }

        .failed {
            background: #f8d7da;
            color: #721c24;
        }

        .meeting-link {
            display: inline-block;
            padding: 7px 12px;
            background: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .meeting-link:hover {
            background: #0056b3;
        }

        .not-available {
            color: #888;
        }

    </style>

</head>

<body>

<div class="container">

    <div class="header">

        <h1>My Interviews</h1>

        <a class="back-button"
           href="<%= request.getContextPath() %>/student/dashboard.jsp">
            Back to Dashboard
        </a>

    </div>


    <div class="card">

        <%
            if (interviews == null || interviews.isEmpty()) {
        %>

            <div class="no-interviews">

                <h2>No Interviews Scheduled</h2>

                <p>
                    You don't have any scheduled interviews yet.
                </p>

                <p>
                    Once a recruiter schedules an interview,
                    it will appear here.
                </p>

            </div>

        <%
            } else {
        %>

            <div class="table-wrapper">

                <table>

                    <thead>

                    <tr>
                        <th>#</th>
                        <th>Company</th>
                        <th>Job</th>
                        <th>Interview Date</th>
                        <th>Mode</th>
                        <th>Meeting</th>
                        <th>Result</th>
                    </tr>

                    </thead>

                    <tbody>

                    <%
                        int count = 1;

                        for (Interview interview : interviews) {
                    %>

                    <tr>

                        <td>
                            <%= count++ %>
                        </td>

                        <td>
                            <strong>
                                <%= interview.getCompanyName() %>
                            </strong>
                        </td>

                        <td>
                            <%= interview.getJobTitle() %>
                        </td>

                        <td>
                            <%= interview.getInterviewDate() %>
                        </td>

                        <td>

                            <%
                                if ("ONLINE".equalsIgnoreCase(
                                        interview.getMode())) {
                            %>

                                <span class="mode online">
                                    ONLINE
                                </span>

                            <%
                                } else {
                            %>

                                <span class="mode offline">
                                    OFFLINE
                                </span>

                            <%
                                }
                            %>

                        </td>

                        <td>

                            <%
                                String meetingLink =
                                        interview.getMeetingLink();

                                if (meetingLink != null &&
                                        !meetingLink.trim().isEmpty()) {
                            %>

                                <a class="meeting-link"
                                   href="<%= meetingLink %>"
                                   target="_blank">
                                    Join Interview
                                </a>

                            <%
                                } else {
                            %>

                                <span class="not-available">
                                    Not Available
                                </span>

                            <%
                                }
                            %>

                        </td>

                        <td>

                            <%
                                String result =
                                        interview.getResult();

                                if ("PASSED".equalsIgnoreCase(result)) {
                            %>

                                <span class="status passed">
                                    PASSED
                                </span>

                            <%
                                } else if ("FAILED".equalsIgnoreCase(result)) {
                            %>

                                <span class="status failed">
                                    FAILED
                                </span>

                            <%
                                } else {
                            %>

                                <span class="status pending">
                                    PENDING
                                </span>

                            <%
                                }
                            %>

                        </td>

                    </tr>

                    <%
                        }
                    %>

                    </tbody>

                </table>

            </div>

        <%
            }
        %>

    </div>

</div>

</body>

</html>
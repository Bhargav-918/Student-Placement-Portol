<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="org.example.placement.model.Interview" %>

<%
    if (session.getAttribute("userId") == null ||
            !"RECRUITER".equals(session.getAttribute("userRole"))) {

        response.sendRedirect(
                request.getContextPath() + "/login.jsp"
        );
        return;
    }

    List<Interview> interviews =
            (List<Interview>) request.getAttribute("interviews");

    String success =
            request.getParameter("success");

    String error =
            request.getParameter("error");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Recruiter Interviews</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f7fb;
        }

        .container {
            width: 94%;
            max-width: 1250px;
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

        .message {
            padding: 12px 16px;
            border-radius: 6px;
            margin-bottom: 20px;
        }

        .success {
            background: #d4edda;
            color: #155724;
        }

        .error {
            background: #f8d7da;
            color: #721c24;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
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
            vertical-align: middle;
        }

        tr:hover {
            background: #fafafa;
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

        .result-form {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .result-form select {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .update-button {
            padding: 8px 12px;
            border: none;
            border-radius: 5px;
            background: #333;
            color: white;
            cursor: pointer;
        }

        .update-button:hover {
            background: #111;
        }

        .no-interviews {
            text-align: center;
            padding: 50px 20px;
        }

        .no-interviews h2 {
            margin-bottom: 10px;
        }

        .no-interviews p {
            color: #666;
        }

    </style>

</head>

<body>

<div class="container">

    <div class="header">

        <h1>Recruiter Interviews</h1>

        <a class="back-button"
           href="<%= request.getContextPath() %>/recruiter/dashboard.jsp">
            Back to Dashboard
        </a>

    </div>


    <% if (success != null) { %>

        <div class="message success">
            <%= success %>
        </div>

    <% } %>


    <% if (error != null) { %>

        <div class="message error">
            <%= error %>
        </div>

    <% } %>


    <div class="card">

        <%
            if (interviews == null || interviews.isEmpty()) {
        %>

            <div class="no-interviews">

                <h2>No Interviews Scheduled</h2>

                <p>
                    Interviews scheduled for your applicants
                    will appear here.
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
                        <th>Student</th>
                        <th>Job</th>
                        <th>Company</th>
                        <th>Interview Date</th>
                        <th>Mode</th>
                        <th>Meeting</th>
                        <th>Result</th>
                        <th>Update Result</th>
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
                                <%= interview.getStudentName() %>
                            </strong>
                        </td>

                        <td>
                            <%= interview.getJobTitle() %>
                        </td>

                        <td>
                            <%= interview.getCompanyName() %>
                        </td>

                        <td>
                            <%= interview.getInterviewDate() %>
                        </td>

                        <td>
                            <%= interview.getMode() %>
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
                                    Open Link
                                </a>

                            <%
                                } else {
                            %>

                                <span>Not Available</span>

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

                        <td>

                            <form class="result-form"
                                  action="<%= request.getContextPath() %>/recruiter/update-interview-result"
                                  method="post">

                                <input type="hidden"
                                       name="interviewId"
                                       value="<%= interview.getId() %>">

                                <select name="result">

                                    <option value="PENDING"
                                        <%= "PENDING".equals(interview.getResult())
                                                ? "selected" : "" %>>
                                        Pending
                                    </option>

                                    <option value="PASSED"
                                        <%= "PASSED".equals(interview.getResult())
                                                ? "selected" : "" %>>
                                        Passed
                                    </option>

                                    <option value="FAILED"
                                        <%= "FAILED".equals(interview.getResult())
                                                ? "selected" : "" %>>
                                        Failed
                                    </option>

                                </select>

                                <button type="submit"
                                        class="update-button">
                                    Update
                                </button>

                            </form>

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
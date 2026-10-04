<%@ page import="java.util.List" %>
<%@ page import="org.example.placement.model.Job" %>
<%@ page import="org.example.placement.model.Student" %>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    List<Job> jobs =
            (List<Job>) request.getAttribute("jobs");

    Student student =
            (Student) request.getAttribute("student");
%>

<!DOCTYPE html>
<html>
<head>

    <title>Placement Drives</title>

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
            max-width: 1000px;
            margin: 30px auto;
        }

        .message {
            padding: 12px 15px;
            margin-bottom: 20px;
            border-radius: 6px;
            background: #e5f7e5;
            color: #176b17;
        }

        .error {
            padding: 12px 15px;
            margin-bottom: 20px;
            border-radius: 6px;
            background: #ffe5e5;
            color: #b00020;
        }

        .job-card {
            background: white;
            padding: 25px;
            margin-bottom: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }

        .job-card h2 {
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

        .eligible {
            margin-top: 15px;
            padding: 12px;
            background: #e5f7e5;
            color: #176b17;
            border-radius: 6px;
            font-weight: bold;
        }

        .not-eligible {
            margin-top: 15px;
            padding: 12px;
            background: #ffe5e5;
            color: #b00020;
            border-radius: 6px;
            font-weight: bold;
        }

        .apply-btn {
            margin-top: 15px;
            padding: 12px 25px;
            border: none;
            border-radius: 6px;
            background: #1f4e79;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        .apply-btn:hover {
            background: #163a5c;
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

    </style>

</head>

<body>

<div class="header">
    <h1>Placement Drives</h1>
</div>

<div class="container">

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


    <% if (jobs == null || jobs.isEmpty()) { %>

        <div class="job-card">
            <h2>No placement drives available.</h2>
            <p>Please check again later.</p>
        </div>

    <% } else { %>


        <% for (Job job : jobs) { %>

            <%
                boolean eligible = false;

                if (student != null) {

                    boolean cgpaEligible =
                            student.getCgpa() >= job.getMinCgpa();

                    boolean branchEligible =
                            job.getEligibleBranch()
                                    .equalsIgnoreCase(
                                            student.getBranch()
                                    );

                    boolean yearEligible =
                            student.getGraduationYear()
                                    == job.getGraduationYear();

                    eligible =
                            cgpaEligible &&
                            branchEligible &&
                            yearEligible;
                }
            %>


            <div class="job-card">

                <h2>
                    <%= job.getTitle() %>
                </h2>

                <div class="company">
                    <%= job.getCompanyName() %>
                </div>

                <div class="details">

                    <p>
                        <strong>Description:</strong>
                        <%= job.getDescription() %>
                    </p>

                    <p>
                        <strong>Salary:</strong>
                        <%= job.getSalary() %>
                    </p>

                    <p>
                        <strong>Location:</strong>
                        <%= job.getLocation() %>
                    </p>

                    <p>
                        <strong>Minimum CGPA:</strong>
                        <%= job.getMinCgpa() %>
                    </p>

                    <p>
                        <strong>Eligible Branch:</strong>
                        <%= job.getEligibleBranch() %>
                    </p>

                    <p>
                        <strong>Graduation Year:</strong>
                        <%= job.getGraduationYear() %>
                    </p>

                    <p>
                        <strong>Application Deadline:</strong>
                        <%= job.getDeadline() %>
                    </p>

                </div>


                <% if (student == null) { %>

                    <div class="not-eligible">
                        Please complete your student profile first.
                    </div>

                <% } else if (eligible) { %>

                    <div class="eligible">
                        ✓ You are eligible for this job.
                    </div>

                    <form action="<%= request.getContextPath() %>/student/apply"
                          method="post">

                        <input type="hidden"
                               name="jobId"
                               value="<%= job.getId() %>">

                        <button type="submit"
                                class="apply-btn">

                            Apply Now

                        </button>

                    </form>

                <% } else { %>

                    <div class="not-eligible">
                        ✗ You are not eligible for this job.
                    </div>

                <% } %>

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
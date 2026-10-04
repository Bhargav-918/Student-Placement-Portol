<%@ page contentType="text/html;charset=UTF-8" %>

<%
    HttpSession currentSession =
            request.getSession(false);

    if (currentSession == null ||
            currentSession.getAttribute("userId") == null ||
            !"RECRUITER".equals(
                    currentSession.getAttribute("userRole"))) {

        response.sendRedirect(
                request.getContextPath() + "/login.jsp"
        );
        return;
    }

    String userName =
            (String) currentSession.getAttribute("userName");

    String userEmail =
            (String) currentSession.getAttribute("userEmail");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Recruiter Dashboard</title>

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

        /* Header */

        .header {
            background: #1e3a8a;
            color: white;

            padding: 20px 40px;

            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header-title {
            font-size: 24px;
            font-weight: bold;
        }

        .logout {
            text-decoration: none;
            color: white;

            background: #dc2626;

            padding: 9px 18px;

            border-radius: 6px;

            font-size: 14px;
        }

        .logout:hover {
            background: #b91c1c;
        }

        /* Main */

        .container {
            width: 92%;
            max-width: 1150px;
            margin: 35px auto;
        }

        /* Welcome */

        .welcome-card {
            background: white;

            border-radius: 14px;

            padding: 30px;

            box-shadow:
                0 4px 15px rgba(0,0,0,0.08);

            margin-bottom: 30px;
        }

        .welcome-card h1 {
            margin: 0 0 10px;

            color: #1e3a8a;

            font-size: 30px;
        }

        .welcome-card p {
            margin: 7px 0;

            color: #6b7280;
        }

        .welcome-card strong {
            color: #374151;
        }

        /* Section */

        .section-title {
            margin-bottom: 18px;

            color: #1e3a8a;

            font-size: 22px;
        }

        /* Cards */

        .cards {
            display: grid;

            grid-template-columns:
                repeat(auto-fit, minmax(230px, 1fr));

            gap: 20px;
        }

        .card {
            background: white;

            border-radius: 12px;

            padding: 25px;

            box-shadow:
                0 4px 15px rgba(0,0,0,0.08);

            transition:
                transform 0.2s,
                box-shadow 0.2s;
        }

        .card:hover {
            transform: translateY(-5px);

            box-shadow:
                0 8px 22px rgba(0,0,0,0.12);
        }

        .card-icon {
            font-size: 38px;

            margin-bottom: 15px;
        }

        .card h3 {
            margin: 0 0 10px;

            color: #1f2937;

            font-size: 19px;
        }

        .card p {
            color: #6b7280;

            font-size: 14px;

            line-height: 1.5;

            min-height: 45px;
        }

        .card-button {
            display: inline-block;

            width: 100%;

            margin-top: 12px;

            text-align: center;

            text-decoration: none;

            background: #2563eb;

            color: white;

            padding: 11px 15px;

            border-radius: 7px;

            font-size: 14px;

            font-weight: bold;
        }

        .card-button:hover {
            background: #1d4ed8;
        }

        /* Footer */

        .footer {
            text-align: center;

            margin-top: 45px;

            padding-bottom: 25px;

            color: #6b7280;

            font-size: 13px;
        }

        /* Tablet */

        @media (max-width: 800px) {

            .header {
                padding: 18px 25px;
            }

            .cards {
                grid-template-columns:
                    repeat(2, 1fr);
            }

        }

        /* Mobile */

        @media (max-width: 550px) {

            .header {
                padding: 16px 20px;
            }

            .header-title {
                font-size: 19px;
            }

            .container {
                width: 94%;

                margin-top: 25px;
            }

            .welcome-card {
                padding: 22px;
            }

            .welcome-card h1 {
                font-size: 25px;
            }

            .cards {
                grid-template-columns: 1fr;
            }

        }

    </style>

</head>

<body>


<!-- Header -->

<div class="header">

    <div class="header-title">
        🏢 Student Placement Portal
    </div>

    <a class="logout"
       href="<%= request.getContextPath() %>/logout">
        Logout
    </a>

</div>


<!-- Main -->

<div class="container">


    <!-- Welcome -->

    <div class="welcome-card">

        <h1>
            Welcome, <%= userName %> 👋
        </h1>

        <p>
            Manage your company's placement activities
            from your recruiter dashboard.
        </p>

        <p>
            Email:
            <strong><%= userEmail %></strong>
        </p>

    </div>


    <!-- Recruiter Portal -->

    <h2 class="section-title">
        Recruiter Portal
    </h2>


    <div class="cards">


        <!-- Company Profile -->

        <div class="card">

            <div class="card-icon">
                🏢
            </div>

            <h3>
                Company Profile
            </h3>

            <p>
                Create or update your company
                information and website details.
            </p>

            <a class="card-button"
               href="<%= request.getContextPath() %>/recruiter/profile">
                Company Profile
            </a>

        </div>


        <!-- Post Job -->

        <div class="card">

            <div class="card-icon">
                ➕
            </div>

            <h3>
                Post New Job
            </h3>

            <p>
                Create a new placement opportunity
                for eligible students.
            </p>

            <a class="card-button"
               href="<%= request.getContextPath() %>/recruiter/post-job.jsp">
                Post New Job
            </a>

        </div>


        <!-- Manage Jobs -->

        <div class="card">

            <div class="card-icon">
                💼
            </div>

            <h3>
                Manage Jobs
            </h3>

            <p>
                View, edit and close your
                posted placement jobs.
            </p>

            <a class="card-button"
               href="<%= request.getContextPath() %>/recruiter/jobs">
                Manage Jobs
            </a>

        </div>


        <!-- Applicants -->

        <div class="card">

            <div class="card-icon">
                👨‍🎓
            </div>

            <h3>
                Applicants
            </h3>

            <p>
                View students who applied for
                your company's jobs.
            </p>

            <a class="card-button"
               href="<%= request.getContextPath() %>/recruiter/applications">
                View Applicants
            </a>

        </div>


        <!-- Interviews -->

        <div class="card">

            <div class="card-icon">
                🎤
            </div>

            <h3>
                Interviews
            </h3>

            <p>
                Schedule interviews and manage
                interview results.
            </p>

            <a class="card-button"
               href="<%= request.getContextPath() %>/recruiter/interviews">
                View Interviews
            </a>

        </div>


    </div>


    <!-- Footer -->

    <div class="footer">

        Student Placement Portal © 2026

    </div>

</div>

</body>

</html>
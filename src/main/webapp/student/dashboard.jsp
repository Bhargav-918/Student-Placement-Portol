
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    if (session.getAttribute("userId") == null ||
            !"STUDENT".equals(session.getAttribute("userRole"))) {

        response.sendRedirect(
                request.getContextPath() + "/login.jsp"
        );
        return;
    }

    String userName =
            (String) session.getAttribute("userName");

    String userEmail =
            (String) session.getAttribute("userEmail");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Student Dashboard</title>

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

        .welcome-card {
            background: white;
            border-radius: 14px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
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

            box-shadow: 0 4px 15px rgba(0,0,0,0.08);

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
            min-height: 42px;
        }

        .card-button {
            display: inline-block;
            margin-top: 12px;

            text-decoration: none;

            background: #2563eb;
            color: white;

            padding: 10px 17px;

            border-radius: 6px;

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

        /* Mobile */

        @media (max-width: 600px) {

            .header {
                padding: 18px 20px;
            }

            .header-title {
                font-size: 20px;
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

        }

    </style>

</head>

<body>

<!-- Header -->

<div class="header">

    <div class="header-title">
        🎓 Student Placement Portal
    </div>

    <a href="<%= request.getContextPath() %>/logout"
       class="logout">
        Logout
    </a>

</div>


<!-- Main Content -->

<div class="container">


    <!-- Welcome -->

    <div class="welcome-card">

        <h1>
            Welcome, <%= userName %> 👋
        </h1>

        <p>
            Manage your placement activities
            from your student dashboard.
        </p>

        <p>
            Email:
            <strong><%= userEmail %></strong>
        </p>

    </div>


    <!-- Student Portal -->

    <h2 class="section-title">
        Student Portal
    </h2>


    <div class="cards">


        <!-- Profile -->

        <div class="card">

            <div class="card-icon">
                👤
            </div>

            <h3>
                My Profile
            </h3>

            <p>
                View and update your personal,
                academic and resume information.
            </p>

            <a href="<%= request.getContextPath() %>/student/profile"
               class="card-button">
                Open Profile
            </a>

        </div>


        <!-- Jobs -->

        <div class="card">

            <div class="card-icon">
                💼
            </div>

            <h3>
                Placement Drives
            </h3>

            <p>
                Explore available jobs and
                check your eligibility before applying.
            </p>

            <a href="<%= request.getContextPath() %>/student/jobs"
               class="card-button">
                View Jobs
            </a>

        </div>


        <!-- Applications -->

        <div class="card">

            <div class="card-icon">
                📄
            </div>

            <h3>
                My Applications
            </h3>

            <p>
                Track your job applications and
                their current status.
            </p>

            <a href="<%= request.getContextPath() %>/student/applications"
               class="card-button">
                View Applications
            </a>

        </div>


        <!-- Interviews -->

        <div class="card">

            <div class="card-icon">
                🎤
            </div>

            <h3>
                My Interviews
            </h3>

            <p>
                View scheduled interviews,
                meeting details and interview results.
            </p>

            <a href="<%= request.getContextPath() %>/student/interviews"
               class="card-button">
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
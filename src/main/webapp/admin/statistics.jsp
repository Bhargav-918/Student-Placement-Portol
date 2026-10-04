<%@ page contentType="text/html;charset=UTF-8" %>

<%
    // Admin authentication check
    if (session.getAttribute("userId") == null ||
            !"ADMIN".equals(session.getAttribute("userRole"))) {

        response.sendRedirect(
                request.getContextPath() + "/login.jsp"
        );
        return;
    }

    int totalStudents =
            (Integer) request.getAttribute("totalStudents");

    int totalRecruiters =
            (Integer) request.getAttribute("totalRecruiters");

    int totalJobs =
            (Integer) request.getAttribute("totalJobs");

    int totalApplications =
            (Integer) request.getAttribute("totalApplications");

    int shortlistedApplications =
            (Integer) request.getAttribute("shortlistedApplications");

    int selectedApplications =
            (Integer) request.getAttribute("selectedApplications");

    int rejectedApplications =
            (Integer) request.getAttribute("rejectedApplications");

    int totalInterviews =
            (Integer) request.getAttribute("totalInterviews");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Admin Statistics</title>

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
            padding: 25px 35px;
        }

        .header h1 {
            margin: 0;
            font-size: 28px;
        }

        .header p {
            margin: 8px 0 0;
            opacity: 0.9;
        }

        .container {
            width: 92%;
            max-width: 1200px;
            margin: 35px auto;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
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

        .section-title {
            margin: 30px 0 15px;
            color: #374151;
            font-size: 20px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns:
                repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            transition: transform 0.2s;
        }

        .stat-card:hover {
            transform: translateY(-4px);
        }

        .icon {
            font-size: 32px;
            margin-bottom: 12px;
        }

        .label {
            color: #6b7280;
            font-size: 14px;
            margin-bottom: 8px;
        }

        .number {
            font-size: 34px;
            font-weight: bold;
            color: #1e3a8a;
        }

        .application-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }

        .application-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 0;
            border-bottom: 1px solid #e5e7eb;
        }

        .application-row:last-child {
            border-bottom: none;
        }

        .application-label {
            font-size: 15px;
            color: #374151;
        }

        .application-number {
            font-size: 24px;
            font-weight: bold;
            color: #1e3a8a;
        }

        .footer {
            text-align: center;
            margin-top: 40px;
            color: #6b7280;
            font-size: 13px;
        }

        @media (max-width: 600px) {

            .container {
                width: 94%;
            }

            .top-bar {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .application-row {
                gap: 15px;
            }

        }

    </style>

</head>

<body>

<div class="header">

    <h1>Admin Panel</h1>

    <p>Placement Portal Statistics</p>

</div>

<div class="container">

    <div class="top-bar">

        <h2>Dashboard Statistics</h2>

        <a href="<%= request.getContextPath() %>/admin/dashboard.jsp"
           class="back-button">
            ← Back to Dashboard
        </a>

    </div>


    <!-- Main Statistics -->

    <h3 class="section-title">
        Overall Statistics
    </h3>

    <div class="stats-grid">

        <div class="stat-card">

            <div class="icon">👨‍🎓</div>

            <div class="label">
                Total Students
            </div>

            <div class="number">
                <%= totalStudents %>
            </div>

        </div>


        <div class="stat-card">

            <div class="icon">🏢</div>

            <div class="label">
                Total Recruiters
            </div>

            <div class="number">
                <%= totalRecruiters %>
            </div>

        </div>


        <div class="stat-card">

            <div class="icon">💼</div>

            <div class="label">
                Total Jobs
            </div>

            <div class="number">
                <%= totalJobs %>
            </div>

        </div>


        <div class="stat-card">

            <div class="icon">📄</div>

            <div class="label">
                Total Applications
            </div>

            <div class="number">
                <%= totalApplications %>
            </div>

        </div>


        <div class="stat-card">

            <div class="icon">🎤</div>

            <div class="label">
                Total Interviews
            </div>

            <div class="number">
                <%= totalInterviews %>
            </div>

        </div>

    </div>


    <!-- Application Statistics -->

    <h3 class="section-title">
        Application Status
    </h3>

    <div class="application-card">

        <div class="application-row">

            <span class="application-label">
                📌 Shortlisted Applications
            </span>

            <span class="application-number">
                <%= shortlistedApplications %>
            </span>

        </div>


        <div class="application-row">

            <span class="application-label">
                ✅ Selected Applications
            </span>

            <span class="application-number">
                <%= selectedApplications %>
            </span>

        </div>


        <div class="application-row">

            <span class="application-label">
                ❌ Rejected Applications
            </span>

            <span class="application-number">
                <%= rejectedApplications %>
            </span>

        </div>

    </div>


    <div class="footer">

        Student Placement Portal © 2026

    </div>

</div>

</body>

</html>
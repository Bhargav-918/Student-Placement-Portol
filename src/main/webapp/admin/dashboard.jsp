<%@ page contentType="text/html;charset=UTF-8" %>

<%
    if (session.getAttribute("userId") == null ||
            !"ADMIN".equals(session.getAttribute("userRole"))) {

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

    <title>Admin Dashboard</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f7fb;
        }

        .admin-container {
            width: 90%;
            max-width: 1200px;
            margin: 40px auto;
        }

        .header {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
            margin-bottom: 25px;
        }

        .header h1 {
            margin: 0 0 10px;
        }

        .header p {
            margin: 5px 0;
            color: #555;
        }

        .cards {
            display: grid;
            grid-template-columns:
                repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
            text-align: center;
        }

        .card h2 {
            margin-top: 0;
        }

        .card p {
            color: #666;
            min-height: 40px;
        }

        .button {
            display: inline-block;
            padding: 10px 18px;
            background: #2563eb;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            margin-top: 10px;
        }

        .button:hover {
            background: #1d4ed8;
        }

        .logout {
            display: inline-block;
            margin-top: 25px;
            color: #dc2626;
            text-decoration: none;
            font-weight: bold;
        }

    </style>

</head>

<body>

<div class="admin-container">

    <div class="header">

        <h1>Admin Dashboard 🛡️</h1>

        <h2>
            Welcome, <%= userName %> 👋
        </h2>

        <p>
            Email:
            <strong><%= userEmail %></strong>
        </p>

        <p>
            Role:
            <strong>ADMIN</strong>
        </p>

    </div>


    <div class="cards">

        <!-- Students -->

        <div class="card">

            <h2>👨‍🎓</h2>

            <h3>Students</h3>

            <p>
                View and manage registered students.
            </p>

            <a class="button"
               href="<%= request.getContextPath() %>/admin/students">

                Manage Students

            </a>

        </div>


        <!-- Recruiters -->

        <div class="card">

            <h2>🏢</h2>

            <h3>Recruiters</h3>

            <p>
                View and manage recruiters and companies.
            </p>

            <a class="button"
               href="<%= request.getContextPath() %>/admin/recruiters">

                Manage Recruiters

            </a>

        </div>


        <!-- Jobs -->

        <div class="card">

            <h2>💼</h2>

            <h3>Jobs</h3>

            <p>
                View all placement jobs posted by recruiters.
            </p>

            <a class="button"
               href="<%= request.getContextPath() %>/admin/jobs">

                Manage Jobs

            </a>

        </div>


        <!-- Applications -->

        <div class="card">

            <h2>📄</h2>

            <h3>Applications</h3>

            <p>
                View student applications and their status.
            </p>

            <a class="button"
               href="<%= request.getContextPath() %>/admin/applications">

                View Applications

            </a>

        </div>


        <!-- Statistics -->

        <div class="card">

            <h2>📊</h2>

            <h3>Statistics</h3>

            <p>
                View placement and portal statistics.
            </p>

            <a class="button"
               href="<%= request.getContextPath() %>/admin/statistics">

                View Statistics

            </a>

        </div>

    </div>


    <a class="logout"
       href="<%= request.getContextPath() %>/logout">

        Logout

    </a>

</div>

</body>
</html>
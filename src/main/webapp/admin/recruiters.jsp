<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.placement.model.Company" %>

<%
    // Admin authentication
    if (session.getAttribute("userId") == null ||
            !"ADMIN".equals(session.getAttribute("userRole"))) {

        response.sendRedirect(
                request.getContextPath() + "/login.jsp"
        );
        return;
    }

    List<Company> companies =
            (List<Company>) request.getAttribute("companies");
%>

<!DOCTYPE html>
<html>

<head>

    <title>Manage Recruiters</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f7fb;
        }

        .container {
            width: 94%;
            max-width: 1200px;
            margin: 35px auto;
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
            color: #666;
        }

        .table-container {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th,
        td {
            padding: 13px;
            text-align: left;
            border-bottom: 1px solid #e5e7eb;
        }

        th {
            background: #f1f5f9;
            font-weight: bold;
        }

        tr:hover {
            background: #f8fafc;
        }

        .description {
            max-width: 300px;
            line-height: 1.5;
        }

        .website {
            color: #2563eb;
            text-decoration: none;
        }

        .website:hover {
            text-decoration: underline;
        }

        .no-data {
            text-align: center;
            padding: 40px;
            color: #666;
        }

        .button {
            display: inline-block;
            padding: 10px 18px;
            background: #2563eb;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            margin-top: 20px;
        }

        .button:hover {
            background: #1d4ed8;
        }

    </style>

</head>

<body>

<div class="container">

    <div class="header">

        <h1>🏢 Manage Recruiters</h1>

        <p>
            View all registered companies and recruiter profiles.
        </p>

    </div>


    <div class="table-container">

        <% if (companies == null || companies.isEmpty()) { %>

            <div class="no-data">

                <h3>No Recruiters Found</h3>

                <p>
                    There are currently no company profiles
                    registered in the portal.
                </p>

            </div>

        <% } else { %>

            <table>

                <thead>

                <tr>
                    <th>#</th>
                    <th>Company ID</th>
                    <th>User ID</th>
                    <th>Company Name</th>
                    <th>Description</th>
                    <th>Website</th>
                </tr>

                </thead>

                <tbody>

                <%
                    int count = 1;

                    for (Company company : companies) {
                %>

                <tr>

                    <td>
                        <%= count++ %>
                    </td>

                    <td>
                        <%= company.getId() %>
                    </td>

                    <td>
                        <%= company.getUserId() %>
                    </td>

                    <td>
                        <strong>
                            <%= company.getCompanyName() %>
                        </strong>
                    </td>

                    <td class="description">

                        <%= company.getDescription() != null &&
                            !company.getDescription().isBlank()
                                ? company.getDescription()
                                : "-" %>

                    </td>

                    <td>

                        <% if (company.getWebsite() != null &&
                               !company.getWebsite().isBlank()) { %>

                            <a class="website"
                               href="<%= company.getWebsite() %>"
                               target="_blank">

                                Visit Website

                            </a>

                        <% } else { %>

                            -

                        <% } %>

                    </td>

                </tr>

                <%
                    }
                %>

                </tbody>

            </table>

        <% } %>

    </div>


    <a class="button"
       href="<%= request.getContextPath() %>/admin/dashboard.jsp">

        ← Back to Admin Dashboard

    </a>

</div>

</body>

</html>
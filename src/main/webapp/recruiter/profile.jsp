<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.example.placement.model.Company" %>

<%
    HttpSession currentSession = request.getSession(false);

    if (currentSession == null ||
            currentSession.getAttribute("userId") == null ||
            !"RECRUITER".equals(currentSession.getAttribute("userRole"))) {

        response.sendRedirect(
                request.getContextPath() + "/login.jsp"
        );
        return;
    }

    Company company =
            (Company) request.getAttribute("company");

    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Company Profile</title>

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

        .header a {
            color: white;
            text-decoration: none;
            background: #2563eb;
            padding: 10px 16px;
            border-radius: 7px;
        }

        .container {
            width: 90%;
            max-width: 800px;
            margin: 40px auto;
        }

        .card {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
        }

        h1 {
            margin-top: 0;
            color: #1e3a8a;
        }

        .message {
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 7px;
        }

        .success {
            background: #dcfce7;
            color: #166534;
        }

        .error {
            background: #fee2e2;
            color: #991b1b;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
        }

        input,
        textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #d1d5db;
            border-radius: 7px;
            font-size: 15px;
        }

        textarea {
            min-height: 130px;
            resize: vertical;
        }

        button {
            width: 100%;
            border: none;
            padding: 14px;
            background: #2563eb;
            color: white;
            border-radius: 7px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background: #1d4ed8;
        }

        .required {
            color: red;
        }

    </style>

</head>

<body>

<div class="header">

    <h2>Recruiter Portal</h2>

    <a href="<%= request.getContextPath() %>/recruiter/dashboard.jsp">
        Dashboard
    </a>

</div>


<div class="container">

    <div class="card">

        <h1>Company Profile</h1>

        <%
            if (success != null) {
        %>

            <div class="message success">
                <%= success.replace("+", " ") %>
            </div>

        <%
            }

            if (error != null) {
        %>

            <div class="message error">
                <%= error.replace("+", " ") %>
            </div>

        <%
            }
        %>


        <form method="post"
              action="<%= request.getContextPath() %>/recruiter/profile">

            <div class="form-group">

                <label>
                    Company Name
                    <span class="required">*</span>
                </label>

                <input type="text"
                       name="companyName"
                       value="<%= company != null &&
                                company.getCompanyName() != null
                                ? company.getCompanyName()
                                : "" %>"
                       placeholder="Enter company name"
                       required>

            </div>


            <div class="form-group">

                <label>
                    Company Description
                </label>

                <textarea
                        name="description"
                        placeholder="Describe your company"><%= company != null &&
                        company.getDescription() != null
                        ? company.getDescription()
                        : "" %></textarea>

            </div>


            <div class="form-group">

                <label>
                    Website
                </label>

                <input type="url"
                       name="website"
                       value="<%= company != null &&
                                company.getWebsite() != null
                                ? company.getWebsite()
                                : "" %>"
                       placeholder="https://example.com">

            </div>


            <button type="submit">
                Save Company Profile
            </button>

        </form>

    </div>

</div>

</body>

</html>
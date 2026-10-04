<%@ page contentType="text/html;charset=UTF-8" %>
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

    Job job = (Job) request.getAttribute("job");

    if (job == null) {
        response.sendRedirect(
                request.getContextPath() + "/recruiter/jobs"
        );
        return;
    }

    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Edit Job</title>

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

            box-shadow:
                    0 5px 20px rgba(0, 0, 0, 0.08);
        }

        h1 {
            margin-top: 0;
            color: #1e3a8a;
        }

        .subtitle {
            color: #6b7280;
            margin-bottom: 25px;
        }

        .error {
            background: #fee2e2;
            color: #991b1b;
            padding: 12px;
            border-radius: 7px;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 7px;
        }

        .required {
            color: red;
        }

        input,
        textarea,
        select {
            width: 100%;
            padding: 12px;

            border: 1px solid #d1d5db;
            border-radius: 7px;

            font-size: 15px;
            font-family: Arial, sans-serif;
        }

        input:focus,
        textarea:focus,
        select:focus {
            outline: none;
            border-color: #2563eb;
        }

        textarea {
            min-height: 140px;
            resize: vertical;
        }

        .buttons {
            display: flex;
            gap: 12px;
            margin-top: 25px;
        }

        button {
            flex: 1;
            border: none;

            padding: 13px;

            border-radius: 7px;

            font-size: 16px;
            font-weight: bold;

            cursor: pointer;
        }

        .save {
            background: #2563eb;
            color: white;
        }

        .save:hover {
            background: #1d4ed8;
        }

        .cancel {
            background: #e5e7eb;
            color: #374151;

            text-decoration: none;

            display: flex;
            align-items: center;
            justify-content: center;
        }

        .cancel:hover {
            background: #d1d5db;
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

        <h1>Edit Job</h1>

        <p class="subtitle">
            Update the details of your job posting.
        </p>


        <% if (error != null) { %>

            <div class="error">
                <%= error.replace("+", " ") %>
            </div>

        <% } %>


        <form method="post"
              action="<%= request.getContextPath() %>/recruiter/edit-job">


            <!-- JOB ID -->

            <input
                    type="hidden"
                    name="id"
                    value="<%= job.getId() %>"
            >


            <!-- JOB TITLE -->

            <div class="form-group">

                <label>
                    Job Title
                    <span class="required">*</span>
                </label>

                <input
                        type="text"
                        name="title"
                        value="<%= job.getTitle() != null
                                ? job.getTitle()
                                : "" %>"
                        placeholder="Example: Software Engineer Intern"
                        required
                >

            </div>


            <!-- DESCRIPTION -->

            <div class="form-group">

                <label>
                    Job Description
                </label>

                <textarea
                        name="description"
                        placeholder="Enter job description"><%= job.getDescription() != null
                        ? job.getDescription()
                        : "" %></textarea>

            </div>


            <!-- SALARY -->

            <div class="form-group">

                <label>
                    Salary
                </label>

                <input
                        type="text"
                        name="salary"
                        value="<%= job.getSalary() != null
                                ? job.getSalary()
                                : "" %>"
                        placeholder="Example: ₹25,000/month"
                >

            </div>


            <!-- LOCATION -->

            <div class="form-group">

                <label>
                    Location
                </label>

                <input
                        type="text"
                        name="location"
                        value="<%= job.getLocation() != null
                                ? job.getLocation()
                                : "" %>"
                        placeholder="Example: Hyderabad"
                >

            </div>


            <!-- CGPA -->

            <div class="form-group">

                <label>
                    Minimum CGPA
                    <span class="required">*</span>
                </label>

                <input
                        type="number"
                        name="minCgpa"
                        min="0"
                        max="10"
                        step="0.01"
                        value="<%= job.getMinCgpa() %>"
                        required
                >

            </div>


            <!-- BRANCH -->

            <div class="form-group">

                <label>
                    Eligible Branch
                    <span class="required">*</span>
                </label>

                <select
                        name="eligibleBranch"
                        required
                >

                    <option value="">
                        Select Branch
                    </option>

                    <option value="CSE"
                        <%= "CSE".equalsIgnoreCase(
                                job.getEligibleBranch())
                                ? "selected"
                                : "" %>>
                        CSE
                    </option>

                    <option value="ECE"
                        <%= "ECE".equalsIgnoreCase(
                                job.getEligibleBranch())
                                ? "selected"
                                : "" %>>
                        ECE
                    </option>

                    <option value="EEE"
                        <%= "EEE".equalsIgnoreCase(
                                job.getEligibleBranch())
                                ? "selected"
                                : "" %>>
                        EEE
                    </option>

                    <option value="MECH"
                        <%= "MECH".equalsIgnoreCase(
                                job.getEligibleBranch())
                                ? "selected"
                                : "" %>>
                        MECH
                    </option>

                    <option value="CIVIL"
                        <%= "CIVIL".equalsIgnoreCase(
                                job.getEligibleBranch())
                                ? "selected"
                                : "" %>>
                        CIVIL
                    </option>

                    <option value="IT"
                        <%= "IT".equalsIgnoreCase(
                                job.getEligibleBranch())
                                ? "selected"
                                : "" %>>
                        IT
                    </option>

                </select>

            </div>


            <!-- GRADUATION YEAR -->

            <div class="form-group">

                <label>
                    Graduation Year
                    <span class="required">*</span>
                </label>

                <input
                        type="number"
                        name="graduationYear"
                        min="2020"
                        max="2100"
                        value="<%= job.getGraduationYear() %>"
                        required
                >

            </div>


            <!-- DEADLINE -->

            <div class="form-group">

                <label>
                    Application Deadline
                    <span class="required">*</span>
                </label>

                <input
                        type="date"
                        name="deadline"
                        value="<%= job.getDeadline() %>"
                        required
                >

            </div>


            <!-- BUTTONS -->

            <div class="buttons">

                <a
                        class="cancel"
                        href="<%= request.getContextPath() %>/recruiter/jobs"
                >
                    Cancel
                </a>

                <button
                        type="submit"
                        class="save"
                >
                    Save Changes
                </button>

            </div>

        </form>

    </div>

</div>

</body>

</html>
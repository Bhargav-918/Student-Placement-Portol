<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Post New Job</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f7fb;
            margin: 0;
        }

        .header {
            background: #1e3a8a;
            color: white;
            padding: 20px 40px;
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
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        h1 {
            color: #1e3a8a;
        }

        label {
            display: block;
            font-weight: bold;
            margin-top: 15px;
            margin-bottom: 6px;
        }

        input, textarea, select {
            width: 100%;
            padding: 11px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }

        textarea {
            height: 120px;
        }

        button {
            width: 100%;
            margin-top: 25px;
            padding: 13px;
            border: none;
            border-radius: 6px;
            background: #2563eb;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background: #1d4ed8;
        }

        .back {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: #2563eb;
        }
    </style>
</head>

<body>

<div class="header">
    <h2>Student Placement Portal</h2>
</div>

<div class="container">

    <div class="card">

        <h1>Post New Job</h1>

        <form method="post"
              action="<%= request.getContextPath() %>/recruiter/jobs">

            <label>Job Title *</label>

            <input type="text"
                   name="title"
                   placeholder="Example: Software Engineer Intern"
                   required>


            <label>Job Description</label>

            <textarea
                    name="description"
                    placeholder="Enter job description"></textarea>


            <label>Salary</label>

            <input type="text"
                   name="salary"
                   placeholder="Example: ₹25,000/month">


            <label>Location</label>

            <input type="text"
                   name="location"
                   placeholder="Example: Hyderabad">


            <label>Minimum CGPA *</label>

            <input type="number"
                   name="minCgpa"
                   min="0"
                   max="10"
                   step="0.01"
                   placeholder="Example: 7.00"
                   required>


            <label>Eligible Branch *</label>

            <select name="eligibleBranch" required>

                <option value="">Select Branch</option>
                <option value="CSE">CSE</option>
                <option value="ECE">ECE</option>
                <option value="EEE">EEE</option>
                <option value="MECH">MECH</option>
                <option value="CIVIL">CIVIL</option>
                <option value="IT">IT</option>

            </select>


            <label>Graduation Year *</label>

            <input type="number"
                   name="graduationYear"
                   min="2020"
                   max="2100"
                   placeholder="Example: 2027"
                   required>


            <label>Application Deadline *</label>

            <input type="date"
                   name="deadline"
                   required>


            <button type="submit">
                Post Job
            </button>

        </form>


        <a class="back"
           href="<%= request.getContextPath() %>/recruiter/dashboard.jsp">
            ← Back to Dashboard
        </a>

    </div>

</div>

</body>
</html>
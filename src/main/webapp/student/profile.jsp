<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="org.example.placement.model.Student" %>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    Student student =
            (Student) request.getAttribute("student");

    String userName =
            (String) session.getAttribute("userName");

    String success =
            request.getParameter("success");

    String error =
            request.getParameter("error");
%>

<!DOCTYPE html>
<html>

<head>

    <title>My Profile</title>

    <link rel="stylesheet"
          href="../css/style.css">

</head>

<body>

<div class="container">

    <h1>Student Profile</h1>

    <h2>Welcome, <%= userName %></h2>

    <% if (success != null) { %>

        <div class="success">
            <%= success %>
        </div>

    <% } %>

    <% if (error != null) { %>

        <div class="error">
            <%= error %>
        </div>

    <% } %>

    <form action="<%= request.getContextPath() %>/student/profile"
          method="post">

        <label>Roll Number</label>

        <input type="text"
               name="rollNo"
               value="<%= student != null && student.getRollNo() != null
                       ? student.getRollNo() : "" %>"
               required>


        <label>Phone Number</label>

        <input type="text"
               name="phone"
               value="<%= student != null && student.getPhone() != null
                       ? student.getPhone() : "" %>"
               required>


        <label>Branch</label>

        <select name="branch" required>

            <option value="">
                Select Branch
            </option>

            <option value="CSE"
                <%= student != null &&
                    "CSE".equals(student.getBranch())
                    ? "selected" : "" %>>
                CSE
            </option>

            <option value="ECE"
                <%= student != null &&
                    "ECE".equals(student.getBranch())
                    ? "selected" : "" %>>
                ECE
            </option>

            <option value="EEE"
                <%= student != null &&
                    "EEE".equals(student.getBranch())
                    ? "selected" : "" %>>
                EEE
            </option>

            <option value="MECH"
                <%= student != null &&
                    "MECH".equals(student.getBranch())
                    ? "selected" : "" %>>
                Mechanical
            </option>

            <option value="CIVIL"
                <%= student != null &&
                    "CIVIL".equals(student.getBranch())
                    ? "selected" : "" %>>
                Civil
            </option>

        </select>


        <label>CGPA</label>

        <input type="number"
               name="cgpa"
               step="0.01"
               min="0"
               max="10"
               value="<%= student != null
                       ? student.getCgpa() : "" %>"
               required>


        <label>Graduation Year</label>

        <input type="number"
               name="graduationYear"
               min="2020"
               max="2035"
               value="<%= student != null
                       ? student.getGraduationYear() : "" %>"
               required>


        <label>Resume</label>

        <input type="text"
               name="resume"
               placeholder="Resume file name/path"
               value="<%= student != null && student.getResume() != null
                       ? student.getResume() : "" %>">


        <button type="submit">
            Save Profile
        </button>

    </form>

    <br>

    <a href="dashboard.jsp">
        ← Back to Dashboard
    </a>

</div>

</body>

</html>
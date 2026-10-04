<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Register - Student Placement Portal</title>

    <link rel="stylesheet"
          href="css/style.css">
</head>

<body>

<div class="container">

    <h1>Create Account</h1>

    <% if (request.getParameter("error") != null) { %>

        <div class="error">
            <%= request.getParameter("error") %>
        </div>

    <% } %>

    <form action="register" method="post">

        <label>Full Name</label>
        <input type="text"
               name="name"
               required>

        <label>Email</label>
        <input type="email"
               name="email"
               required>

        <label>Password</label>
        <input type="password"
               name="password"
               required>

        <label>Confirm Password</label>
        <input type="password"
               name="confirmPassword"
               required>

        <label>Account Type</label>

        <label for="role">Register As</label>

        <select name="role" id="role" required>

            <option value="">-- Select Role --</option>

            <option value="STUDENT">
                Student
            </option>

            <option value="RECRUITER">
                Recruiter
            </option>

            <option value="ADMIN">
                Admin
            </option>

        </select>


        <button type="submit">
            Create Account
        </button>

    </form>

    <p>
        Already have an account?
        <a href="login.jsp">Login</a>
    </p>

</div>

</body>
</html>
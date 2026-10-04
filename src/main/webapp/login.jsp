<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login - Student Placement Portal</title>

    <link rel="stylesheet"
          href="css/style.css">
</head>

<body>

<div class="container">

    <h1>Student Placement Portal</h1>

    <h2>Login</h2>

    <% if (request.getParameter("error") != null) { %>

        <div class="error">
            <%= request.getParameter("error") %>
        </div>

    <% } %>

    <% if (request.getParameter("success") != null) { %>

        <div class="success">
            <%= request.getParameter("success") %>
        </div>

    <% } %>

    <form action="login" method="post">

        <label>Email</label>

        <input type="email"
               name="email"
               required>

        <label>Password</label>

        <input type="password"
               name="password"
               required>

        <button type="submit">
            Login
        </button>

    </form>

    <p>
        Don't have an account?
        <a href="register.jsp">
            Register
        </a>
    </p>

</div>

</body>
</html>
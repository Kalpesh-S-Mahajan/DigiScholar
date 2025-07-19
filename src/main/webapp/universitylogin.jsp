<%@ page import="java.sql.*" %>
<%@ page import="com.digischolar.Dbconnection" %>
<%@ page import="com.digischolar.GetSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    boolean isValid = false;
    String errorMsg = null;

    if (username != null && password != null) {
        try {
            Connection conn = Dbconnection.connect();
            String query = "SELECT * FROM institute WHERE email=? AND password=?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            stmt.setString(2, password);
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int id = rs.getInt(1);
                GetSet.setId(id);
                isValid = true;
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            errorMsg = "Database Error: " + e.getMessage();
        }

        if (!isValid && errorMsg == null) {
            errorMsg = "Invalid email or password!";
        }
    }

    if (isValid) {
        response.sendRedirect("universitydashboard.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>DigiScholar - University Login</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: url('https://hebbkx1anhila5yf.public.blob.vercel-storage.com/scholarship-rNergqoXC7tpoL1zKijCGSpwtIcqnD.webp') center/cover no-repeat fixed;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 2rem;
    }
    .login-card {
      background: rgba(255, 255, 255, 0.15);
      backdrop-filter: blur(25px);
      border-radius: 25px;
      padding: 3rem;
      width: 100%;
      max-width: 500px;
      color: white;
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
      text-align: center;
    }
    .login-card h2 {
      margin-bottom: 1rem;
      font-size: 2.5rem;
    }
    input[type="text"], input[type="password"] {
      width: 100%;
      padding: 1rem;
      margin-bottom: 1rem;
      border-radius: 10px;
      border: none;
      background: rgba(255, 255, 255, 0.2);
      color: white;
    }
    input::placeholder {
      color: rgba(255, 255, 255, 0.8);
    }
    button {
      padding: 1rem 2rem;
      border: none;
      border-radius: 10px;
      background: rgba(255, 255, 255, 0.3);
      color: white;
      font-size: 1.1rem;
      font-weight: 600;
      cursor: pointer;
      transition: 0.3s;
    }
    button:hover {
      background: rgba(255, 255, 255, 0.5);
    }
    a {
      color: #38bdf8;
      text-decoration: underline;
    }
    .error-msg {
      margin-top: 1rem;
      background: rgba(255, 0, 0, 0.3);
      color: #fff;
      padding: 10px;
      border-radius: 10px;
      font-weight: bold;
    }
  </style>
</head>
<body>
  <div class="login-card">
    <h2>University Login</h2>
    <form method="post">
      <input type="text" name="username" placeholder="Email" required />
      <input type="password" name="password" placeholder="Password" required />
      <button type="submit">Login as University</button>
    </form>

    <% if (errorMsg != null) { %>
      <div class="error-msg"><%= errorMsg %></div>
    <% } %>

    <p style="margin-top: 1rem;">Back to <a href="index.html">Main Page</a></p>
  </div>
</body>
</html>

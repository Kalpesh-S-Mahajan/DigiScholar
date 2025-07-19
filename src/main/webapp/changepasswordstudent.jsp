<%@ page import="java.sql.*" %>
<%@ page import="com.digischolar.Dbconnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String message = null;
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String email = request.getParameter("email");
        String oldpass = request.getParameter("oldpass");
        String newpass = request.getParameter("newpass");

        try {
            Connection conn = Dbconnection.connect();
            PreparedStatement check = conn.prepareStatement("SELECT * FROM student WHERE email=? AND password=?");
            check.setString(1, email);
            check.setString(2, oldpass);
            ResultSet rs = check.executeQuery();

            if (rs.next()) {
                PreparedStatement update = conn.prepareStatement("UPDATE student SET password=? WHERE email=?");
                update.setString(1, newpass);
                update.setString(2, email);
                int i = update.executeUpdate();
                message = (i > 0) ? "Password updated successfully!" : "Update failed!";
            } else {
                message = "Incorrect email or old password.";
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>DigiScholar - Change Password</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: url('https://hebbkx1anhila5yf.public.blob.vercel-storage.com/scholarship-rNergqoXC7tpoL1zKijCGSpwtIcqnD.webp') center/cover no-repeat fixed;
      color: #fff;
    }

    .overlay {
      position: fixed;
      top: 0; left: 0; right: 0; bottom: 0;
      background: rgba(0, 0, 0, 0.5);
      z-index: 0;
    }

    .container {
      position: relative;
      z-index: 1;
      max-width: 500px;
      margin: 6% auto;
      padding: 40px;
    }

    h1 {
      text-align: center;
      font-size: 2.2rem;
      margin-bottom: 2rem;
      background: linear-gradient(to right, #38bdf8, #3b82f6);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }

    .glass-box {
      background: rgba(255, 255, 255, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.2);
      backdrop-filter: blur(15px);
      border-radius: 15px;
      padding: 2rem;
    }

    input, button {
      width: 100%;
      padding: 1rem;
      margin-bottom: 1rem;
      border-radius: 10px;
      border: none;
      background: rgba(255, 255, 255, 0.2);
      color: white;
      font-size: 1rem;
    }

    input::placeholder {
      color: rgba(255, 255, 255, 0.8);
    }

    button {
      background: rgba(59, 130, 246, 0.6);
      font-weight: bold;
      cursor: pointer;
    }

    button:hover {
      background: rgba(59, 130, 246, 0.8);
    }

    .message {
      padding: 10px;
      background: rgba(0, 128, 0, 0.4);
      color: #fff;
      margin-bottom: 1rem;
      font-weight: bold;
      border-radius: 10px;
      text-align: center;
    }

    .footer {
      text-align: center;
      margin-top: 2rem;
      font-size: 0.9rem;
      opacity: 0.7;
    }
  </style>
</head>
<body>
  <div class="overlay"></div>
  <div class="container">
    <h1>Change Password</h1>
    <div class="glass-box">
      <% if (message != null) { %>
        <div class="message"><%= message %></div>
      <% } %>
      <form method="post">
        <input type="email" name="email" placeholder="Registered Email" required />
        <input type="password" name="oldpass" placeholder="Old Password" required />
        <input type="password" name="newpass" placeholder="New Password" required />
        <button type="submit"><i class="fas fa-key"></i> Update Password</button>
      </form>
    </div>
    <div class="footer">
      &copy; 2025 DigiScholar | Security Panel
    </div>
  </div>
</body>
</html>

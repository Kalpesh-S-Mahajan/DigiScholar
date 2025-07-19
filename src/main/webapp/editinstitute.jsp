<%@ page import="java.sql.*" %>
<%@ page import="com.digischolar.Dbconnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String message = null;
    int id = 0;
    String name = "", location = "", contact = "", email = "", password = "";

    try {
        id = Integer.parseInt(request.getParameter("id"));

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            // Handle form submission
            name = request.getParameter("name");
            location = request.getParameter("location");
            contact = request.getParameter("contact");
            email = request.getParameter("email");
            password = request.getParameter("password");

            Connection conn = Dbconnection.connect();
            PreparedStatement ps = conn.prepareStatement(
                "UPDATE institute SET name=?, location=?, contact=?, email=?, password=? WHERE id=?");
            ps.setString(1, name);
            ps.setString(2, location);
            ps.setString(3, contact);
            ps.setString(4, email);
            ps.setString(5, password);
            ps.setInt(6, id);

            int i = ps.executeUpdate();
            message = (i > 0) ? "Institute updated successfully!" : "Update failed.";
        }

        // Fetch current details to show in form
        Connection conn = Dbconnection.connect();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM institute WHERE id=?");
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            name = rs.getString("name");
            location = rs.getString("location");
            contact = rs.getString("contact");
            email = rs.getString("email");
            password = rs.getString("password");
        } else {
            message = "Institute not found.";
        }

    } catch (Exception e) {
        message = "Error: " + e.getMessage();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Edit Institute - DigiScholar</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
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
      max-width: 700px;
      margin: auto;
      padding: 40px;
    }

    h1 {
      text-align: center;
      font-size: 2.8rem;
      margin-bottom: 1.5rem;
      background: linear-gradient(to right, #38bdf8, #3b82f6);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }

    .form-box {
      background: rgba(255, 255, 255, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.2);
      backdrop-filter: blur(15px);
      border-radius: 15px;
      padding: 2rem;
    }

    input, button {
      width: 100%;
      padding: 0.8rem;
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
      background: rgba(16, 185, 129, 0.6);
      font-weight: bold;
      cursor: pointer;
    }

    .message {
      padding: 10px;
      margin-bottom: 1rem;
      border-radius: 10px;
      background: rgba(59, 130, 246, 0.3);
      color: #fff;
      font-weight: bold;
    }

    .back-link {
      display: block;
      text-align: center;
      margin-top: 1rem;
      color: #38bdf8;
      text-decoration: none;
    }

    .footer {
      text-align: center;
      margin-top: 3rem;
      font-size: 0.9rem;
      opacity: 0.7;
    }
  </style>
</head>
<body>
  <div class="overlay"></div>
  <div class="container">
    <h1>Edit Institute</h1>

    <div class="form-box">
      <% if (message != null) { %>
        <div class="message"><%= message %></div>
      <% } %>
      <form method="post">
        <input type="text" name="name" placeholder="Institute Name" value="<%= name %>" required />
        <input type="text" name="location" placeholder="Location" value="<%= location %>" required />
        <input type="text" name="contact" placeholder="Contact Number" value="<%= contact %>" required />
        <input type="email" name="email" placeholder="Email Address" value="<%= email %>" required />
        <input type="password" name="password" placeholder="Password" value="<%= password %>" required />
        <button type="submit"><i class="fas fa-save"></i> Update Institute</button>
      </form>
    </div>

    <a class="back-link" href="manageinstitutes.jsp"><i class="fas fa-arrow-left"></i> Back to Manage Institutes</a>

    <div class="footer">
      &copy; 2025 DigiScholar | Admin Panel
    </div>
  </div>
</body>
</html>

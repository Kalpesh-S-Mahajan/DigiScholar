<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.digischolar.Dbconnection" %>
<%
    String message = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        int id = 0;
        String name = request.getParameter("name");
        String location = request.getParameter("location");
        String contact = request.getParameter("contact");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (name != null && contact != null && location != null && email != null && password != null) {
            try {
                Connection conn = Dbconnection.connect();
                PreparedStatement pstmt = conn.prepareStatement("INSERT INTO institute VALUES (?,?,?,?,?,?)");
                pstmt.setInt(1, id);
                pstmt.setString(2, name);
                pstmt.setString(3, location);
                pstmt.setString(4, contact);
                pstmt.setString(5, email);
                pstmt.setString(6, password);

                int i = pstmt.executeUpdate();
                message = (i > 0) ? "Institute added successfully!" : "Failed to add institute.";
            } catch (Exception e) {
                message = "Error: " + e.getMessage();
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>DigiScholar - Manage Institutes</title>
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
      max-width: 1100px;
      margin: auto;
      padding: 40px;
    }

    h1 {
      text-align: center;
      font-size: 3rem;
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
      margin-bottom: 2rem;
    }

    .glass-box h2 {
      font-size: 1.5rem;
      margin-bottom: 1rem;
    }

    .message {
      padding: 10px;
      background: rgba(0, 128, 0, 0.4);
      color: #fff;
      margin-bottom: 1rem;
      font-weight: bold;
      border-radius: 10px;
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
      background: rgba(59, 130, 246, 0.6);
      font-weight: bold;
      cursor: pointer;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 1rem;
    }

    th, td {
      padding: 0.8rem;
      text-align: center;
      border: 1px solid rgba(255, 255, 255, 0.2);
    }

    th {
      background: rgba(255, 255, 255, 0.15);
    }

    .actions a {
      color: #38bdf8;
      margin: 0 0.5rem;
      text-decoration: none;
    }

    .actions a:hover {
      text-decoration: underline;
    }

    .footer {
      text-align: center;
      margin-top: 4rem;
      font-size: 0.9rem;
      opacity: 0.7;
    }
  </style>
</head>
<body>
  <div class="overlay"></div>
  <div class="container">
    <h1>Manage Institutes</h1>

    <!-- Add Form -->
    <div class="glass-box">
      <h2><i class="fas fa-plus-circle"></i> Add New Institute</h2>
      <% if (request.getParameter("msg") != null) { %>
        <div class="message"><%= request.getParameter("msg") %></div>
      <% } %>
      <% if (message != null) { %>
        <div class="message"><%= message %></div>
      <% } %>
      <form method="post">
        <input type="text" name="name" placeholder="Institute Name" required />
        <input type="text" name="location" placeholder="Location" required />
        <input type="text" name="contact" placeholder="Contact Number" required />
        <input type="email" name="email" placeholder="Email Address" required />
        <input type="password" name="password" placeholder="Password" required />
        <button type="submit"><i class="fas fa-plus"></i> Add Institute</button>
      </form>
    </div>

    <!-- Institute Table -->
    <div class="glass-box">
      <h2><i class="fas fa-university"></i> Existing Institutes</h2>
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Location</th>
            <th>Contact</th>
            <th>Email</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <%
            try {
              Connection conn = Dbconnection.connect();
              PreparedStatement stmt = conn.prepareStatement("SELECT * FROM institute");
              ResultSet rs = stmt.executeQuery();
              while (rs.next()) {
          %>
          <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("location") %></td>
            <td><%= rs.getString("contact") %></td>
            <td><%= rs.getString("email") %></td>
            <td class="actions">
              <a href="editinstitute.jsp?id=<%= rs.getInt("id") %>"><i class="fas fa-edit"></i> Edit</a>
              <a href="deleteinstitute.jsp?id=<%= rs.getInt("id") %>"><i class="fas fa-trash"></i> Delete</a>
            </td>
          </tr>
          <%
              }
            } catch (Exception e) {
                out.println("<tr><td colspan='6'>Error loading institutes</td></tr>");
            }
          %>
        </tbody>
      </table>
    </div>

    <div class="footer">
      &copy; 2025 DigiScholar | Admin Panel
    </div>
  </div>
</body>
</html>

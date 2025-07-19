<%@ page import="java.sql.*" %>
<%@ page import="com.digischolar.Dbconnection" %>
<%@ page import="com.digischolar.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String message = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
    	int id=0;
    	int instituteId=GetSet.getId();
        String title = request.getParameter("title");
        String eligibility = request.getParameter("eligibility");
        String amount = request.getParameter("amount");
        String deadline = request.getParameter("deadline");

        try {
            Connection conn = Dbconnection.connect();
            PreparedStatement pstmt = conn.prepareStatement(
                "INSERT INTO scholarships VALUES (?, ?, ?, ?,?,?)"
            );
            pstmt.setInt(1, id);
            pstmt.setInt(2, instituteId);
            pstmt.setString(3, title);
            pstmt.setString(4, eligibility);
            pstmt.setDouble(5, Double.parseDouble(amount));
            pstmt.setString(6, deadline);

            int i = pstmt.executeUpdate();
            message = (i > 0) ? "Scholarship posted successfully!" : "Failed to post scholarship.";
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>DigiScholar - Post Scholarship</title>
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
      max-width: 600px;
      margin: 5% auto;
      padding: 40px;
    }

    h1 {
      text-align: center;
      font-size: 2.5rem;
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

    input, textarea, button {
      width: 100%;
      padding: 1rem;
      margin-bottom: 1rem;
      border-radius: 10px;
      border: none;
      background: rgba(255, 255, 255, 0.2);
      color: white;
      font-size: 1rem;
    }

    input::placeholder, textarea::placeholder {
      color: rgba(255, 255, 255, 0.8);
    }

    textarea {
      resize: vertical;
      min-height: 80px;
    }

    button {
      background: rgba(59, 130, 246, 0.6);
      font-weight: bold;
      cursor: pointer;
    }

    button:hover {
      background: rgba(59, 130, 246, 0.8);
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
    <h1>Post a Scholarship</h1>
    <div class="glass-box">
      <% if (message != null) { %>
        <div class="message"><%= message %></div>
      <% } %>
      <form method="post">
        <input type="text" name="title" placeholder="Scholarship Title" required />
        <input type="text" name="eligibility" placeholder="Eligibility Criteria" required />
        <input type="number" name="amount" placeholder="Amount (in INR)" required />
        <input type="date" name="deadline" required />
         
          
        <button type="submit"><i class="fas fa-upload"></i> Post Scholarship</button>
      </form>
    </div>
    <div class="footer">
      &copy; 2025 DigiScholar | Institute Panel
    </div>
  </div>
</body>
</html> 
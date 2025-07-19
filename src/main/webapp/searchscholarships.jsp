<%@ page import="java.sql.*, java.util.Base64, java.io.InputStream, java.util.HashSet" %>
<%@ page import="com.digischolar.Dbconnection" %>
<%@ page import="com.digischolar.GetSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String keyword = request.getParameter("search");
    if (keyword == null) keyword = "";

    // Apply logic
    String scholarshipId = request.getParameter("scholarshipId");
    int studentId = (session.getAttribute("studentId") != null) ? (Integer) session.getAttribute("studentId") : GetSet.getId();

    if ("POST".equalsIgnoreCase(request.getMethod()) && scholarshipId != null && studentId != -1) {
        try {
            Connection conn = Dbconnection.connect();
            PreparedStatement check = conn.prepareStatement("SELECT * FROM applications WHERE studentId=? AND scholarshipId=?");
            check.setInt(1, studentId);
            check.setInt(2, Integer.parseInt(scholarshipId));
            ResultSet rs = check.executeQuery();

            if (!rs.next()) {
                PreparedStatement insert = conn.prepareStatement("INSERT INTO applications (studentId, scholarshipId, applicationDate, status) VALUES (?, ?, CURRENT_DATE, 'Pending')");
                insert.setInt(1, studentId);
                insert.setInt(2, Integer.parseInt(scholarshipId));
                insert.executeUpdate();
                insert.close();
                out.println("<script>window.location='searchscholarships.jsp';</script>");
            }

            rs.close();
            check.close();
            conn.close();
        } catch (Exception e) {
            out.println("<script>alert('Error while applying: " + e.getMessage() + "');</script>");
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Search Scholarships</title>
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
            background: rgba(0, 0, 0, 0.6);
            z-index: 0;
        }
        .container {
            position: relative;
            z-index: 1;
            max-width: 1200px;
            margin: auto;
            padding: 40px 20px;
        }
        h1 {
            text-align: center;
            font-size: 2.5rem;
            background: linear-gradient(to right, #38bdf8, #3b82f6);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 30px;
        }
        .search-box {
            text-align: center;
            margin-bottom: 30px;
        }
        .search-box input[type="text"] {
            padding: 10px 15px;
            border-radius: 10px;
            border: none;
            width: 300px;
            font-size: 16px;
        }
        .search-box button {
            padding: 10px 20px;
            border-radius: 10px;
            border: none;
            background-color: #3b82f6;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }
        .cards-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 25px;
        }
        .card {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(15px);
            border-radius: 15px;
            padding: 20px;
            width: 320px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            color: #fff;
        }
        .card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 15px;
        }
        .card h2 {
            margin: 0;
            font-size: 20px;
        }
        .card p {
            font-size: 15px;
            margin: 5px 0;
        }
        .card form {
            margin-top: 10px;
        }
        .apply-btn {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border-radius: 8px;
            border: none;
            background-color: #3b82f6;
            color: white;
            cursor: pointer;
        }
        .applied-btn {
            background-color: #22c55e;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
<div class="overlay"></div>
<div class="container">
    <h1>Search & Apply for Scholarships</h1>

    <div class="search-box">
        <form method="get" action="searchscholarships.jsp">
            <input type="text" name="search" placeholder="Search by Title or Eligibility..." value="<%= keyword %>">
            <button type="submit"><i class="fas fa-search"></i> Search</button>
        </form>
    </div>

    <div class="cards-container">
        <%
            try {
                Connection con = Dbconnection.connect();

                // Fetch already applied scholarshipIds for the current student
                HashSet<Integer> appliedSet = new HashSet<>();
                if (studentId != -1) {
                    PreparedStatement appliedPs = con.prepareStatement("SELECT scholarshipId FROM applications WHERE studentId=?");
                    appliedPs.setInt(1, studentId);
                    ResultSet appliedRs = appliedPs.executeQuery();
                    while (appliedRs.next()) {
                        appliedSet.add(appliedRs.getInt("scholarshipId"));
                    }
                    appliedRs.close();
                    appliedPs.close();
                }

                PreparedStatement ps = con.prepareStatement("SELECT * FROM scholarships WHERE status='approved' AND (title LIKE ? OR eligibility LIKE ?)");
                ps.setString(1, "%" + keyword + "%");
                ps.setString(2, "%" + keyword + "%");
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String title = rs.getString("title");
                    String eligibility = rs.getString("eligibility");
                    int amount = rs.getInt("amount");
                    String deadline = rs.getString("deadline");

                    InputStream inputStream = rs.getBinaryStream("document");
                    String base64Image = "";
                    if (inputStream != null) {
                        byte[] imageBytes = inputStream.readAllBytes();
                        base64Image = Base64.getEncoder().encodeToString(imageBytes);
                    }
        %>
        <div class="card">
            <% if (!base64Image.isEmpty()) { %>
                <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Scholarship Image" />
            <% } else { %>
                <img src="https://via.placeholder.com/350x180?text=No+Image" alt="No Image" />
            <% } %>

            <h2><%= title %></h2>
            <p><strong>Eligibility:</strong> <%= eligibility %></p>
            <p><strong>Amount:</strong> ₹<%= amount %></p>
            <p><strong>Deadline:</strong> <%= deadline %></p>

            <form method="post" action="searchscholarships.jsp">
                <input type="hidden" name="scholarshipId" value="<%= id %>" />
                <%
                    if (appliedSet.contains(id)) {
                %>
                    <button class="apply-btn applied-btn" disabled>Applied</button>
                <%
                    } else {
                %>
                    <button class="apply-btn">Apply</button>
                <%
                    }
                %>
            </form>
        </div>
        <%
                }
                rs.close();
                ps.close();
                con.close();
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            }
        %>
    </div>
</div>
</body>
</html>

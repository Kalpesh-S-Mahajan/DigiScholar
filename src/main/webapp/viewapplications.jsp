<%@ page import="java.sql.*" %>
<%@ page import="com.digischolar.Dbconnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
       String appId = request.getParameter("appId");
    String action = request.getParameter("action");

    if (appId != null && action != null) {
        try {
            Connection conn = Dbconnection.connect();
            String newStatus = action.equals("approve") ? "Approved" : "Rejected";
            PreparedStatement pst = conn.prepareStatement("UPDATE applications SET status = ? WHERE id = ?");
            pst.setString(1, newStatus);
            pst.setInt(2, Integer.parseInt(appId));
            pst.executeUpdate();
            conn.close();
            response.sendRedirect("viewapplications.jsp");
            return; 
        } catch (Exception e) {
            out.println("<script>alert('Status update failed: " + e.getMessage() + "');</script>");
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>DigiScholar - View Applications</title>
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
            color: white;
        }
        th, td {
            padding: 1rem;
            text-align: left;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        th {
            background: rgba(255, 255, 255, 0.15);
        }
        .btn {
            padding: 5px 10px;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            color: #fff;
        }
        .approve-btn {
            background-color: #22c55e;
        }
        .reject-btn {
            background-color: #ef4444;
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
    <h1>Student Applications</h1>
    <div class="glass-box">
        <table>
            <thead>
            <tr>
                <th>Application ID</th>
                <th>StudentId</th>
                <th>Scholarship ID</th>
                <th>Application Date</th>
                <th>Status</th>
            </tr>
            </thead>
            <tbody>
            <%
                try {
                    Connection conn = Dbconnection.connect();
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM applications");

                    while (rs.next()) {
                        int id = rs.getInt("id");
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("studentId") %></td>
                    <td><%= rs.getString("scholarshipId") %></td>
                    <td><%= rs.getString("applicationDate") %></td>
                    
                <td>
                    <%= rs.getString("status") %>
                    <form method="post"  style="display:inline;">
                        <input type="hidden" name="appId" value="<%= id %>">
                        <button type="submit" name="action" value="approve" class="btn approve-btn">Approve</button>
                        <button type="submit" name="action" value="reject" class="btn reject-btn">Disapprove</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                    conn.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='5'>Error loading applications</td></tr>");
                }
            %>
            </tbody>
        </table>
    </div>
    <div class="footer">
        &copy; 2025 DigiScholar | Institute Panel
    </div>
</div>
</body>
</html>

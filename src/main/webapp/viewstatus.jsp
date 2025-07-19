<%@ page import="java.sql.*" %>
<%@ page import="com.digischolar.Dbconnection" %>
<%@ page import="com.digischolar.GetSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Application Status</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('https://hebbkx1anhila5yf.public.blob.vercel-storage.com/scholarship-rNergqoXC7tpoL1zKijCGSpwtIcqnD.webp') center/cover no-repeat fixed;
            margin: 0;
            color: white;
        }
        .overlay { position: fixed; top: 0; left: 0; right: 0; bottom: 0; background: rgba(0, 0, 0, 0.5); z-index: 0; }
        .container {
            position: relative;
            z-index: 1;
            max-width: 1000px;
            margin: auto;
            padding: 40px;
        }
        h1 {
            text-align: center;
            font-size: 2.5rem;
            background: linear-gradient(to right, #38bdf8, #3b82f6);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .glass-box {
            margin-top: 2rem;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(15px);
            border-radius: 15px;
            padding: 2rem;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 1rem;
            text-align: left;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        th {
            background: rgba(255, 255, 255, 0.15);
        }
    </style>
</head>
<body>
<div class="overlay"></div>
<div class="container">
    <h1>Application Status</h1>
    <div class="glass-box">
        <table>
            <thead>
                <tr>
                    <th>Application ID</th>
                    <th>Scholarship Title</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Integer studentId =GetSet.getId();
                    if (studentId != null) {
                        try {
                            Connection conn = Dbconnection.connect();
                            PreparedStatement stmt = conn.prepareStatement(
                                "SELECT a.id, s.title, a.status " +
                                "FROM applications a JOIN scholarships s ON a.scholarshipId = s.id " +
                                "WHERE a.studentId = ?"
                            );
                            stmt.setInt(1, studentId);
                            ResultSet rs = stmt.executeQuery();
                            while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("title") %></td>
                    <td><%= rs.getString("status") %></td>
                </tr>
                <%      }
                            conn.close();
                        } catch (Exception e) {
                            out.println("<tr><td colspan='3'>Error loading applications</td></tr>");
                        }
                    } else {
                        out.println("<tr><td colspan='3'>Student not logged in</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>

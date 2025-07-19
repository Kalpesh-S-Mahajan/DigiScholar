<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.digischolar.Dbconnection" %>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String name = request.getParameter("name");
        String contact = request.getParameter("contact");
        String course = request.getParameter("course");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (name != null && contact != null && course != null && email != null && password != null) {
            try {
                Connection conn = Dbconnection.connect();

                // Check if email already exists
                PreparedStatement checkStmt = conn.prepareStatement("SELECT * FROM student WHERE email = ?");
                checkStmt.setString(1, email);
                ResultSet rs = checkStmt.executeQuery();

                if (rs.next()) {
%>
                    <script>
                        alert("Email already registered. Please login.");
                        window.location.href = "studentlogin.jsp";
                    </script>
<%
                } else {
                    PreparedStatement pstmt = conn.prepareStatement(
                        "INSERT INTO student (name, course, contact, email, password) VALUES (?, ?, ?, ?, ?)"
                    );
                    pstmt.setString(1, name);
                    pstmt.setString(2, course);
                    pstmt.setString(3, contact);
                    pstmt.setString(4, email);
                    pstmt.setString(5, password);

                    int i = pstmt.executeUpdate();
                    if (i > 0) {
%>
                        <script>
                            alert("Successfully registered!");
                            window.location.href = "studentlogin.jsp";
                        </script>
<%
                    }

                    pstmt.close();
                }

                rs.close();
                checkStmt.close();
                conn.close();
            } catch (Exception e) {
%>
                <script>
                    alert("Database error: <%= e.getMessage() %>");
                </script>
<%
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>DigiScholar - Student Registration</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: url('https://hebbkx1anhila5yf.public.blob.vercel-storage.com/scholarship-rNergqoXC7tpoL1zKijCGSpwtIcqnD.webp') center/cover no-repeat fixed;
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 2rem;
    }

    .register-card {
      background: rgba(255, 255, 255, 0.15);
      backdrop-filter: blur(25px);
      border-radius: 25px;
      padding: 3rem;
      width: 100%;
      max-width: 600px;
      color: white;
      text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.4);
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
    }

    .register-card h2 {
      text-align: center;
      margin-bottom: 1.5rem;
      font-size: 2.5rem;
    }

    .register-card form {
      display: flex;
      flex-direction: column;
      gap: 1rem;
    }

    input[type="text"],
    input[type="email"],
    input[type="password"],
    input[type="tel"],
    select {
      width: 100%;
      padding: 1rem;
      border-radius: 10px;
      border: none;
      font-size: 1rem;
      background: rgba(255, 255, 255, 0.2);
      color: white;
      backdrop-filter: blur(10px);
    }

    input::placeholder {
      color: rgba(255, 255, 255, 0.8);
    }

    option {
      color: black;
    }

    button {
      background: rgba(255, 255, 255, 0.3);
      color: white;
      border: 2px solid rgba(255, 255, 255, 0.5);
      padding: 1rem;
      border-radius: 12px;
      font-size: 1.1rem;
      font-weight: 600;
      cursor: pointer;
      transition: 0.3s ease;
    }

    button:hover {
      background: rgba(255, 255, 255, 0.5);
      transform: translateY(-2px);
    }

    .back-link {
      text-align: center;
      margin-top: 1rem;
      font-size: 0.95rem;
    }

    .back-link a {
      color: #e0f2fe;
      text-decoration: underline;
    }
  </style>
</head>
<body>
  <div class="register-card">
    <h2>Student Registration</h2>
    <form method="post">
      <input type="text" name="name" placeholder="Full Name" required />
      <input type="tel" name="contact" placeholder="Contact Number" required />
      
      <select name="course" required>
        <option value="" disabled selected>Select your course</option>
        <optgroup label="11th & 12th (Higher Secondary)">
          <option value="11th - Science">11th - Science</option>
          <option value="11th - Commerce">11th - Commerce</option>
          <option value="11th - Arts">11th - Arts</option>
          <option value="12th - Science">12th - Science</option>
          <option value="12th - Commerce">12th - Commerce</option>
          <option value="12th - Arts">12th - Arts</option>
        </optgroup>
        <optgroup label="Bachelor's Degrees">
          <option value="B.A.">B.A. (Bachelor of Arts)</option>
          <option value="B.Sc.">B.Sc. (Bachelor of Science)</option>
          <option value="B.Com">B.Com (Bachelor of Commerce)</option>
          <option value="BBA">BBA (Bachelor of Business Administration)</option>
          <option value="BCA">BCA (Bachelor of Computer Applications)</option>
          <option value="B.Tech">B.Tech (Bachelor of Technology)</option>
          <option value="B.E.">B.E. (Bachelor of Engineering)</option>
          <option value="B.Arch">B.Arch (Bachelor of Architecture)</option>
          <option value="LLB">LLB (Bachelor of Law)</option>
          <option value="MBBS">MBBS (Bachelor of Medicine)</option>
          <option value="BDS">BDS (Bachelor of Dental Surgery)</option>
          <option value="B.Pharm">B.Pharm (Bachelor of Pharmacy)</option>
          <option value="B.Ed">B.Ed (Bachelor of Education)</option>
          <option value="BHM">BHM (Bachelor of Hotel Management)</option>
        </optgroup>
      </select>

      <input type="email" name="email" placeholder="Email" required />
      <input type="password" name="password" placeholder="Password" required />
      <button type="submit">Register</button>
    </form>

    <div class="back-link">
      Already have an account? <a href="studentlogin.jsp">Login here</a>
    </div>
  </div>
</body>
</html>

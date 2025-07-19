<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String errorMessage = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if ("admin123@gmail.com".equals(username) && "405425".equals(password)) {
            response.sendRedirect("admindashboard.jsp"); 
            return;
        } else {
            errorMessage = "Invalid username or password!";
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DigiScholar - Admin Login</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        /* === Base Styles === */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('https://hebbkx1anhila5yf.public.blob.vercel-storage.com/scholarship-rNergqoXC7tpoL1zKijCGSpwtIcqnD.webp') center/cover no-repeat fixed;
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        .background-overlay {
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background: linear-gradient(135deg, rgba(0, 0, 0, 0.4), rgba(30, 58, 138, 0.3), rgba(16, 185, 129, 0.2));
            z-index: 1;
        }

        .floating-elements {
            position: fixed;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 2;
        }

        .floating-icon {
            position: absolute;
            color: rgba(255, 255, 255, 0.15);
            animation: float 8s ease-in-out infinite;
            text-shadow: 0 0 20px rgba(255, 255, 255, 0.3);
        }

        .floating-icon:nth-child(1) { top: 15%; left: 10%; animation-delay: 0s; }
        .floating-icon:nth-child(2) { top: 25%; right: 15%; animation-delay: 1.5s; }
        .floating-icon:nth-child(3) { bottom: 30%; left: 20%; animation-delay: 3s; }
        .floating-icon:nth-child(4) { bottom: 20%; right: 25%; animation-delay: 4.5s; }
        .floating-icon:nth-child(5) { top: 60%; left: 8%; animation-delay: 6s; }
        .floating-icon:nth-child(6) { top: 70%; right: 12%; animation-delay: 7.5s; }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); opacity: 0.6; }
            50% { transform: translateY(-30px) rotate(10deg); opacity: 1; }
        }

        .main-container {
            position: relative;
            z-index: 3;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            padding: 2rem;
        }

        .top-header {
            text-align: center;
            margin-bottom: 3rem;
            padding: 2rem 0;
        }

        .project-title {
            font-size: 4rem;
            font-weight: 800;
            color: white;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.7);
            background: linear-gradient(135deg, #ffffff, #f0f9ff, #dbeafe);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: titleGlow 3s ease-in-out infinite alternate;
        }

        @keyframes titleGlow {
            0% { text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.7), 0 0 30px rgba(255, 255, 255, 0.3); }
            100% { text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.7), 0 0 50px rgba(255, 255, 255, 0.5); }
        }

        .project-subtitle {
            font-size: 1.5rem;
            color: rgba(255, 255, 255, 0.9);
            text-shadow: 1px 1px 4px rgba(0, 0, 0, 0.8);
            font-weight: 300;
        }

        .dashboard-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            max-width: 600px;
            margin: 0 auto;
            width: 100%;
        }

        .login-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .login-card {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(25px);
            border-radius: 25px;
            padding: 3rem;
            text-align: center;
            transition: all 0.4s ease;
            border: 2px solid rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
        }

        .card-icon {
            width: 100px;
            height: 100px;
            margin: 0 auto 2rem;
            border-radius: 25px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: white;
            background: linear-gradient(135deg, rgba(239, 68, 68, 0.9), rgba(248, 113, 113, 0.8));
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
        }

        .card-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: white;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6);
        }

        .card-description {
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 2rem;
            line-height: 1.7;
            font-size: 1.1rem;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 1rem;
            margin-bottom: 1.2rem;
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

        .login-btn {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.3);
            padding: 1.2rem 2.5rem;
            border-radius: 15px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
        }

        .login-btn:hover {
            transform: translateY(-3px);
            background: rgba(255, 255, 255, 0.3);
            border-color: rgba(255, 255, 255, 0.5);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
        }

        .footer {
            text-align: center;
            color: white;
            padding: 2rem 0 0;
            font-size: 0.9rem;
            opacity: 0.8;
        }

        .pulse {
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
    </style>
</head>
<body>
    <div class="background-overlay"></div>
    <div class="floating-elements">
        <i class="fas fa-graduation-cap floating-icon" style="font-size: 4rem;"></i>
        <i class="fas fa-book floating-icon" style="font-size: 3rem;"></i>
        <i class="fas fa-university floating-icon" style="font-size: 4.5rem;"></i>
        <i class="fas fa-award floating-icon" style="font-size: 2.5rem;"></i>
        <i class="fas fa-lightbulb floating-icon" style="font-size: 3.5rem;"></i>
        <i class="fas fa-star floating-icon" style="font-size: 3rem;"></i>
    </div>

    <div class="main-container">
        <div class="top-header">
            <h1 class="project-title pulse">DigiScholar</h1>
            <p class="project-subtitle">Scholarship Management System</p>
        </div>

        <div class="dashboard-content">
            <div class="login-grid">
                <div class="login-card">
                    <div class="card-icon pulse">
                        <i class="fas fa-user-shield"></i>
                    </div>
                    <h3 class="card-title">Admin Login</h3>
                    <p class="card-description">
                        Enter your username or email and password to access the Admin Dashboard.
                    </p>
                    <% if (errorMessage != null) { %>
                        <div class="error-msg"><%= errorMessage %></div>
                    <% } %>
                    <form method="post">
                        <input type="text" name="username" placeholder="Username or Email" required>
                        <input type="password" name="password" placeholder="Password" required>
                        <button type="submit" class="login-btn">
                            <i class="fas fa-sign-in-alt"></i> Login as Admin
                        </button>
                           <p style="margin-top: 1rem; color: white;">
    Want to go on main page??
    <a href="index.html" style="color: #38bdf8; text-decoration: underline;">Back To Main Page</a>
  </p>
                    </form>
                </div>
            </div>

            <div class="footer">
                <p>&copy; 2025 DigiScholar. All rights reserved.</p>
            </div>
        </div>
    </div>
</body>
</html>


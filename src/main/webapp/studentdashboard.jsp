<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>DigiScholar - Student Dashboard</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/css/all.min.css">
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: url('https://hebbkx1anhila5yf.public.blob.vercel-storage.com/scholarship-rNergqoXC7tpoL1zKijCGSpwtIcqnD.webp') no-repeat center center fixed;
      background-size: cover;
      color: white;
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
      margin: 5% auto;
      padding: 40px;
    }

    h1 {
      text-align: center;
      font-size: 2.8rem;
      margin-bottom: 2rem;
      background: linear-gradient(to right, #38bdf8, #3b82f6);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }

    .dashboard {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap: 2rem;
      margin-top: 2rem;
    }

    .card {
      background: rgba(255, 255, 255, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.2);
      backdrop-filter: blur(15px);
      border-radius: 15px;
      padding: 2rem;
      text-align: center;
      transition: transform 0.3s ease;
    }

    .card:hover {
      background: rgba(255, 255, 255, 0.15);
      transform: translateY(-5px);
    }

    .card i {
      font-size: 2.5rem;
      margin-bottom: 1rem;
      color: #38bdf8;
    }

    .card a {
      display: block;
      text-decoration: none;
      color: white;
      font-size: 1.2rem;
      font-weight: bold;
    }

    .card p {
      font-size: 0.95rem;
      color: #d1d5db;
      margin-top: 0.5rem;
    }

    .footer {
      text-align: center;
      margin-top: 3rem;
      font-size: 0.9rem;
      opacity: 0.7;
    }

    @media (max-width: 768px) {
      .dashboard {
        grid-template-columns: 1fr;
      }
    }
  </style>
</head>
<body>
  <div class="overlay"></div>

  <div class="container">
    <h1>Student Dashboard</h1>

    <div class="dashboard">
      <div class="card">
        <i class="fas fa-search"></i>
        <a href="searchscholarships.jsp">Search & Apply</a>
        <p>Explore available scholarships and apply instantly.</p>
      </div>

      <div class="card">
        <i class="fas fa-clipboard-check"></i>
        <a href="viewstatus.jsp">Application Status</a>
        <p>Track your scholarship application progress.</p>
      </div>

      <div class="card">
        <i class="fas fa-lock"></i>
        <a href="changepasswordstudent.jsp">Change Password</a>
        <p>Secure your account with a new password.</p>
      </div>
    </div>

    <div class="footer">
      &copy; 2025 DigiScholar | Student Panel
    </div>
  </div>
</body>
</html>

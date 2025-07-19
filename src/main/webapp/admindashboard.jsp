<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>DigiScholar - Admin Dashboard</title>
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
      max-width: 900px;
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

    .card-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 2rem;
    }

    .card {
      background: rgba(255, 255, 255, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.2);
      padding: 2rem;
      border-radius: 15px;
      text-align: center;
      backdrop-filter: blur(15px);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      cursor: pointer;
    }

    .card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
    }

    .card i {
      font-size: 2rem;
      margin-bottom: 1rem;
      color: #fff;
    }

    .card h3 {
      font-size: 1.3rem;
      margin-bottom: 0.5rem;
    }

    .card p {
      font-size: 0.95rem;
      opacity: 0.85;
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
    <h1>DigiScholar Admin Dashboard</h1>

    <div class="card-grid">
      <div class="card" onclick="location.href='adminlogin.jsp'">
        <i class="fas fa-user-shield"></i>
        <h3>Login</h3>
        <p>Access the admin panel securely.</p>
      </div>

      <div class="card" onclick="location.href='manageinstitutes.jsp'">
        <i class="fas fa-university"></i>
        <h3>Manage Institutes</h3>
        <p>Add, view, or delete registered institutes.</p>
      </div>

      <div class="card" onclick="location.href='viewstudents.jsp'">
        <i class="fas fa-users"></i>
        <h3>View Students</h3>
        <p>See all student profiles .</p>
      </div>

      <div class="card" onclick="location.href='managescholarships.jsp'">
        <i class="fas fa-hand-holding-usd"></i>
        <h3>Manage Scholarships</h3>
        <p>Update, or remove scholarship entries.</p>
      </div>
    </div>

    <div class="footer">
      &copy; 2025 DigiScholar | Admin Panel
    </div>
  </div>
</body>
</html>

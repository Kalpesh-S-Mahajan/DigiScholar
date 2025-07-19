<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>DigiScholar Institute Dashboard</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: url('https://hebbkx1anhila5yf.public.blob.vercel-storage.com/scholarship-rNergqoXC7tpoL1zKijCGSpwtIcqnD.webp') center/cover no-repeat fixed;
      color: #fff;
    }

    .dashboard-container {
      text-align: center;
      padding-top: 60px;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    .dashboard-title {
      font-size: 2.5rem;
      font-weight: bold;
      margin-bottom: 2rem;
      background: linear-gradient(to right, #38bdf8, #3b82f6);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }

    .card-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
      gap: 1.5rem;
      max-width: 900px;
      margin: 0 auto;
      padding: 0 1rem;
    }

    .card {
      background: rgba(255, 255, 255, 0.1);
      backdrop-filter: blur(12px);
      border-radius: 15px;
      padding: 1.5rem;
      box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
      transition: transform 0.3s ease;
      cursor: pointer;
      text-decoration: none;
      color: white;
    }

    .card:hover {
      transform: scale(1.05);
      background: rgba(59, 130, 246, 0.2);
    }

    .card i {
      font-size: 2rem;
      margin-bottom: 1rem;
    }

    .card-title {
      font-size: 1.3rem;
      font-weight: bold;
      margin-bottom: 0.5rem;
    }

    .card-subtitle {
      font-size: 0.95rem;
      opacity: 0.85;
    }

    .footer {
      margin-top: 3rem;
      font-size: 0.9rem;
      opacity: 0.7;
    }

    @media (max-width: 600px) {
      .dashboard-title {
        font-size: 2rem;
      }
    }
  </style>
</head>
<body>
  <div class="dashboard-container">
    <div class="dashboard-title">DigiScholar Institute Dashboard</div>

    <div class="card-grid">
      <a href="universitylogin.jsp" class="card">
        <i class="fas fa-sign-in-alt"></i>
        <div class="card-title">Login</div>
        <div class="card-subtitle">Secure access to your panel.</div>
      </a>

      <a href="postscholarship.html" class="card">
        <i class="fas fa-upload"></i>
        <div class="card-title">Post Scholarships</div>
        <div class="card-subtitle">Announce and manage new scholarships.</div>
      </a>

      <a href="viewapplications.jsp" class="card">
        <i class="fas fa-eye"></i>
        <div class="card-title">View Applications</div>
        <div class="card-subtitle">Review submitted student applications.</div>
      </a>

      <a href="changepassword.jsp" class="card">
        <i class="fas fa-key"></i>
        <div class="card-title">Change Password</div>
        <div class="card-subtitle">Update your institute account credentials.</div>
      </a>
    </div>

    <div class="footer">© 2025 DigiScholar | Institute Panel</div>
  </div>
</body>
</html>

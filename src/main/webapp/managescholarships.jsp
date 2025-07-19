<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.digischolar.Dbconnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Scholarships - DigiScholar</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
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
        }

        .background-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.3);
            z-index: 1;
        }

        .container {
            position: relative;
            z-index: 2;
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }

        .header {
            text-align: center;
            margin-bottom: 2rem;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 2rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .header h1 {
            font-size: 2.2rem;
            font-weight: 600;
            color: white;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .header p {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1rem;
            font-weight: 400;
        }

        .stats-bar {
            display: flex;
            justify-content: center;
            gap: 1.5rem;
            margin: 2rem 0;
            flex-wrap: wrap;
        }

        .stat-item {
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(15px);
            padding: 1.2rem 2rem;
            border-radius: 15px;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
            min-width: 120px;
        }

        .stat-number {
            font-size: 1.8rem;
            font-weight: 700;
            display: block;
            margin-bottom: 0.2rem;
        }

        .stat-label {
            font-size: 0.9rem;
            opacity: 0.9;
            font-weight: 500;
        }

        .scholarship-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .scholarship-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 2rem;
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            min-height: 750px;
            display: flex;
            flex-direction: column;
        }

        .scholarship-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #4F46E5, #06B6D4, #10B981);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1.5rem;
        }

        .card-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: #1F2937;
            line-height: 1.3;
            flex: 1;
            margin-right: 1rem;
        }

        .card-id {
            background: #6366F1;
            color: white;
            padding: 0.3rem 0.8rem;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
            white-space: nowrap;
        }

        .card-content {
            display: flex;
            gap: 1.5rem;
            flex: 1;
            margin-bottom: 1.5rem;
        }

        .info-section {
            flex: 0 0 60%;
        }

        .document-section {
            flex: 0 0 40%;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
        }

        .info-row {
            display: flex;
            align-items: flex-start;
            margin-bottom: 1rem;
            gap: 0.8rem;
        }

        .info-icon {
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #6B7280;
            font-size: 0.9rem;
            margin-top: 0.1rem;
        }

        .info-content {
            flex: 1;
        }

        .info-label {
            font-size: 0.75rem;
            color: #9CA3AF;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.2rem;
        }

        .info-value {
            font-size: 0.95rem;
            color: #374151;
            font-weight: 500;
            line-height: 1.4;
        }

        .amount-value {
            color: #059669;
            font-weight: 600;
            font-size: 1.1rem;
        }

        .status-badge {
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
        }

        .status-approved {
            background: #10B981;
            color: white;
        }

        .status-disapproved {
            background: #F59E0B;
            color: white;
        }

        .status-pending {
            background: #6B7280;
            color: white;
        }

        .document-container {
            background: #F8FAFC;
            border-radius: 15px;
            padding: 1rem;
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .document-image {
            width: 100%;
            height: 200px;
            border-radius: 12px;
            object-fit: cover;
            border: 3px solid #E5E7EB;
            transition: all 0.3s ease;
            cursor: pointer;
            margin-bottom: 0.8rem;
        }

        .document-image:hover {
            transform: scale(1.02);
            border-color: #6366F1;
            box-shadow: 0 8px 25px rgba(99, 102, 241, 0.3);
        }

        .document-image.error {
            background: #F3F4F6;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #9CA3AF;
            font-size: 3rem;
        }

        .document-label {
            color: #6B7280;
            font-size: 0.85rem;
            font-weight: 500;
            text-align: center;
        }

        .actions-section {
            display: flex;
            gap: 0.5rem;
            margin-top: auto;
            flex-wrap: wrap;
        }

        .action-form {
            flex: 1;
            min-width: 80px;
        }

        .action-btn {
            width: 100%;
            padding: 0.6rem 1rem;
            border: none;
            border-radius: 8px;
            font-weight: 500;
            font-size: 0.8rem;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.4rem;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .btn-approve {
            background: #10B981;
            color: white;
        }

        .btn-approve:hover {
            background: #059669;
            transform: translateY(-1px);
        }

        .btn-disapprove {
            background: #F59E0B;
            color: white;
        }

        .btn-disapprove:hover {
            background: #D97706;
            transform: translateY(-1px);
        }

        .btn-delete {
            background: #EF4444;
            color: white;
        }

        .btn-delete:hover {
            background: #DC2626;
            transform: translateY(-1px);
        }

        .btn-disabled {
            background: #E5E7EB;
            color: #9CA3AF;
            cursor: not-allowed;
            opacity: 0.7;
        }

        .btn-disabled:hover {
            transform: none;
            background: #E5E7EB;
        }

        .no-scholarships {
            grid-column: 1 / -1;
            text-align: center;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 3rem;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .no-scholarships h3 {
            color: #6B7280;
            font-size: 1.3rem;
            margin-bottom: 0.5rem;
        }

        .no-scholarships p {
            color: #9CA3AF;
            font-size: 1rem;
        }

        .error-message {
            grid-column: 1 / -1;
            background: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.3);
            color: #DC2626;
            padding: 1.5rem;
            border-radius: 15px;
            text-align: center;
        }

        /* Image Modal */
        .image-modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.8);
            backdrop-filter: blur(5px);
        }

        .modal-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            max-width: 90%;
            max-height: 90%;
            border-radius: 15px;
            overflow: hidden;
        }

        .modal-image {
            width: 100%;
            height: auto;
            display: block;
        }

        .close-modal {
            position: absolute;
            top: 15px;
            right: 25px;
            color: white;
            font-size: 35px;
            font-weight: bold;
            cursor: pointer;
            z-index: 1001;
            background: rgba(0, 0, 0, 0.5);
            border-radius: 50%;
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .close-modal:hover {
            background: rgba(0, 0, 0, 0.7);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            .scholarship-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }

            .header h1 {
                font-size: 1.8rem;
            }

            .stats-bar {
                gap: 1rem;
            }

            .stat-item {
                min-width: 100px;
                padding: 1rem 1.5rem;
            }

            .card-content {
                flex-direction: column;
                gap: 1rem;
            }

            .info-section {
                flex: none;
            }

            .document-section {
                flex: none;
            }

            .document-image {
                height: 150px;
            }

            .actions-section {
                flex-direction: column;
            }

            .card-header {
                flex-direction: column;
                gap: 0.5rem;
            }

            .card-id {
                align-self: flex-start;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 0.5rem;
            }

            .scholarship-card {
                padding: 1.5rem;
                min-height: 600px;
            }

            .header {
                padding: 1.5rem;
            }

            .stats-bar {
                flex-direction: column;
                align-items: center;
            }

            .stat-item {
                min-width: 150px;
            }

            .document-image {
                height: 120px;
            }
        }
    </style>
</head>
<body>
    <div class="background-overlay"></div>

    <!-- Image Modal -->
    <div id="imageModal" class="image-modal">
        <span class="close-modal" onclick="closeModal()">&times;</span>
        <div class="modal-content">
            <img id="modalImage" class="modal-image" src="/placeholder.svg" alt="Document Image">
        </div>
    </div>

    <div class="container">
        <div class="header">
            <h1><i class="fas fa-cogs"></i> Manage Scholarships</h1>
            <p>Review, approve, and manage scholarship applications efficiently</p>
        </div>

        <%
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            
            // Variables for statistics
            int totalCount = 0;
            int approvedCount = 0;
            int pendingCount = 0;
            int disapprovedCount = 0;
            
            try {
                con = Dbconnection.connect();
                
                // First, get statistics
                ps = con.prepareStatement("SELECT status, COUNT(*) as count FROM scholarships GROUP BY status");
                rs = ps.executeQuery();
                
                while (rs.next()) {
                    String status = rs.getString("status");
                    int count = rs.getInt("count");
                    totalCount += count;
                    
                    if ("approved".equalsIgnoreCase(status)) {
                        approvedCount = count;
                    } else if ("disapproved".equalsIgnoreCase(status)) {
                        disapprovedCount = count;
                    } else {
                        pendingCount = count;
                    }
                }
                
                rs.close();
                ps.close();
        %>

        <div class="stats-bar">
            <div class="stat-item">
                <span class="stat-number"><%= totalCount %></span>
                <span class="stat-label">Total</span>
            </div>
            <div class="stat-item">
                <span class="stat-number"><%= approvedCount %></span>
                <span class="stat-label">Approved</span>
            </div>
            <div class="stat-item">
                <span class="stat-number"><%= pendingCount %></span>
                <span class="stat-label">Pending</span>
            </div>
            <div class="stat-item">
                <span class="stat-number"><%= disapprovedCount %></span>
                <span class="stat-label">Disapproved</span>
            </div>
        </div>

        <div class="scholarship-grid">
            <%
                // Now get all scholarships
                ps = con.prepareStatement("SELECT * FROM scholarships ORDER BY id DESC");
                rs = ps.executeQuery();
                
                boolean hasScholarships = false;
                
                while (rs.next()) {
                    hasScholarships = true;
                    int id = rs.getInt("id");
                    String title = rs.getString("title");
                    String eligibility = rs.getString("eligibility");
                    int amount = rs.getInt("amount");
                    String deadline = rs.getString("deadline");
                    String status = rs.getString("status");
                    
                    String badgeClass = "pending";
                    String badgeLabel = "Pending Review";
                    
                    if ("approved".equalsIgnoreCase(status)) {
                        badgeClass = "approved";
                        badgeLabel = "Approved";
                    } else if ("disapproved".equalsIgnoreCase(status)) {
                        badgeClass = "disapproved";
                        badgeLabel = "Disapproved";
                    }
            %>
            
            <div class="scholarship-card">
                <div class="card-header">
                    <h3 class="card-title"><%= title %></h3>
                    <div class="card-id">ID: <%= String.format("%03d", id) %></div>
                </div>

                <div class="card-content">
                    <div class="info-section">
                        <div class="info-row">
                            <div class="info-icon">
                                <i class="fas fa-user-graduate"></i>
                            </div>
                            <div class="info-content">
                                <div class="info-label">Eligibility Criteria</div>
                                <div class="info-value"><%= eligibility %></div>
                            </div>
                        </div>

                        <div class="info-row">
                            <div class="info-icon">
                                <i class="fas fa-rupee-sign"></i>
                            </div>
                            <div class="info-content">
                                <div class="info-label">Scholarship Amount</div>
                                <div class="info-value amount-value">₹<%= String.format("%,d", amount) %></div>
                            </div>
                        </div>

                        <div class="info-row">
                            <div class="info-icon">
                                <i class="fas fa-calendar-alt"></i>
                            </div>
                            <div class="info-content">
                                <div class="info-label">Application Deadline</div>
                                <div class="info-value"><%= deadline %></div>
                            </div>
                        </div>

                        <div class="info-row">
                            <div class="info-icon">
                                <i class="fas fa-info-circle"></i>
                            </div>
                            <div class="info-content">
                                <div class="info-label">Current Status</div>
                                <div class="info-value">
                                    <span class="status-badge status-<%= badgeClass %>">
                                        <%= badgeLabel %>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="document-section">
                        <div class="document-container">
                            <img src="DocumentServlet?id=<%= id %>" 
                                 class="document-image" 
                                 alt="Scholarship Document" 
                                 onclick="openModal('DocumentServlet?id=<%= id %>')"
                                 onerror="this.style.display='flex'; this.innerHTML='<i class=\'fas fa-image\'></i>'; this.classList.add('error');">
                            <div class="document-label">Click to view full size</div>
                        </div>
                    </div>
                </div>

                <div class="actions-section">
                    <% if (!"approved".equalsIgnoreCase(status)) { %>
                    <form method="post" action="ScholarshipActionServlet" class="action-form">
                        <input type="hidden" name="id" value="<%= id %>">
                        <button type="submit" name="action" value="approve" class="action-btn btn-approve">
                            <i class="fas fa-check"></i> Approve
                        </button>
                    </form>
                    <% } else { %>
                    <div class="action-form">
                        <button type="button" class="action-btn btn-disabled">
                            Already Approved
                        </button>
                    </div>
                    <% } %>
                    
                    <% if (!"disapproved".equalsIgnoreCase(status)) { %>
                    <form method="post" action="ScholarshipActionServlet" class="action-form">
                        <input type="hidden" name="id" value="<%= id %>">
                        <button type="submit" name="action" value="disapprove" class="action-btn btn-disapprove">
                            <i class="fas fa-times"></i> Disapprove
                        </button>
                    </form>
                    <% } else { %>
                    <div class="action-form">
                        <button type="button" class="action-btn btn-disabled">
                            Already Disapproved
                        </button>
                    </div>
                    <% } %>
                    
                    <form method="post" action="ScholarshipActionServlet" class="action-form">
                        <input type="hidden" name="id" value="<%= id %>">
                        <button type="submit" name="action" value="delete" class="action-btn btn-delete"
                                onclick="return confirm('Are you sure you want to delete this scholarship?')">
                            <i class="fas fa-trash"></i> Delete
                        </button>
                    </form>
                </div>
            </div>
            
            <%
                }
                
                if (!hasScholarships) {
            %>
            <div class="no-scholarships">
                <h3><i class="fas fa-inbox"></i> No Scholarships Found</h3>
                <p>There are currently no scholarships in the system.</p>
            </div>
            <%
                }
            %>
        </div>

        <%
            } catch (Exception e) {
                e.printStackTrace();
        %>
        <div class="error-message">
            <h3><i class="fas fa-exclamation-triangle"></i> Database Error</h3>
            <p>Unable to load scholarships. Please check your database connection.</p>
        </div>
        <%
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception e) {}
                try { if (ps != null) ps.close(); } catch (Exception e) {}
                try { if (con != null) con.close(); } catch (Exception e) {}
            }
        %>
    </div>

    <script>
        function openModal(imageSrc) {
            document.getElementById('modalImage').src = imageSrc;
            document.getElementById('imageModal').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('imageModal').style.display = 'none';
        }

        // Close modal when clicking outside the image
        window.onclick = function(event) {
            const modal = document.getElementById('imageModal');
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        }

        // Close modal with Escape key
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                closeModal();
            }
        });
    </script>
</body>
</html>
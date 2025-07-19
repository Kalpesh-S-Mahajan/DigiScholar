package com.digischolar;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@MultipartConfig(maxFileSize = 1024 * 1024 * 10) // 10MB max
public class PostScholarshipServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String message;

        try {
            int id = 0; // AUTO_INCREMENT in DB
            int instituteId = GetSet.getId(); // assuming this returns logged-in institute's ID
            String title = request.getParameter("title");
            String eligibility = request.getParameter("eligibility");
            double amount = Double.parseDouble(request.getParameter("amount"));
            String deadline = request.getParameter("deadline");

            Part filePart = request.getPart("document");
            InputStream fileStream = filePart != null ? filePart.getInputStream() : null;

            Connection conn = com.digischolar.Dbconnection.connect();
            PreparedStatement pstmt = conn.prepareStatement(
                "INSERT INTO scholarships (id, instituteId, title, eligibility, amount, deadline, document, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
            );

            pstmt.setInt(1, id); // AUTO_INCREMENT — can be 0 or use NULL in DB directly
            pstmt.setInt(2, instituteId);
            pstmt.setString(3, title);
            pstmt.setString(4, eligibility);
            pstmt.setDouble(5, amount);
            pstmt.setString(6, deadline);
            pstmt.setBlob(7, fileStream);
            pstmt.setString(8, "pending"); // set status to 'pending'

            int i = pstmt.executeUpdate();
            message = (i > 0) ? "Scholarship posted successfully!" : "Failed to post scholarship.";

        } catch (Exception e) {
            e.printStackTrace();
            message = "Error: " + e.getMessage();
        }

        out.println("<h3>" + message + "</h3>");
    }
}

package com.digischolar;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class DocumentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        try (Connection con = Dbconnection.connect();
             PreparedStatement ps = con.prepareStatement("SELECT document FROM scholarships WHERE id = ?")) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Blob blob = rs.getBlob("document");

                if (blob != null) {
                    // You can detect and set correct content-type later
                    response.setContentType("image/jpeg");
                    byte[] imgBytes = blob.getBytes(1, (int) blob.length());
                    response.getOutputStream().write(imgBytes);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "No document found.");
                }
            }
        } catch (Exception e) {
            throw new ServletException("Fetching document failed", e);
        }
    }
}

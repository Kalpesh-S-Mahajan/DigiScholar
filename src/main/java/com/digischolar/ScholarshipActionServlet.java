package com.digischolar;



import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class ScholarshipActionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String action = request.getParameter("action");

        try (Connection con = Dbconnection.connect()) {
            if ("approve".equals(action)) {
                try (PreparedStatement ps = con.prepareStatement("UPDATE scholarships SET status='approved' WHERE id=?")) {
                    ps.setInt(1, id);
                    ps.executeUpdate();
                }
            } else if ("disapprove".equals(action)) {
                try (PreparedStatement ps = con.prepareStatement("UPDATE scholarships SET status='disapproved' WHERE id=?")) {
                    ps.setInt(1, id);
                    ps.executeUpdate();
                }
            } else if ("delete".equals(action)) {
                try (PreparedStatement ps = con.prepareStatement("DELETE FROM scholarships WHERE id=?")) {
                    ps.setInt(1, id);
                    ps.executeUpdate();
                }
            }
        } catch (Exception e) {
            throw new ServletException("Database action failed", e);
        }

        response.sendRedirect("managescholarships.jsp");
    }
}

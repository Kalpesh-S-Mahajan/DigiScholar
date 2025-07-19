<%@ page import="java.sql.*" %>
<%@ page import="com.digischolar.Dbconnection" %>
<%
    String message = null;

    String idStr = request.getParameter("id");
    if (idStr != null && !idStr.isEmpty()) {
        try {
            int id = Integer.parseInt(idStr);
            Connection conn = Dbconnection.connect();

            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM institute WHERE id = ?");
            pstmt.setInt(1, id);

            int rowsDeleted = pstmt.executeUpdate();

            if (rowsDeleted > 0) {
                message = "Institute deleted successfully!";
            } else {
                message = "Institute not found or already deleted.";
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        }
    } else {
        message = "Invalid institute ID.";
    }

    response.sendRedirect("manageinstitutes.jsp?msg=" + java.net.URLEncoder.encode(message, "UTF-8"));
%>

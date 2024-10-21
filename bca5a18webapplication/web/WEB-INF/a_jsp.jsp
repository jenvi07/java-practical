<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Registration</title>
</head>
<body>
    <h2>Customer Registration Form</h2>
    <form action="newjsp.jsp" method="post">
        Name: <input type="text" name="name" required><br>
        Email: <input type="email" name="email" required><br>
        Phone: <input type="text" name="phone" required><br>
        <input type="submit" value="Register">
    </form>

    <%
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        if (name != null && email != null && phone != null) {
            Connection con = null;
            PreparedStatement ps = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bca5a18", "root", "");
                
                // Validate inputs
                if (name.isEmpty() || email.isEmpty() || phone.isEmpty()) {
                    out.println("All fields are required.");
                } else {
                    ps = con.prepareStatement("INSERT INTO customer(name, email, phone) VALUES (?, ?, ?)");
                    ps.setString(1, name);
                    ps.setString(2, email);
                    ps.setString(3, phone);
                    ps.executeUpdate();
                    out.println("Registration successful!");
                }
            } catch (SQLException e) {
                out.println("Database error: Please try again later.");
                // Log the error for debugging (consider using a logging framework)
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                out.println("Database driver not found.");
            } finally {
                if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    %>
</body>
</html>

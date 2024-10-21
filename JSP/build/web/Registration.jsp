<%-- 
    Document   : CustomerLogin
    Created on : 07-Aug-2024, 8:30:31 am
    Author     : jenvi
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Login</title>
    </head>
    <body>
        <%
            String user = (String) session.getAttribute("Name");
            if (request.getMethod().equals("POST")) {
                try {
                    String name = request.getParameter("name");
                    String phone = request.getParameter("phone");
                    int age = 1;
                    age = Integer.parseInt(request.getParameter("age"));
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String DB_URL = "jdbc:mysql://localhost:3306/bca5a18";
                    Connection conn = DriverManager.getConnection(DB_URL, "root", "");
                    String SQL = "INSERT INTO customers (name, phone, age)VALUES(?, ?, ?)";

                    PreparedStatement stmt = conn.prepareStatement(SQL);
                    stmt.setString(1, name);
                    stmt.setString(2, phone);
                    stmt.setInt(3, age);

                    int inserted = stmt.executeUpdate();
                    if (inserted == 1) {
                        response.sendRedirect("Registration.jsp");
                    }
                    stmt.close();
                    conn.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                    out.println("<p>Error: " + ex.getMessage() + "</p>");
                }
            }
        %>
    <center>
        <table border="1">
            <tr>
                <th colspan="2"><h1>Customer Login From</h1></th>
            </tr>
            <form method="POST">
                <tr>
                    <td> <label for="Name">Name: </label></td>
                    <td><input type ="text" id="Name" name="Name" required></td>
                </tr>
                <tr>
                    <td> <label for="phone">Phone: </label></td>
                    <td><input type ="text" id="phone" name="phone" required></td>
                </tr>
                <tr>
                    <td> <label for="age">Age: </label></td>
                    <td><input type ="text" id="age" name="age" required></td>
                </tr>
                <tr><td colspan="2" align="center"><button type="submit">Register</button></td></tr>
            </form>
        </table>
    </center>
</body>
</html>

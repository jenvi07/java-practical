<%-- 
    Document   : add
    Created on : 13-Aug-2024, 7:25:43 pm
    Author     : jenvi
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Student</title>
</head>
<body>
    <h1>Add New Student</h1>
    
    <%
        if (request.getMethod().equals("POST")) {
            String rollno = request.getParameter("rollno");
            String name = request.getParameter("name");
            String department = "Computer"; // Fixed value for Computer Department
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                String jdbcUrl = "jdbc:mysql://localhost:3310/college";
                String username = "root";
                String password = "";
                Connection connection = DriverManager.getConnection(jdbcUrl, username, password);
                
                String sqlQuery = "INSERT INTO students (rollno, name, department) VALUES (?, ?, ?)";
                PreparedStatement preparedStatement = connection.prepareStatement(sqlQuery);
                preparedStatement.setString(1, rollno);
                preparedStatement.setString(2, name);
                preparedStatement.setString(3, department);
                preparedStatement.executeUpdate();
                
                preparedStatement.close();
                connection.close();
                
                response.sendRedirect("jdbcmain.jsp"); // Redirect back to students list
            } catch (Exception e) {
                out.println("An error occurred: " + e.getMessage()); 
                e.printStackTrace();
            }
        }
    %>
    
    <form action="" method="post">
        <label for="rollno">Roll No:</label>
        <input type="text" id="rollno" name="rollno" required><br><br>
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required><br><br>
        <input type="submit" value="Add Student">
    </form>
    
    <p><a href="jdbcmain.jsp">Back to Students List</a></p>
</body>
</html>


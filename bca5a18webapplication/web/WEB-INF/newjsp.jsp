//////////////// *RMI DEMO CLIENT.JAVA*
// Client.java 
import java.rmi.registry.LocateRegistry; 
import java.rmi.registry.Registry; 
 
public class Client { 
    public static void main(String[] args) { 
        try { 
            Registry registry = LocateRegistry.getRegistry("localhost", 1099); 
            RemoteInterface remoteObject = (RemoteInterface) registry.lookup("RemoteObject"); 
            String response = remoteObject.sayHello(); 
            System.out.println("Response from server: " + response); 
            String response2 = remoteObject.sayBye(); 
            System.out.println("Response from server: " + response2); 
        } catch (Exception e) { 
            System.err.println("Client exception: " + e.toString()); 
            e.printStackTrace(); 
        } 
    } 
}
/////////////////////////////*get and set cookies through JSP*

<%@ page language="java" import="java.util.*" %>
<%
    String cookieName = "myCookie";
    String cookieValue = request.getParameter("cookieValue");

    if (cookieValue != null && !cookieValue.isEmpty()) {
        Cookie cookie = new Cookie(cookieName, cookieValue);
        cookie.setPath("/"); // Set path to make cookie accessible across the application
        cookie.setMaxAge(60 * 60 * 24); // Set expiration to 1 day
        response.addCookie(cookie);
        response.sendRedirect("createCookie.jsp"); // Redirect to the same page
    }
%>
<html>
<body>
    <%
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                out.println(cookie.getName() + " : " + cookie.getValue() + "<br/>");
            }
        }
    %>
    <form action="createCookie.jsp">
        <table>
            <tr>
                <td>Cookie value:</td>
                <td><input type="text" name="cookieValue" /></td>
            </tr>
            <tr>
                <td colspan="2"><button type="submit">Submit</button></td>
            </tr>
        </table>
    </form>
</body>
</html>
[05/08, 12:02 pm] null: <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Computer Department Students</title>
</head>
<body>
    <h1>Computer Department Students</h1>
    
    <%
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String jdbcUrl = "jdbc:mysql://localhost:3310/college";
            String username = "root";
            String password = "";
            Connection connection = DriverManager.getConnection(jdbcUrl, username, password);
            
            Statement statement = connection.createStatement();
            String sqlQuery = "SELECT * FROM students WHERE department='Computer'";
            ResultSet resultSet = statement.executeQuery(sqlQuery);
            
            out.println("<table border='1'>");
            out.println("<tr><th>Roll No</th><th>Name</th><th>Department</th><th>Action</th></tr>");
            while (resultSet.next()) {
                String rollno = resultSet.getString("rollno");
                String name = resultSet.getString("name");
                String department = resultSet.getString("department");
                out.println("<tr><td>" + rollno + "</td><td>" + name + "</td><td>" + department + "</td>" +
                            "<td><a href='edit.jsp?rollno=" + rollno + "'>Edit</a> | <a href='delete.jsp?rollno=" + rollno + "'>Delete</a></td></tr>");
            }
            out.println("</table>");
            
            resultSet.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            out.println("An error occurred: " + e.getStackTrace()[0]);    
        }
    %>
    
    <p><a href="add.jsp">Add New Student</a></p>   
</body>
</html>
 ///////////////////////////////////////////////*add.jsp*
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
/////////////////////////// *edit.jsp*
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Student</title>
</head>
<body>
    <h1>Edit Student</h1>
    
    <%
        String rollnoParam = request.getParameter("rollno");
        
        if (request.getMethod().equals("POST")) {
            String rollno = request.getParameter("rollno");
            String name = request.getParameter("name");
            String department = request.getParameter("department");
            
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String jdbcUrl = "jdbc:mysql://localhost:3310/college";
                String username = "root";
                String password = "";
                Connection connection = DriverManager.getConnection(jdbcUrl, username, password);
                
                String sqlQuery = "UPDATE students SET name=?, department=? WHERE rollno=?";
                PreparedStatement preparedStatement = connection.prepareStatement(sqlQuery);
                preparedStatement.setString(1, name);
                preparedStatement.setString(2, department);
                preparedStatement.setString(3, rollno);
                preparedStatement.executeUpdate();
                
                preparedStatement.close();
                connection.close();
                
                response.sendRedirect("jdbcmain.jsp"); // Redirect back to students list
            } catch (Exception e) {
                out.println("An error occurred: " + e.getStackTrace()[0]);
                
    }
        } else {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String jdbcUrl = "jdbc:mysql://localhost:3310/college";
                String username = "root";
                String password = "";
                Connection connection = DriverManager.getConnection(jdbcUrl, username, password);
                
                Statement statement = connection.createStatement();
                String sqlQuery = "SELECT * FROM students WHERE rollno='" + rollnoParam + "'";
                ResultSet resultSet = statement.executeQuery(sqlQuery);
                
                if (resultSet.next()) {
                    String rollno = resultSet.getString("rollno");
                    String name = resultSet.getString("name");
                    String department = resultSet.getString("department");
    %>
    
    <form action="" method="post">
        <input type="hidden" name="rollno" value="<%= rollno %>">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" value="<%= name %>" required><br><br>
        <label for="department">Department:</label>
        <input type="text" id="department" name="department" value="<%= department %>" required><br><br>
        <input type="submit" value="Update">
    </form>
    
    <%
                } else {
                    out.println("Student not found.");
                }
                
                resultSet.close();
                statement.close();
                connection.close();
            } catch (Exception e) {
                out.println("An error occurred: " + e.getStackTrace()[0]);    
            }
        }
    %>
    
    <p><a href="jdbcmain.jsp">Back to Students List</a></p>
</body>
</html>
///////////////////////*delete.jsp*
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Student</title>
</head>
<body>
    <h1>Delete Student</h1>
    
    <%
        String rollnoParam = request.getParameter("rollno");
        
        try {
            if (request.getMethod().equals("POST")) {
                Class.forName("com.mysql.jdbc.Driver");
                String jdbcUrl = "jdbc:mysql://localhost:3310/college";
                String username = "root";
                String password = "";
                Connection connection = DriverManager.getConnection(jdbcUrl, username, password);
                
                String sqlQuery = "DELETE FROM students WHERE rollno=?";
                PreparedStatement preparedStatement = connection.prepareStatement(sqlQuery);
                preparedStatement.setString(1, rollnoParam);
                preparedStatement.executeUpdate();
                
                preparedStatement.close();
                connection.close();
                
                response.sendRedirect("jdbcmain.jsp"); // Redirect back to students list
            }
        } catch (Exception e) {
            out.println("An error occurred: " + e.getStackTrace()[0]);    
        }
    %>
    
    <p>Are you sure you want to delete the following student?</p>
    <form action="" method="post">
        <input type="hidden" name="rollno" value="<%= rollnoParam %>">
        <input type="submit" value="Delete">
    </form>
    
    <p><a href="jdbcmain.jsp">Back to Students List</a></p>
</body>
</html>
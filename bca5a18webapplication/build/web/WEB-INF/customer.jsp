<!-- 4. Create a customer registration form using JSP, insert data into customer table when user submits the form.-->
<%-- 
    Document   : customer
    Created on : 13-Aug-2024, 6:19:30 pm
    Author     : jenvi
--%>
<%@page import = "java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Registration</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            String user = (String)session.getAttribute("username");
                if(request.getMethod().equals("POST")){
                    try{
                        String name=request.getParameter("name");
                        String number=request.getParameter("number");
                        int age = Integer.parseInt(request.getParameter("age"));
                        Class.forName("com.mysql.cj.jdbc:driver");
                        String DB_URL="jdbc:mysql://localhost:3306/bca18";
                        
                        Connection conn=DriverManager.getConnection(DB_URL,"root","");
                        String SQL = "INSERT INTO Customer_jsp SET name=?, number=?, age=?";
                        
                        PreparedStatement stmt = conn.prepareStatement(SQL);
                        stmt.setString(1, name);
                        stmt.setString(2, number);
                        stmt.setInt(3, age);
                        
                        int inserted = stmt.executeUpdate();
                        if(inserted==1){
                            response.sendRedirect("customerTable.jsp");
            }
            stmt.close();
            conn.close();
            }
            catch(SQLException ex){
                ex.printStackTrace();
            }
            }
         %>
    <h2>Register Customer</h2>
    <form method="POST" action="">
        <label>Name:</label>
        <input type="text", name="name">
        <label>Number:</label>
        <input type="text", name="number">
        <label>age:</label>
        <input type="number", name="age">
        <button type="submit">Submit</button>
    </form>
    </body>
</html>

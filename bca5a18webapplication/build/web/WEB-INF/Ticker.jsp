<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <title>Server-Side Day, Date, and Time Ticker</title>
    <meta http-equiv="refresh" content="1">
    <style>
        body {
            font-family: 'Courier New', Courier, monospace;
            text-align: center;
            margin-top: 20%;
            background-color: #e9ecef;
        }
        #ticker {
            font-size: 80px;
            color: #495057;
            padding: 15px;
            border: 3px double #28a745;
            border-radius: 20px;
            background-color: #fff;
        }
    </style>
</head>
<body>
    <div id="ticker">
        <%
            Date now = new Date();
            String day = now.toString().split(" ")[0];
            String date = now.toString().substring(4, 10) + " " + now.toString().substring(20, 24);
            String time = now.toString().substring(11, 19);
            out.println(day + ", " + date + " " + time);
        %>
    </div>
</body>
</html>

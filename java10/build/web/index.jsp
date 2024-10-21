<%-- 
    Document   : index
    Created on : 20-Oct-2024, 10:55:56 am
    Author     : jenvi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Math Quiz</title>
    </head>
    <body>
        <%
            String restart = request.getParameter("restart");
            int num1 = (int) (Math.random() * 100);
            int num2 = (int) (Math.random() * 100);
            int operator = (int) (Math.random() * 3);
            String operation;
            int score = 0;
            
            switch(operator){
                case 0:
                    operation = "+";
                    break;
                case 1:
                    operation = "-";
                    break;
                case 2:
                    operation = "*";
                    break;
                default: 
                    operation = "+";
            }
            
            Integer userScore = (Integer) session.getAttribute("userScore");
            if(userScore != null){
                if(restart.equals("true")){
                    session.setAttribute("userScore", score);
                    userScore = (Integer) session.getAttribute("userScore");
                }
            } else{
                session.setAttribute("userScore", score);
            }
        %>
        
        <h1>Math Quiz</h1>
        <h3>Your Score is: <%= userScore %></h3> <button><a href="index.jsp?restart=true">Restart Game</a></button>
        <p>What is <%= num1 %> <%= operation %> <%= num2 %>?</p>
        <form action="result.jsp" method="post">
            <input type="text" name="answer" required>
            <input type="hidden" name="num1" value="<%= num1 %>">
            <input type="hidden" name="num2" value="<%= num2 %>">
            <input type="hidden" name="operator" value="<%= operator %>">
            <input type="submit" value="submit">
        </form>
    </body>
</html>
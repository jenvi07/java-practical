<%-- 
    Document   : result
    Created on : 20-Oct-2024, 10:57:10 am
    Author     : jenvi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quiz Result</title>
    </head>
    <body>
        <%
            int num1 = Integer.parseInt(request.getParameter("num1"));
            int num2 = Integer.parseInt(request.getParameter("num2"));
            int operator = Integer.parseInt(request.getParameter("operator"));
            int userAnswer = Integer.parseInt(request.getParameter("answer"));
            int correctAnswer;
            
            switch(operator){
                case 0:
                    correctAnswer = num1 + num2;
                    break;
                case 1:
                    correctAnswer = num1 - num2;
                    break;
                case 2:
                    correctAnswer = num1 * num2;
                    break;
                default:
                    correctAnswer = num1 + num2;
            }
            
            if(userAnswer == correctAnswer){
                out.println("Congratiolations your answer is correct.");
                
                Integer userScore = (Integer) session.getAttribute("userScore");
                userScore++;
                session.setAttribute("userScore", userScore);
                
            } else{
                out.println("Sorry the correct answer is " + correctAnswer + ".");
            }
        %>
        <button><a href="index.jsp?restart=false">Next Question</a></button>
    </body>
</html>
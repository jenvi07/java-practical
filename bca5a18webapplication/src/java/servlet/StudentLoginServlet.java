package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;

public class StudentLoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter writer = response.getWriter();
        try {
            String name = request.getParameter("username");
            String password = request.getParameter("password");
            boolean valid = validateUser(name, password);
            if (valid) {
                HttpSession session = request.getSession(true);
                session.setAttribute("username", name);
                Cookie cookie = new Cookie("SESSION id", session.getId());
                response.addCookie(cookie);
                response.sendRedirect("welcome.html?sessionid=" + session.getId());
            } else {
                writer.write("Error, invalid user!");
            }
        } catch (Exception e) {
            writer.write(e.getMessage());
            e.printStackTrace();
        }
    }

    private boolean validateUser(String name, String password) throws SQLException, ClassNotFoundException {
        boolean status = false;
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/bca5a18");
        PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM student WHERE name=? AND password=?");
        preparedStatement.setString(1, name);
        preparedStatement.setString(2, password);
        ResultSet rs = preparedStatement.executeQuery();
        status = rs.next();
        return status;
    }    
}

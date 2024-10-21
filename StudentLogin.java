package bca5a18;
import java.sql.*;
/**import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;**/
import java.util.Scanner;

public class StudentLogin {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String url = "jdbc:mysql://localhost:3306/bca5a18";
        String username = "root";
        String password = "";

        try {
            Connection connection = DriverManager.getConnection(url, username, password);
            System.out.println("Connected to database successfully!");

            login(connection, scanner);

        } catch (SQLException e) {
            System.out.println("Error connecting to database: " + e.getMessage());
        } finally {
            scanner.close();
        }
    }

    private static void login(Connection connection, Scanner scanner) throws SQLException {
        System.out.print("Enter username: ");
        String username = scanner.nextLine();

        System.out.print("Enter password: ");
        String password = scanner.nextLine();

        String query = "SELECT * FROM student WHERE name = ? AND password = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setString(1, username);
        statement.setString(2, password);

        ResultSet resultSet = statement.executeQuery();

        if (resultSet.next()) {
            System.out.println("Login successful!");
            // Add logic for what happens after successful login
            System.out.println("welcome " + resultSet.getString("name")+"!");
        } else {
            System.out.println("Invalid username or password.");
        }

        resultSet.close();
        statement.close();
    }
}



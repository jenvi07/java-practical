package bca5a18;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
//import java.util.logging.Level;
//import java.util.logging.Logger;

public class UserDAO {

    private static final String url = "jdbc:mysql://localhost:3306/bca5a18";
    private static final String username = "root";
    private static final String password = "";

    public User createUser(User user) throws SQLException {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = getConnection();
            String sql = "INSERT INTO user(username, password)VALUES(?,?)";
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            statement.setString(1, user.getUserName());
            statement.setString(2, user.getPassword());

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected == 1) {
                resultSet = statement.getGeneratedKeys();

                if (resultSet.next()) {
                    user.setUserId(resultSet.getString(1));
                }
                return user;
            } else {
                throw new SQLException("User creation Failed! No row affected");
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            closeConnection(resultSet);
            closeConnection(statement);
            closeConnection(connection);
        }
    }

    public User getUser(String userId) throws SQLException {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try {
            connection = getConnection();
            String sql = "SELECT * FROM user WHERE userid=?";
            statement = connection.prepareStatement(sql);

            statement.setString(1, userId);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                User user = new User(
                        resultSet.getString("userid"),
                        resultSet.getString("username"),
                        resultSet.getString("password")
                );
                return user;
            } else {
                return null;
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            closeConnection(resultSet);
            closeConnection(statement);
            closeConnection(connection);
        }
    }

    public List<User> getAllUsers() throws SQLException {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try {
            connection = getConnection();
            String sql = "SELECT * FROM user";
            statement = connection.prepareStatement(sql);
            //statement.setString(1, userId);
            resultSet = statement.executeQuery();
            List<User> users = new ArrayList<>();
            while (resultSet.next()) {
                User user = new User(
                        resultSet.getString("userid"),
                        resultSet.getString("username"),
                        resultSet.getString("password")
                );
                users.add(user);
            }
            return users;
        } catch (SQLException e) {
            throw e;
        } finally {
            closeConnection(resultSet);
            closeConnection(statement);
            closeConnection(connection);
        }
    }

    public User updateUser(User user) throws SQLException {
        Connection connection = null;
        PreparedStatement statement = null;
        //   ResultSet resultSet = null;
        try {
            connection = getConnection();
            String sql = "UPDATE user SET username=?, password=? WHERE userid=?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, user.getUserName());
            statement.setString(2, user.getPassword());
            statement.setString(3, user.getUserId());

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected == 1) {
                return user;
            } else {
                throw new SQLException("User update failed! No rows affected!");
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            closeConnection(statement);
            closeConnection(connection);
        }
    }

    public void deleteUser(User user) throws SQLException {
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = getConnection();
            String sql = "DELETE FROM user WHERE userID=?";
            statement = connection.prepareStatement(sql);

            statement.setString(1, user.getUserId());

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected == 1) {
                System.out.println("User with ID: " + user.getUserId() + "deleted.");
            } else if (rowsAffected == 0) {
                System.out.println("User with ID: " + user.getUserId() + "not found.");
            } else {
                throw new SQLException("Unexpected error during user deletion: More than 1 row Affected");
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            closeConnection(statement);
            closeConnection(connection);
        }
    }

    private static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException e) {
            throw new SQLException("JDBC Driver class not found: " + e.getMessage());
        }

    }

    private static void closeConnection(AutoCloseable closeable) throws SQLException {
        if (closeable != null) {
            try {
                closeable.close();
            } catch (Exception e) {
                System.err.println("Exception occired while closing resoures:" + e.getMessage());
            }
        }
    }
}

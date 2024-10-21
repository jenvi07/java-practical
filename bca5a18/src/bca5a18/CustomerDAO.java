
package bca5a18;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
//import java.util.logging.Level;
//import java.util.logging.Logger;

public class CustomerDAO {

    private static final String URL = "jdbc:mysql://localhost:3306/bca5a18";
    private static final String USER = "root";
    private static final String PASS = "";

    public Customer createCustomer(Customer customer) throws SQLException {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = getConnection();
            String sql = "INSERT INTO customer(name, email, phone)VALUES(?,?,?)";
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            statement.setString(1, customer.getCustomerName());
            statement.setString(2, customer.getEmail());
            statement.setString(3, customer.getPhone());

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected == 1) {
                resultSet = statement.getGeneratedKeys();

                if (resultSet.next()) {
                    customer.setCustomerId(resultSet.getString(1));
                }
                return customer;
            } else {
                throw new SQLException("Customer creation Failed! No row affected");
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            closeConnection(resultSet);
            closeConnection(statement);
            closeConnection(connection);
        }
    }

    public Customer getCustomer(String customerId) throws SQLException {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try {
            connection = getConnection();
            String sql = "SELECT * FROM customer WHERE customerID=?";
            statement = connection.prepareStatement(sql);

            statement.setString(1, customerId);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                Customer customer = new Customer(
                        resultSet.getString("customerID"),
                        resultSet.getString("name"),
                        resultSet.getString("email"),
                        resultSet.getString("phone")
                );
                return customer;
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

    public List<Customer> getAllCustomers() throws SQLException {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try {
            connection = getConnection();
            String sql = "SELECT * FROM customer";
            statement = connection.prepareStatement(sql);
            //statement.setString(1, customerId);
            resultSet = statement.executeQuery();
            List<Customer> customers = new ArrayList<>();
            while (resultSet.next()) {
                Customer customer = new Customer(
                        resultSet.getString("customerID"),
                        resultSet.getString("name"),
                        resultSet.getString("email"),
                        resultSet.getString("phone")
                );
                customers.add(customer);
            }
            return customers;
        } catch (SQLException e) {
            throw e;
        } finally {
            closeConnection(resultSet);
            closeConnection(statement);
            closeConnection(connection);
        }
    }

    public Customer updateCustomer(Customer customer) throws SQLException {
        Connection connection = null;
        PreparedStatement statement = null;
        //   ResultSet resultSet = null;
        try {
            connection = getConnection();
            String sql = "UPDATE customer SET name=?, email=?, phone=? WHERE customerID=?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, customer.getCustomerName());
            statement.setString(2, customer.getEmail());
            statement.setString(3, customer.getPhone());
            statement.setString(4, customer.getCustomerId());

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected == 1) {
                return customer;
            } else {
                throw new SQLException("Customer update failed! No rows affected!");
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            closeConnection(statement);
            closeConnection(connection);
        }
    }

    public void deleteCustomer(Customer customer) throws SQLException {
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = getConnection();
            String sql = "DELETE FROM customer WHERE customerID=?";
            statement = connection.prepareStatement(sql);

            statement.setString(1, customer.getCustomerId());

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected == 1) {
                System.out.println("Customer with ID: " + customer.getCustomerId() + "deleted.");
            } else if (rowsAffected == 0) {
                System.out.println("Customer with ID: " + customer.getCustomerId() + "not found.");
            } else {
                throw new SQLException("Unexpected error during customer deletion: More than 1 row Affected");
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
            return DriverManager.getConnection(URL, USER, PASS);
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


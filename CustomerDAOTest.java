package bca5a18;

import java.sql.SQLException;
import java.util.List;

public class CustomerDAOTest {
    public static void main(String[] args) {
        try {
            CustomerDAO customerDao = new CustomerDAO();
            Customer customer1 = new Customer("1", "jenvi", "jp@gmail.com", "9876543210");

            customer1 = customerDao.createCustomer(customer1);
            System.out.println("Created Customer:" + customer1);

            //Test getting a customer
            String customerId = customer1.getCustomerId();
            Customer retrievedCustomer = customerDao.getCustomer(customerId);
            //if(retrievedCustomer = customerDao.getCustomer(customerId))
            if (retrievedCustomer != null) {
                System.out.println("Retrieved Customer: " + retrievedCustomer);
            } else {
                System.out.println("Customer with ID: " + customerId + "not found.");
            }
            //Update customer information
            retrievedCustomer.setCustomerName("new name");
            retrievedCustomer.setEmail("new email");
            retrievedCustomer.setPhone("new number");
            customerDao.updateCustomer(retrievedCustomer);
            System.out.println("Updated customer(retrieved again: ");
            retrievedCustomer = customerDao.getCustomer(customerId);
            System.out.println(retrievedCustomer);
            //Test deleting the customer
            customerDao.deleteCustomer(customer1);

            //Get all customers
            List<Customer> customers = customerDao.getAllCustomers();
            if (customers.isEmpty()) {
                System.out.println("No customers found in the database.");
            } else {
                System.out.println("Lists of all customers:");
                for (Customer customer : customers) {
                    System.out.println(customer);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

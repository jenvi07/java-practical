package bca5a18;

import java.sql.SQLException;
import java.util.List;

public class UserDAOTest {

    public static void main(String[] args) {
        try {
            UserDAO userDao = new UserDAO();
            User user1 = new User("1", "jenvi", "12345");

            user1 = userDao.createUser(user1);
            System.out.println("Created User:" + user1);

            //Test getting a user
            String userId = user1.getUserId();
            User retrievedUser = userDao.getUser(userId);
            //if(retrievedUser = userDao.getUser(userId))
            if (retrievedUser != null) {
                System.out.println("Retrieved User: " + retrievedUser);
            } else {
                System.out.println("User with ID: " + userId + "not found.");
            }
            //Update user information
            retrievedUser.setUserName("new name");
            retrievedUser.setpassword("new password");
            userDao.updateUser(retrievedUser);
            System.out.println("Updated user(retrieved again: ");
            retrievedUser = userDao.getUser(userId);
            System.out.println(retrievedUser);
            //Test deleting the user
            userDao.deleteUser(user1);

            //Get all users
            List<User> users = userDao.getAllUsers();
            if (users.isEmpty()) {
                System.out.println("No users found in the database.");
            } else {
                System.out.println("Lists of all users:");
                for (User user : users) {
                    System.out.println(user);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

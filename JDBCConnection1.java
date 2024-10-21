package bca5a18;
import java.sql.*;
public class JDBCConnection1 {
     static final String DBURL="jdbc:mysql://localhost:3306/bca5a18";
    static final String USER="root";
    static final String PASS="";
    static final String QUERY="SELECT userID, userName, password FROM user";
    
        public static void main(String[]args){
            
         try   {
               Connection conn=DriverManager.getConnection(DBURL,USER,PASS);
               Statement stmt=conn.createStatement();
               ResultSet rs=stmt.executeQuery(QUERY);
               
               while(rs.next()){
                   System.out.print("userId : "+rs.getString("userID"));
                   System.out.print(",userName : "+rs.getString("userName"));
                   System.out.println(", password : "+rs.getString("password"));
               }
            }catch(SQLException e){
                e.printStackTrace ();
            }
        }
    }


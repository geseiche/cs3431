//package otest;
import java.sql.*;
import java.util.Scanner;

/**
  * CS 3431 Project Phase 3
  *
  * @author Anthony Topper, Grace Seiche
  *
  */

public class p3 {

      private static String userID = "";
     private static String password = "";

     private static int mode;

     private static Connection connection;

     public static void main(String[] args) {

         if (args.length < 1) {
             System.out.println("Usage: java p3 <username> <password> <mode>");
             return;
         }

         userID = args[0];
         password = args[1];

         if (!login()) return;

         if(args.length <3){
             printUsage();
             return;
         }

         mode = Integer.parseInt(args[2]);


         if (mode == 0) {
             printUsage();
             return;
         }

         Scanner s = new Scanner(System.in);



         if (mode == 1) {
             System.out.print("Enter location ID: ");
             int locationID = s.nextInt();

             runQuery(locationID);

         }

         if (mode == 2) {

             System.out.print("Enter edge ID: ");
             String edgeID = s.nextLine();

             runQuery(edgeID);
         }

         if (mode == 3) {

             System.out.print("Enter CS Staff Account Name: ");
             String acct = s.nextLine();

             runQuery(acct);

         }

         if (mode == 4){
             System.out.print("Enter CS Staff Account Name: ");
             String acct = s.nextLine();
             System.out.print("Enter the new Phone Extension: ");
             int phone = s.nextInt();
             runInsert(acct, phone);
         }

         s.close();

         if (mode  == 5) {
             System.out.println("exiting");
             return;
         }

     }

     public static void printUsage(){
         System.out.println("1 - Report Location Information");
         System.out.println("2 - Report Edge Information");
         System.out.println("3 - Report CS Staff Information");
         System.out.println("4 - Insert New Phone Extension");
         System.out.println("5 - Exit Program");
     }

     public static boolean login() {
         System.out.println("-------Oracle JDBC Connection Testing---------");
         try {
             Class.forName("oracle.jdbc.driver.OracleDriver");

         } catch (ClassNotFoundException e){
             System.out.println("Where is your Oracle JDBC Driver?");
             e.printStackTrace();
             return false;
         }

         System.out.println("Oracle JDBC Driver Registered!");

         try {
              connection = DriverManager.getConnection(
                      "jdbc:oracle:thin:@oracle.wpi.edu:1521:orcl", userID, password);
         } catch (SQLException e) {
             System.out.println("Connection Failed! Check output console");
             e.printStackTrace();
             return false;
         }
         System.out.println("Oracle JDBC Driver Connected!");
         return true;
     }


     public static void runInsert(String acct, int phone) {
         try {
             // TODO do escape
             Statement stmt = connection.createStatement();
             String s = "INSERT INTO PhoneExtensions (accountName, phoneExt) VALUES ('"+acct+"',"+phone+")";
             int count = stmt.executeUpdate(s);

         } catch (SQLException e) {
             e.printStackTrace();
         }
     }

     public static void runQuery (Object arg) {


         // Performing the query
         try {
             Statement stmt = connection.createStatement();
             String str = null;

             if (mode == 1) {
                 str = "SELECT * FROM Locations WHERE locationID = '"+arg+"'";
             }
             if (mode == 2) {
                 str = "SELECT distinct "
                         +"E1.startLocName AS startName, E1.mapFloor AS startFloor, "
                         +"E2.endLocName AS endName,   E2.mapFloor AS endFloor "
                         +"FROM Edges J, "
                         +"(SELECT L.locationName as startLocName, L.locationID as startLocId, L.mapFloor FROM Locations L, Edges E WHERE L.locationID = "
                         +"E.startingLocationID) E1, "
                         +"(SELECT L.locationName as endLocName, L.locationID as endLocId, L.mapFloor FROM Locations L, Edges E WHERE L.locationID = "
                         +"E.endingLocationID)   E2 "
                         +"WHERE J.edgeID = '"+arg+"' and J.endingLocationID = E2.endLocID and J.startingLocationID = E1.startLocID";
             }
             if (mode == 3) {
                 str = "select * from CSStaff where accountName = '"+arg+"'";



             }

             System.out.println(str);
             ResultSet rset = stmt.executeQuery(str);


             while (rset.next()) {


                 if (mode == 1) {
                     System.out.println("Location Information");
                     System.out.println("Location ID: "+rset.getString("locationID"));
                     System.out.println("Location Name: "+rset.getString("locationName"));
                     System.out.println("Location Type: "+rset.getString("locationType"));
                     System.out.println("X-Coordinate: "+rset.getString("xcoord"));
                     System.out.println("Y-Coordinate: "+rset.getString("ycoord"));
                     System.out.println("Floor: "+rset.getString("mapFloor"));
                 }

                 if (mode == 2) {
                     System.out.println("Edges Information");
                     System.out.println("Edge ID: "+arg);
                     System.out.println("Starting Location Name: "+rset.getString("startName"));
                     System.out.println("Starting Location Floor: "+rset.getString("startFloor"));
                     System.out.println("Ending Location Name: "+rset.getString("endName"));
                     System.out.println("Ending Location Floor: "+rset.getString("endFloor"));
                 }
                 if (mode == 3) {
                     System.out.println("CS Staff Information");
                     System.out.println("Account Name: "+rset.getString("accountName"));
                     System.out.println("First Name: "+rset.getString("firstName"));
                     System.out.println("Last Name: "+rset.getString("lastName"));
                     System.out.println("Office ID: "+rset.getString("officeID"));



                 }


             }





             rset.close();

             // Read titles and phone extensions separately, as we may have more than one of each
             if (mode == 3) {
                 ResultSet titles = stmt.executeQuery("select T.TITLENAME from CSStaffTitles C, Titles T where ACCOUNTNAME = '"+arg+"' and T.ACRONYM = C.ACRONYM");

                 System.out.print("Title: ");
                 while (titles.next()) {
                     System.out.print(titles.getString("TITLENAME") +", ");
                 }
                 System.out.println();

                 ResultSet extensions = stmt.executeQuery("select * from PHONEEXTENSIONS where ACCOUNTNAME = '"+arg+"'");

                 System.out.print("Phone Ext: ");
                 while (extensions.next()) {
                	 System.out.print(extensions.getString("phoneExt") +", ");
                 }
                 System.out.println();

                 titles.close();
                 extensions.close();
             }

             stmt.close();
             connection.close();
         } catch (SQLException e) {
             System.out.println("Get Data Failed! Check output console");
             e.printStackTrace();
             return;
         }
     }

}

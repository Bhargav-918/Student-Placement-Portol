package org.example.placement.util;

import java.sql.Connection;

public class DBTest {

    public static void main(String[] args) {

        try {
            Connection connection = DBConnection.getConnection();

            if (connection != null) {
                System.out.println("================================");
                System.out.println("DATABASE CONNECTION SUCCESSFUL");
                System.out.println("================================");
            }

        } catch (Exception e) {
            System.out.println("DATABASE CONNECTION FAILED");
            e.printStackTrace();
        }
    }
}
package org.example.placement.dao;

import org.example.placement.model.Company;
import org.example.placement.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CompanyDAO {

    public Company getCompanyByUserId(int userId) {

        String sql = """
                SELECT id, user_id, company_name, description, website
                FROM companies
                WHERE user_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            ResultSet rs = statement.executeQuery();

            if (rs.next()) {

                Company company = new Company();

                company.setId(rs.getInt("id"));
                company.setUserId(rs.getInt("user_id"));
                company.setCompanyName(
                        rs.getString("company_name")
                );
                company.setDescription(
                        rs.getString("description")
                );
                company.setWebsite(
                        rs.getString("website")
                );

                return company;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    public boolean saveCompany(Company company) {

        String sql = """
                INSERT INTO companies
                (user_id, company_name, description, website)
                VALUES (?, ?, ?, ?)
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, company.getUserId());
            statement.setString(2, company.getCompanyName());
            statement.setString(3, company.getDescription());
            statement.setString(4, company.getWebsite());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    public boolean updateCompany(Company company) {

        String sql = """
                UPDATE companies
                SET company_name = ?,
                    description = ?,
                    website = ?
                WHERE user_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, company.getCompanyName());
            statement.setString(2, company.getDescription());
            statement.setString(3, company.getWebsite());
            statement.setInt(4, company.getUserId());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // Get all companies for Admin Dashboard
    public List<Company> getAllCompanies() {

        List<Company> companies = new ArrayList<>();

        String sql = """
                SELECT
                    id,
                    user_id,
                    company_name,
                    description,
                    website
                FROM companies
                ORDER BY id DESC
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {

                Company company = new Company();

                company.setId(rs.getInt("id"));
                company.setUserId(rs.getInt("user_id"));
                company.setCompanyName(
                        rs.getString("company_name")
                );
                company.setDescription(
                        rs.getString("description")
                );
                company.setWebsite(
                        rs.getString("website")
                );

                companies.add(company);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return companies;
    }
}
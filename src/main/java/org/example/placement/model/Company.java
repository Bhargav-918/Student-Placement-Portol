package org.example.placement.model;

public class Company {

    private int id;
    private int userId;
    private String companyName;
    private String description;
    private String website;

    public Company() {
    }

    public Company(int userId,
                   String companyName,
                   String description,
                   String website) {
        this.userId = userId;
        this.companyName = companyName;
        this.description = description;
        this.website = website;
    }

    public Company(int id,
                   int userId,
                   String companyName,
                   String description,
                   String website) {
        this.id = id;
        this.userId = userId;
        this.companyName = companyName;
        this.description = description;
        this.website = website;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }
}
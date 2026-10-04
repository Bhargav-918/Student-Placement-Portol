package org.example.placement.model;

public class Student {

    private int id;
    private int userId;
    private String rollNo;
    private String phone;
    private String branch;
    private double cgpa;
    private int graduationYear;
    private String resume;

    public Student() {
    }

    public Student(int userId, String rollNo, String phone,
                   String branch, double cgpa,
                   int graduationYear, String resume) {

        this.userId = userId;
        this.rollNo = rollNo;
        this.phone = phone;
        this.branch = branch;
        this.cgpa = cgpa;
        this.graduationYear = graduationYear;
        this.resume = resume;
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

    public String getRollNo() {
        return rollNo;
    }

    public void setRollNo(String rollNo) {
        this.rollNo = rollNo;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getBranch() {
        return branch;
    }

    public void setBranch(String branch) {
        this.branch = branch;
    }

    public double getCgpa() {
        return cgpa;
    }

    public void setCgpa(double cgpa) {
        this.cgpa = cgpa;
    }

    public int getGraduationYear() {
        return graduationYear;
    }

    public void setGraduationYear(int graduationYear) {
        this.graduationYear = graduationYear;
    }

    public String getResume() {
        return resume;
    }

    public void setResume(String resume) {
        this.resume = resume;
    }
}
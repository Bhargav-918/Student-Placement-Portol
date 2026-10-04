package org.example.placement.model;

import java.sql.Timestamp;

public class Interview {

    private int id;
    private int applicationId;

    private Timestamp interviewDate;

    private String mode;
    private String meetingLink;
    private String result;

    private String studentName;
    private String jobTitle;
    private String companyName;


    public Interview() {
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    public int getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(int applicationId) {
        this.applicationId = applicationId;
    }


    public Timestamp getInterviewDate() {
        return interviewDate;
    }

    public void setInterviewDate(Timestamp interviewDate) {
        this.interviewDate = interviewDate;
    }


    public String getMode() {
        return mode;
    }

    public void setMode(String mode) {
        this.mode = mode;
    }


    public String getMeetingLink() {
        return meetingLink;
    }

    public void setMeetingLink(String meetingLink) {
        this.meetingLink = meetingLink;
    }


    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }


    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }


    public String getJobTitle() {
        return jobTitle;
    }

    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle;
    }


    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }
}
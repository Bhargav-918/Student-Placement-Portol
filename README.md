# 🎓 Student Placement Portal

A Java-based web application designed to simplify and manage campus recruitment activities through a centralized platform for **Students, Recruiters, and Administrators**.

The Student Placement Portal digitizes the placement process by providing job postings, student applications, eligibility verification, interview scheduling, and placement statistics.

## 📌 Project Overview

Traditional campus placement activities often depend on manual records, spreadsheets, emails, and notice boards. These methods can cause delays, duplicate records, and difficulties in tracking applications.

The Student Placement Portal solves these problems by providing a centralized web application where students, recruiters, and administrators can manage placement activities efficiently.

## ✨ Features

### 👨‍🎓 Student Module
- Student registration and login.
- Student profile management.
- View available placement opportunities.
- Check job eligibility based on CGPA, branch, and graduation year.
- Apply for eligible job openings.
- Track application status.
- View interview schedules and results.

### 🏢 Recruiter Module
- Recruiter registration and login.
- Create and manage company profiles.
- Post new job opportunities.
- Update and close job postings.
- View student applications.
- Shortlist or reject candidates.
- Schedule interviews.
- Update interview results.

### 🛡️ Administrator Module
- Admin dashboard.
- View and manage student records.
- View recruiter and company information.
- Monitor job postings.
- View student applications.
- Access placement statistics.
- Monitor overall placement activities.

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| HTML5 | Web page structure |
| CSS3 | Styling and responsive design |
| JavaScript | Client-side interactions |
| Java | Backend programming |
| JSP | Dynamic web pages |
| Java Servlets | Request processing |
| JDBC | Database connectivity |
| MySQL | Database management |
| Apache Tomcat 10.1 | Application server |
| Maven | Dependency management |
| IntelliJ IDEA | Development environment |

## 🏗️ Project Architecture

The application follows a layered architecture.

1. **Presentation Layer:** JSP, HTML, CSS, and JavaScript handle the user interface.
2. **Controller Layer:** Java Servlets process HTTP requests, validate inputs, and manage sessions.
3. **Data Access Layer:** DAO classes and JDBC handle database operations.
4. **Database Layer:** MySQL stores application data.
5. **Runtime Environment:** Apache Tomcat hosts the web application.

### Request Flow

```text
        User / Browser
              |
              | HTTP Request
              |
       Apache Tomcat
              |
              v
        Java Servlets
       (Controller Layer)
              |
              v
         DAO Classes
        (JDBC Layer)
              |
              v
         MySQL Database
              |
              v
        Return Response
              |
              v
          JSP Pages
              |
              v
        User Interface
```

## 🗄️ Database Design

**Database Name:** `placement_portal`

The application uses six main tables:

| Table | Description |
|---|---|
| users | Stores user accounts and roles |
| students | Stores student academic and personal details |
| companies | Stores recruiter company information |
| jobs | Stores job postings and eligibility criteria |
| applications | Stores student job applications and statuses |
| interviews | Stores interview schedules and results |

### Application Status

- APPLIED
- SHORTLISTED
- REJECTED
- SELECTED

### Interview Results

- PENDING
- PASSED
- FAILED

## ⚙️ Installation and Setup

Follow these steps to run the project locally.

### 1. Prerequisites

Install the following:

- JDK 25 (or a compatible JDK)
- IntelliJ IDEA
- Apache Tomcat 10.1
- MySQL Server
- Maven

### 2. Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git
```

### 3. Open the Project

- Open IntelliJ IDEA.
- Select Open Project.
- Choose the cloned project folder.
- Allow Maven to download dependencies.

### 4. Configure MySQL

Create the database:

```sql
CREATE DATABASE placement_portal;
```

Configure your database connection URL, username, and password in the project's database connection utility (`DBConnection`).

Make sure the required database tables are created before running the application.

### 5. Configure Apache Tomcat

- Add Apache Tomcat 10.1 to IntelliJ IDEA.
- Configure the project deployment artifact.
- Set the application context path.
- Start the Tomcat server.

### 6. Run the Application

Open your browser and visit:

```text
http://localhost:8080/Student-Placement-Portal/login.jsp
```

## 🔐 Security Features

- Session-based authentication.
- Role-based access control.
- Server-side authorization checks.
- Prepared SQL statements.
- Database constraints.
- Duplicate application prevention.
- Session invalidation during logout.

**Note:** Additional security hardening, including secure password hashing, HTTPS, and stronger session-cookie settings, is recommended before production deployment.

## 🧪 Testing

The following functional test cases were performed:

| Test Case | Result |
|---|---|
| Student Registration | Successful |
| User Login | Successful |
| Invalid Login | Successful |
| Student Profile Management | Successful |
| Job Application | Successful |
| Duplicate Application Prevention | Successful |
| Recruiter Job Management | Successful |
| Candidate Shortlisting | Successful |
| Interview Scheduling | Successful |
| Interview Result Updates | Successful |
| Role-Based Access Control | Successful |
| Admin Statistics | Successful |

## 🚀 Future Enhancements

- Automated Email and SMS Notifications.
- Resume Upload and Parsing.
- Online Assessment Integration.
- Advanced Placement Analytics.
- Integration with Institutional Databases.
- Enhanced Security and Performance Optimization.

## 🎯 Project Objectives

- Centralize campus placement information.
- Reduce manual placement administration.
- Improve communication between students and recruiters.
- Simplify job application management.
- Provide transparent application tracking.
- Improve the overall organization of campus recruitment.

## 👨‍💻 Developer

**K Bali Reddy**

B.Tech – Computer Science and Engineering

Lakireddy Bali Reddy College of Engineering

## 📄 License

This project was developed as part of an academic Skill Oriented Course Web Application / Project.

---

⭐ If you find this project useful, consider giving this repository a star!

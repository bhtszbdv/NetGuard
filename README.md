# NetGuard Learning Platform

A web-based Learning Management System (LMS) built with **ASP.NET WebForms** and **SQL Server**, focused on cybersecurity and technology education.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | ASP.NET WebForms (.NET 4.x) |
| Language | C# |
| Database | SQL Server (LearningSystemDB) |
| Frontend | HTML5, CSS3, JavaScript (vanilla) |
| Icons | Font Awesome 6.4 |
| IDE | Visual Studio 2022 |

---

## Project Structure

```
Web Development Assignment/
├── Login.aspx                  # Login page
├── CreateAccount.aspx          # Registration
├── ForgotPassword.aspx         # Password reset
│
├── MemberDashboard.aspx        # Member home — browse & search courses
├── CoursePage.aspx             # Course viewer — Python Programming
├── CyberSecurityPage.aspx      # Course viewer — CyberSecurity Basics
│
├── AdminDashboard.aspx         # Admin home
├── CourseManagement.aspx       # Admin: add/edit courses
├── EnrollmentManagement.aspx   # Admin: manage enrollments
├── UserManagement.aspx         # Admin: manage users
│
├── Certificates.aspx           # Certificate download
├── Feedback.aspx               # Course feedback form
├── Notifications.aspx          # User notifications
├── Discussion.aspx             # Course discussion forum
├── VirtualLabs.aspx            # Virtual lab launcher
├── FAQ.aspx                    # Frequently asked questions
├── Contact.aspx                # Contact form
├── UserProfile.aspx            # Member profile page
├── CourseResources.aspx        # Course resource files
│
├── ProgressHandler.ashx        # HTTP handler — save/load lesson progress (JSON API)
├── setup_database.sql          # Full DB schema + seed data
└── Web Development Assignment.csproj
```

---

## Database Schema

**Database:** `LearningSystemDB`

| Table | Key Columns | Purpose |
|---|---|---|
| `Users` | UID, Username, Password, UserType | Members and admins |
| `Courses` | CourseID, CourseTitle, IsPublic | Course catalogue |
| `Enrollments` | EnrollmentID, UID, CourseID | Links users to courses |
| `Resources` | ResourceID, CourseID, FilePath | Course downloads |
| `VirtualLabs` | LabID, CourseID, LabLink | Lab links per course |
| `Discussions` | DiscussionID, CourseID, Username, Message | Forum posts |
| `Assessments` | AssessmentID, CourseID, QuizLink | Quiz references |
| `Notifications` | NotificationID, Username, IsRead | User alerts |
| `ContactMessages` | MessageID, Name, Email, Message | Contact form submissions |
| `FAQs` | FAQID, Question, Answer, Category | Help content |

**Connection string key:** `DBConnection` (configured in `Web.config`)

---

## Setup

### 1. Database

Run `setup_database.sql` in SQL Server Management Studio (SSMS):

```sql
-- Creates LearningSystemDB, all tables, and seeds:
-- 11 users (10 members + 1 admin)
-- 15 courses
-- Enrollments, FAQs, sample discussions
```

### 2. Connection String

In `Web.config`, set the connection string to point at your SQL Server instance:

```xml
<connectionStrings>
  <add name="DBConnection"
       connectionString="Data Source=YOUR_SERVER;Initial Catalog=LearningSystemDB;Integrated Security=True"
       providerName="System.Data.SqlClient" />
</connectionStrings>
```

### 3. Build

Open `Web Development Assignment.sln` in Visual Studio 2022 and press **F5**, or build from the command line:

```bash
MSBuild.exe "Web Development Assignment.csproj" -t:Rebuild -p:Configuration=Debug
```

---

## User Roles

| Role | Access |
|---|---|
| **Guest** | Browse public courses only, no progress tracking |
| **Member** | Enroll in courses, track progress, take quizzes, earn certificates |
| **Admin** | Full access — manage users, courses, enrollments |

### Seed Credentials

| Username | Password | Role |
|---|---|---|
| `admin` | `admin123` | Admin |
| `alex` | `alex123` | Member |
| `lina` | `lina123` | Member |
| `omar` | `omar123` | Member |

---

## Course Pages

Two courses have dedicated interactive viewers with full lesson tracking:

### Introduction to Python Programming (`CoursePage.aspx`)
- 4 lessons: Introduction, Variables & Data Types, Control Flow, Functions & Modules
- Virtual lab: 6 coding exercises with live answer checking
- Quiz: 8 questions, 3 attempts, 80% pass threshold
- Certificate unlocks on quiz pass + all lessons complete
- Progress saved to DB via `ProgressHandler.ashx`

### CyberSecurity Basics (`CyberSecurityPage.aspx`)
- 3 lessons: Foundations & Threats, Authentication & Encryption, Best Practices
- Security lab: 6 text-answer exercises
- Quiz: 8 questions, 3 attempts, 80% pass threshold
- Certificate unlocks on quiz pass + all lessons complete
- Embedded video: Crash Course CyberSecurity

### Progress API (`ProgressHandler.ashx`)

| Action | Method | Payload |
|---|---|---|
| `load` | GET | `?action=load&courseID=X` |
| `saveLesson` | POST | `{ courseID, lessonKey, status }` |
| `saveQuiz` | POST | `{ courseID, score, passed, answers }` |
| `resetProgress` | POST | `{ courseID }` |

---

## Routing Logic

`MemberDashboard.aspx.cs` → `OpenCourse()` routes by course title:

```csharp
if (courseTitle.Equals("CyberSecurity Basics", StringComparison.OrdinalIgnoreCase))
    Response.Redirect("CyberSecurityPage.aspx?CourseID=" + courseID);
else
    Response.Redirect("CoursePage.aspx?CourseID=" + courseID);
```

---

## Available Courses (Seeded)

| # | Title | Public |
|---|---|---|
| 1 | Cybersecurity Basics | Yes |
| 2 | Implementation of Secure Systems | Yes |
| 3 | Ethical Hacking | No |
| 4 | Data Structures | Yes |
| 5 | Introduction Python Programming | Yes |
| 6 | Introduction to Java Programming | Yes |
| 7 | Web Development | No |
| 8 | Introduction to Networking | No |
| 9 | Advanced Networking | No |
| 10 | Digital Forensics | No |
| 11 | Machine Learning Basics | Yes |
| 12 | Database Management Systems | Yes |
| 13 | Mobile App Development | No |
| 14 | Cloud Computing Fundamentals | Yes |
| 15 | Operating Systems | Yes |

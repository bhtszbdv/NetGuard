-- Database Setup for LearningSystemDB
CREATE DATABASE LearningSystemDB;
GO

USE LearningSystemDB;
GO

-- Create Users Table
CREATE TABLE [dbo].[Users] (
    [UID]       INT           IDENTITY (1001, 1) NOT NULL,
    [Username]  VARCHAR (50)  NOT NULL,
    [Password]  VARCHAR (100) NOT NULL,
    [UserType]  VARCHAR (20)  NOT NULL,
    [FirstName] VARCHAR (50)  NOT NULL,
    [LastName]  VARCHAR (50)  NOT NULL,
    [Email]     VARCHAR (100) NOT NULL,
    [Mobile]    VARCHAR (20)  NULL,
    PRIMARY KEY CLUSTERED ([UID] ASC),
    UNIQUE NONCLUSTERED ([Username] ASC)
);

-- Create Courses Table
CREATE TABLE [dbo].[Courses] (
    [CourseID]          INT           IDENTITY (1, 1) NOT NULL,
    [CourseTitle]       VARCHAR (100) NOT NULL,
    [CourseDescription] VARCHAR (500) NULL,
    [CourseImage]       VARCHAR (200) NULL,
    [IsPublic]          BIT           DEFAULT ((0)) NULL,
    PRIMARY KEY CLUSTERED ([CourseID] ASC)
);

-- Create Enrollments Table
CREATE TABLE [dbo].[Enrollments] (
    [EnrollmentID] INT IDENTITY (1, 1) NOT NULL,
    [UID]          INT NULL,
    [CourseID]     INT NULL,
    PRIMARY KEY CLUSTERED ([EnrollmentID] ASC),
    FOREIGN KEY ([UID]) REFERENCES [dbo].[Users] ([UID]),
    FOREIGN KEY ([CourseID]) REFERENCES [dbo].[Courses] ([CourseID])
);

-- Create Resources Table
CREATE TABLE Resources (
    ResourceID INT IDENTITY PRIMARY KEY,
    CourseID INT NOT NULL,
    Title VARCHAR(200) NOT NULL,
    FilePath VARCHAR(255) NOT NULL,
    Description VARCHAR(500),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Create VirtualLabs Table
CREATE TABLE VirtualLabs (
    LabID INT IDENTITY PRIMARY KEY,
    CourseID INT NOT NULL,
    LabTitle VARCHAR(200) NOT NULL,
    LabLink VARCHAR(255) NOT NULL,
    Description VARCHAR(500),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Create Discussions Table
CREATE TABLE Discussions (
    DiscussionID INT IDENTITY PRIMARY KEY,
    CourseID INT NOT NULL,
    Username VARCHAR(100) NOT NULL,
    Message TEXT NOT NULL,
    DatePosted DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Create Assessments Table
CREATE TABLE Assessments (
    AssessmentID INT IDENTITY PRIMARY KEY,
    CourseID INT NOT NULL,
    Title VARCHAR(200),
    Description VARCHAR(500),
    QuizLink VARCHAR(255),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Create ContactMessages Table
CREATE TABLE ContactMessages (
    MessageID INT IDENTITY PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Subject VARCHAR(200) NOT NULL,
    Message TEXT NOT NULL,
    DateSent DATETIME DEFAULT GETDATE()
);

-- Create FAQs Table
CREATE TABLE FAQs (
    FAQID INT IDENTITY PRIMARY KEY,
    Question VARCHAR(500) NOT NULL,
    Answer TEXT NOT NULL,
    Category VARCHAR(100) NOT NULL
);

-- Create Notifications Table
CREATE TABLE Notifications (
    NotificationID INT IDENTITY PRIMARY KEY,
    Username VARCHAR(100) NOT NULL,
    Message VARCHAR(500) NOT NULL,
    DateCreated DATETIME DEFAULT GETDATE(),
    IsRead BIT DEFAULT 0
);
GO

-- Insert Seed Data
-- Users
INSERT INTO Users (Username, Password, UserType, FirstName, LastName, Email, Mobile) VALUES
('alex', 'alex123', 'Member', 'Alex', 'Tan', 'alextan@gmail.com', '0129988776'),
('lina', 'lina123', 'Member', 'Lina', 'Rahman', 'linarahman@gmail.com', '0115566778'),
('omar', 'omar123', 'Member', 'Omar', 'Hassan', 'omarhassan@gmail.com', '0134455667'),
('siti', 'siti123', 'Member', 'Siti', 'Aminah', 'sitiaminah@gmail.com', '0123344556'),
('john', 'john123', 'Member', 'John', 'Lim', 'johnlim@gmail.com', '0102233445'),
('meera', 'meera123', 'Member', 'Meera', 'Kumar', 'meerakumar@gmail.com', '0124455667'),
('daniel', 'daniel123', 'Member', 'Daniel', 'Wong', 'danielwong@gmail.com', '0116677889'),
('farah', 'farah123', 'Member', 'Farah', 'Ibrahim', 'farahibrahim@gmail.com', '0139988776'),
('liam', 'liam123', 'Member', 'Liam', 'Ong', 'liamong@gmail.com', '0127788990'),
('hannah', 'hannah123', 'Member', 'Hannah', 'Lee', 'hannahlee@gmail.com', '0109988776'),
('admin', 'admin123', 'Admin', 'System', 'Admin', 'admin@gmail.com', '0110000000');

-- Courses
INSERT INTO Courses (CourseTitle, CourseDescription, CourseImage, IsPublic) VALUES
('Cybersecurity Basics', 'Learn cybersecurity fundamentals including threats, attacks, and defense strategies.', 'images/cybersecurity.jpg', 1),
('Implementation of Secure Systems', 'Learn to design and strengthen secure systems.', 'images/securesystems.jpg', 1),
('Ethical Hacking', 'Learn how attackers find vulnerabilities in systems.', 'images/ethicalhacking.jpg', 0),
('Data Structures', 'Understand arrays, stacks, queues, trees, and graphs.', 'images/datastructures.jpg', 1),
('Introduction Python Programming', 'Learn Python from basics to intermediate level.', 'images/intropython.jpg', 1),
('Introduction to Java Programming', 'Learn Java syntax, OOP concepts, and application development.', 'images/introjava.jpg', 1),
('Web Development', 'Learn HTML, CSS, JavaScript, and ASP.NET development.', 'images/webdev.jpg', 0),
('Introduction to Networking', 'Basics of computer networking and protocols.', 'images/intronetworking.jpg', 0),
('Advanced Networking', 'Routing, switching, and enterprise network design.', 'images/advnetworking.jpg', 0),
('Digital Forensics', 'Learn investigation techniques and forensic tools.', 'images/forensics.jpg', 0),
('Machine Learning Basics', 'Introduction to AI and ML concepts.', 'images/machinelearning.jpg', 1),
('Database Management Systems', 'Learn SQL, normalization, and relational databases.', 'images/dbms.jpg', 1),
('Mobile App Development', 'Build Android and iOS applications using modern tools.', 'images/mobileapp.jpg', 0),
('Cloud Computing Fundamentals', 'Introduction to AWS, Azure, and cloud architecture.', 'images/cloud.jpg', 1),
('Operating Systems', 'Learn process management, memory, and scheduling.', 'images/os.jpg', 1);

-- Enrollments (Referencing UIDs from 1001 due to IDENTITY 1001,1. alex=1001, lina=1002, etc.)
-- Let's run a SELECT query to map names if needed, but since alex is first, UID is 1001.
-- Docx says Alex is 1002 (if seeded with RESEED 1000, 1001 is alex, 1002 is lina. Wait: IDENTITY (1001,1) means:
-- 1st is 1001 (alex), 2nd is 1002 (lina), 3rd is 1003 (omar), etc.
-- Let's populate Enrollments according to seeded UIDs:
-- Alex (UID=1001)
INSERT INTO Enrollments (UID, CourseID) VALUES
(1001, 1), (1001, 4), (1001, 5), (1001, 7), (1001, 11),
-- Lina (UID=1002)
(1002, 2), (1002, 5), (1002, 6), (1002, 12),
-- Omar (UID=1003)
(1003, 3), (1003, 4), (1003, 8), (1003, 9),
-- Siti (UID=1004)
(1004, 1), (1004, 6), (1004, 10), (1004, 13),
-- John (UID=1005)
(1005, 2), (1005, 5), (1005, 7), (1005, 12),
-- Meera (UID=1006)
(1006, 1), (1006, 3), (1006, 11), (1006, 14),
-- Daniel (UID=1007)
(1007, 4), (1007, 6), (1007, 9), (1007, 15),
-- Farah (UID=1008)
(1008, 5), (1008, 7), (1008, 12), (1008, 13),
-- Liam (UID=1009)
(1009, 8), (1009, 9), (1009, 10), (1009, 14),
-- Hannah (UID=1010)
(1010, 1), (1010, 2), (1010, 11), (1010, 15);

-- Seed FAQs
INSERT INTO FAQs (Question, Answer, Category) VALUES
('What is NetGuard?', 'NetGuard is a secure web-based learning platform dedicated to educating students and professionals on cybersecurity fundamentals, secure systems, and safe online practices.', 'General'),
('How do I enroll in a course?', 'Navigate to the All Courses section on your dashboard, select the course you want to learn, and click on Enroll. Once enrolled, the course will appear in your My Courses list.', 'Courses'),
('What should I do if I forget my password?', 'Click on the Forgot Password link on the login page. You will need to enter your username, email, and mobile number to verify your identity and reset your password.', 'Account'),
('How can I participate in course discussions?', 'Go to the Course Page of any course you are enrolled in, and click on the Discussion tab. You will be able to read existing posts and share your questions and answers with other students.', 'Discussions'),
('What are Virtual Labs?', 'Virtual Labs are hands-on, interactive environments where you can practice cybersecurity exercises, such as identifying vulnerabilities or setting up secure firewalls, directly in your browser.', 'Labs');

-- Seed Discussions
INSERT INTO Discussions (CourseID, Username, Message, DatePosted) VALUES
(1, 'alex', 'Welcome to the Cybersecurity Basics discussion forum! Let''s use this space to ask questions about threats and defense strategies.', GETDATE()),
(1, 'lina', 'Does anyone have a good explanation of the difference between symmetric and asymmetric encryption?', GETDATE()),
(1, 'admin', 'Sure Lina! Symmetric encryption uses the same key for both encryption and decryption, whereas asymmetric encryption uses a public-private key pair.', GETDATE()),
(1, 'sam p.', 'Remember: Multi-Factor Authentication (MFA) adds an extra verification layer. Even if someone steals your password, they can''t access your account without your secondary device or biometrics!', GETDATE()),
(1, 'daniel', 'Is it secure to store user passwords in a database using MD5 hashing?', GETDATE()),
(1, 'admin', 'No, MD5 is cryptographically broken and highly vulnerable to collision attacks and brute-forcing. Always use secure, modern salted algorithms like bcrypt or PBKDF2.', GETDATE()),
(5, 'jamie r.', 'Hey! I''m struggling to understand the difference between a list and a tuple. Can anyone help?', GETDATE()),
(5, 'sam p.', 'A list is mutable (changeable after creation), a tuple is immutable (fixed). Use list for changing data: colors = ["red","blue"]. Use tuple for fixed data: coords = (10, 20).', GETDATE()),
(5, 'maya k.', 'Pro tip: use the Python REPL (type python in terminal) to test snippets instantly without creating a file. It''s like a calculator for Python!', GETDATE()),
(5, 'chris l.', 'F-strings are incredibly powerful. You can put expressions inside: print(f"2+2={2+2}") outputs 2+2=4. Much cleaner than old string formatting!', GETDATE()),
(5, 'lina', 'Why do I get an IndentationError in Python? The lines look completely aligned in my editor.', GETDATE()),
(5, 'admin', 'IndentationErrors are usually caused by mixing tabs and spaces in your code. Python treats tabs and spaces differently. Configure your code editor to insert spaces when you press Tab!', GETDATE());
GO

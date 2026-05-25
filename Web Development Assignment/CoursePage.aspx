<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CoursePage.aspx.cs" Inherits="Web_Development_Assignment.CoursePage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Course Page</title>

    <style>
        body{
            font-family: Arial, sans-serif;
            margin: 0;
            background: #f5f7fa;
        }

        .header{
            background: #0099ff;
            color: white;
            padding: 15px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .header-left{
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .header-title{
            font-size: 18px;
            font-weight: bold;
        }

        .back-button{
            background: white;
            color: #0099ff;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }

        .container{
            padding: 30px;
        }

        .module-card{
            background: white;
            width: 90%;
            max-width: 800px;
            margin: 15px auto;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.12);
            cursor: pointer;
            transition: 0.2s;
        }

        .module-card:hover{
            transform: scale(1.02);
        }

        .module-title{
            font-size: 18px;
            font-weight: bold;
            color: #0099ff;
            margin-bottom: 8px;
        }

        .module-desc{
            color: #555;
            font-size: 14px;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<form id="form1" runat="server">
    <div class="header">
        <div class="header-left">
            <asp:Button ID="btnback" runat="server" Text="Back" CssClass="back-button" OnClick="btnback_Click" />
            <asp:Label ID="lblCourseTitle" runat="server" CssClass="header-title"></asp:Label>
        </div>
        <div>
            Course Modules
        </div>
    </div>
    <div class="container">
        <div class="module-card"
            onclick="location.href='CourseResources.aspx?CourseID=<%= Request.QueryString["CourseID"] %>'">
            <div class="module-title"><i class="fa-solid fa-folder-open"></i> Resources</div>
            <div class="module-desc">Lecture notes, slides, and learning materials</div>
        </div>
        <div class="module-card"
            onclick="location.href='Discussion.aspx?CourseID=<%= Request.QueryString["CourseID"] %>'">
            <div class="module-title"><i class="fa-solid fa-comments"></i> Discussion</div>
            <div class="module-desc">Interact with students and instructors</div>
        </div>
        <div class="module-card"
            onclick="location.href='SelfAssessments.aspx?CourseID=<%= Request.QueryString["CourseID"] %>'">
            <div class="module-title"><i class="fa-solid fa-clipboard-check"></i> Self Assessments</div>
            <div class="module-desc">Quizzes and practice tests</div>
        </div>
        <div class="module-card"
            onclick="location.href='VirtualLabs.aspx?CourseID=<%= Request.QueryString["CourseID"] %>'">
            <div class="module-title"><i class="fa-solid fa-laptop-code"></i> Virtual Labs</div>
            <div class="module-desc">Hands-on interactive labs</div>
        </div>
    </div>
</form>
</body>
</html>
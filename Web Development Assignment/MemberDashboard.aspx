<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MemberDashboard.aspx.cs" Inherits="Web_Development_Assignment.WebForm2" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Member Dashboard - NetGuard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        :root {
            --primary: #0099ff;
            --primary-dark: #007acc;
            --sidebar-bg: #111827;
            --bg-color: #f3f4f6;
            --card-bg: #ffffff;
            --text-main: #1f2937;
            --text-muted: #6b7280;
        }

        body {
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            background: var(--bg-color);
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Styling */
        .sidebar {
            width: 260px;
            background: var(--sidebar-bg);
            color: white;
            display: flex;
            flex-direction: column;
            box-shadow: 4px 0 15px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            height: 100vh;
            z-index: 100;
        }

        .sidebar-header {
            padding: 25px 20px;
            display: flex;
            align-items: center;
            gap: 15px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .sidebar-header img {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--primary);
        }

        .sidebar-header h2 {
            margin: 0;
            font-size: 18px;
            font-weight: 700;
            letter-spacing: 0.5px;
            color: #fff;
        }

        .sidebar-menu {
            padding: 20px 0;
            flex-grow: 1;
            overflow-y: auto;
        }

        .menu-label {
            padding: 0 25px;
            font-size: 12px;
            text-transform: uppercase;
            color: #9ca3af;
            font-weight: 600;
            margin-bottom: 10px;
            letter-spacing: 1px;
            margin-top: 15px;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            padding: 12px 25px;
            color: #d1d5db;
            text-decoration: none;
            font-weight: 500;
            font-size: 15px;
            transition: all 0.2s;
            border-left: 4px solid transparent;
        }

        .sidebar a i {
            width: 24px;
            font-size: 16px;
            margin-right: 12px;
            color: #9ca3af;
            transition: color 0.2s;
        }

        .sidebar a:hover {
            background: rgba(255,255,255,0.05);
            color: white;
            border-left-color: var(--primary);
        }

        .sidebar a:hover i {
            color: var(--primary);
        }
        
        .sidebar-footer {
            padding: 15px 0;
            border-top: 1px solid rgba(255,255,255,0.1);
        }

        /* Main Content Area */
        .main-content {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            min-width: 0;
        }

        .top-navbar {
            height: 70px;
            background: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            position: sticky;
            top: 0;
            z-index: 50;
        }

        .top-navbar .page-title {
            font-size: 20px;
            font-weight: 700;
            color: var(--text-main);
            margin: 0;
        }

        .search-wrapper {
            position: relative;
            width: 350px;
        }

        .search-wrapper i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
        }

        .search-wrapper input {
            width: 100%;
            padding: 10px 15px 10px 45px;
            border-radius: 20px;
            border: 1px solid #e5e7eb;
            background: #f9fafb;
            outline: none;
            font-size: 14px;
            transition: all 0.2s;
            box-sizing: border-box;
        }

        .search-wrapper input:focus {
            background: white;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(0,153,255,0.1);
        }

        .dashboard-container {
            padding: 30px;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .section-title {
            font-size: 22px;
            font-weight: 700;
            color: var(--text-main);
            margin: 0;
            position: relative;
            padding-left: 15px;
        }

        .section-title::before {
            content: '';
            position: absolute;
            left: 0;
            top: 5px;
            bottom: 5px;
            width: 4px;
            background: var(--primary);
            border-radius: 2px;
        }

        /* Course Grids */
        .course-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .course-card {
            background: var(--card-bg);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            border: 1px solid rgba(0,0,0,0.05);
            height: 100%;
        }

        .course-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }

        .course-image-wrapper {
            position: relative;
            width: 100%;
            height: 160px;
            overflow: hidden;
        }

        .course-card img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .course-card:hover img {
            transform: scale(1.05);
        }

        .course-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(to top, rgba(0,0,0,0.7) 0%, rgba(0,0,0,0) 100%);
            opacity: 0;
            transition: opacity 0.3s;
            display: flex;
            align-items: flex-end;
            padding: 15px;
        }

        .course-card:hover .course-overlay {
            opacity: 1;
        }

        .play-btn {
            background: var(--primary);
            color: white;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.3);
            margin-left: auto;
        }

        .course-content {
            padding: 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .course-title {
            font-size: 16px;
            font-weight: 700;
            color: var(--text-main);
            margin: 0 0 10px 0;
            line-height: 1.4;
        }
        
        .course-link {
            text-decoration: none;
            display: block;
            height: 100%;
        }

        /* Horizontal scroll for My Courses if needed, but Grid is cleaner */
        
        /* Empty State */
        .empty-state {
            background: white;
            border-radius: 16px;
            padding: 40px;
            text-align: center;
            color: var(--text-muted);
            border: 2px dashed #e5e7eb;
            grid-column: 1 / -1;
        }
        
        .empty-state i {
            font-size: 40px;
            color: #d1d5db;
            margin-bottom: 15px;
        }

        @media (max-width: 900px) {
            body { flex-direction: column; }
            .sidebar { width: 100%; height: auto; position: relative; z-index: 10; }
            .sidebar-header { justify-content: center; }
            .sidebar-menu { display: flex; flex-wrap: wrap; padding: 10px; justify-content: center; }
            .menu-label { display: none; }
            .sidebar a { padding: 10px 15px; border-left: none; }
            .sidebar-footer { display: flex; justify-content: center; }
            .top-navbar { flex-direction: column; height: auto; padding: 15px; gap: 15px; }
            .search-wrapper { width: 100%; }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server" style="display: contents;">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        
        <!-- Sidebar Navigation -->
        <div class="sidebar">
            <div class="sidebar-header">
                <img src="images/netguard_logo.png" alt="NetGuard Logo" />
                <h2>NetGuard Learning</h2>
            </div>
            
            <div class="sidebar-menu">
                <div class="menu-label">Main Menu</div>
                <asp:LinkButton ID="btnprofile" runat="server" OnClick="btnprofile_Click" CausesValidation="false">
                    <i class="fa-solid fa-user-circle"></i> <span>My Profile</span>
                </asp:LinkButton>
                
                <div class="menu-label">Learning Tools</div>
                <asp:LinkButton ID="btncertifates" runat="server" OnClick="btncertifates_Click" CausesValidation="false">
                    <i class="fa-solid fa-award"></i> <span>My Certificates</span>
                </asp:LinkButton>

                <asp:LinkButton ID="btnNotifications" runat="server" OnClick="btnNotifications_Click" CausesValidation="false">
                    <i class="fa-solid fa-bell"></i> <span>Notifications</span>
                </asp:LinkButton>
                
                <div class="menu-label">Support</div>
                <asp:LinkButton ID="btnFAQ" runat="server" OnClick="btnFAQ_Click1" CausesValidation="false">
                    <i class="fa-solid fa-circle-question"></i> <span>Help & FAQ</span>
                </asp:LinkButton>
                
                <asp:LinkButton ID="btncontactus" runat="server" OnClick="btncontactus_Click" CausesValidation="false">
                    <i class="fa-solid fa-envelope"></i> <span>Contact Support</span>
                </asp:LinkButton>

                <asp:LinkButton ID="btnfeedback" runat="server" OnClick="btnfeedback_Click1" CausesValidation="false">
                    <i class="fa-solid fa-comment-dots"></i> <span>Give Feedback</span>
                </asp:LinkButton>
            </div>
            
            <div class="sidebar-footer">
                <asp:LinkButton ID="btnlogout" runat="server" OnClick="btnlogout_Click" CausesValidation="false">
                    <i class="fa-solid fa-sign-out-alt"></i> <span>Secure Logout</span>
                </asp:LinkButton>
            </div>
        </div>

        <!-- Main Workspace -->
        <div class="main-content">
            <div class="top-navbar">
                <h1 class="page-title">Welcome to your Dashboard</h1>
                
                <div class="search-wrapper">
                    <i class="fa-solid fa-search"></i>
                    <asp:TextBox ID="txtsearch" runat="server" AutoPostBack="True"
                        OnTextChanged="txtsearch_TextChanged"
                        placeholder="Search for courses...">
                    </asp:TextBox>
                </div>
            </div>

            <div class="dashboard-container">
                
                <!-- My Courses Section -->
                <asp:Panel ID="pnlMyCourses" runat="server">
                    <div class="section-header">
                        <h2 class="section-title">Continue Learning</h2>
                    </div>
                    
                    <div class="course-grid">
                        <asp:Repeater ID="rptmycourses" runat="server" OnItemCommand="rptmycourses_ItemCommand">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" CommandArgument='<%# Eval("CourseID") %>' OnCommand="OpenCourse" CssClass="course-link">
                                    <div class="course-card">
                                        <div class="course-image-wrapper">
                                            <img src='<%# Eval("CourseImage") %>' alt="Course Image" />
                                            <div class="course-overlay">
                                                <div class="play-btn"><i class="fa-solid fa-play"></i></div>
                                            </div>
                                        </div>
                                        <div class="course-content">
                                            <h3 class="course-title"><%# Eval("CourseTitle") %></h3>
                                        </div>
                                    </div>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:PlaceHolder ID="phEmptyMyCourses" runat="server" Visible='<%# rptmycourses.Items.Count == 0 %>'>
                                    <div class="empty-state">
                                        <i class="fa-solid fa-book-open-reader"></i>
                                        <h3>No Enrolled Courses</h3>
                                        <p>You haven't enrolled in any courses yet. Explore the available courses below to get started!</p>
                                    </div>
                                </asp:PlaceHolder>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </asp:Panel>

                <!-- All Courses Section -->
                <div class="section-header">
                    <h2 class="section-title">Explore Available Courses</h2>
                </div>
                
                <div class="course-grid">
                    <asp:Repeater ID="rptallcourses" runat="server">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" CommandArgument='<%# Eval("CourseID") %>' OnCommand="OpenCourse" CssClass="course-link">
                                <div class="course-card">
                                    <div class="course-image-wrapper">
                                        <img src='<%# Eval("CourseImage") %>' alt="Course Image" />
                                        <div class="course-overlay">
                                            <div class="play-btn"><i class="fa-solid fa-arrow-right"></i></div>
                                        </div>
                                    </div>
                                    <div class="course-content">
                                        <h3 class="course-title"><%# Eval("CourseTitle") %></h3>
                                    </div>
                                </div>
                            </asp:LinkButton>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:PlaceHolder ID="phEmptyAllCourses" runat="server" Visible='<%# rptallcourses.Items.Count == 0 %>'>
                                <div class="empty-state">
                                    <i class="fa-solid fa-search"></i>
                                    <h3>No Courses Found</h3>
                                    <p>We couldn't find any courses matching your search criteria.</p>
                                </div>
                            </asp:PlaceHolder>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
                
            </div>
        </div>
    </form>
</body>
</html>
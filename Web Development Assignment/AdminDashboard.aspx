<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="Web_Development_Assignment.AdminDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard - NetGuard</title>
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
        }

        .menu-label {
            padding: 0 25px;
            font-size: 12px;
            text-transform: uppercase;
            color: #9ca3af;
            font-weight: 600;
            margin-bottom: 10px;
            letter-spacing: 1px;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            padding: 15px 25px;
            color: #d1d5db;
            text-decoration: none;
            font-weight: 500;
            font-size: 15px;
            transition: all 0.2s;
            border-left: 4px solid transparent;
        }

        .sidebar a i {
            width: 24px;
            font-size: 18px;
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

        /* Main Content Area */
        .main-content {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .top-navbar {
            height: 70px;
            background: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .top-navbar .page-title {
            font-size: 20px;
            font-weight: 700;
            color: var(--text-main);
            margin: 0;
        }

        .top-navbar .admin-badge {
            background: #e0f2fe;
            color: #0369a1;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .dashboard-container {
            padding: 30px;
            max-width: 1200px;
        }

        /* Premium Admin Cards */
        .card-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 25px;
            margin-top: 10px;
        }

        .admin-card {
            background: var(--card-bg);
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.04);
            border: 1px solid rgba(0,0,0,0.05);
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
        }

        .admin-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--primary);
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.3s ease;
        }

        .admin-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.08);
        }

        .admin-card:hover::before {
            transform: scaleX(1);
        }

        .card-icon-wrapper {
            width: 60px;
            height: 60px;
            border-radius: 14px;
            background: #f0f9ff;
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 26px;
            margin-bottom: 20px;
        }

        .card-title {
            font-size: 20px;
            font-weight: 700;
            color: var(--text-main);
            margin-bottom: 10px;
        }

        .card-description {
            font-size: 14px;
            color: var(--text-muted);
            line-height: 1.5;
            margin-bottom: 25px;
            flex-grow: 1;
        }

        .card-button {
            width: 100%;
            padding: 12px;
            background: transparent;
            color: var(--primary);
            border: 2px solid var(--primary);
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.2s;
        }

        .card-button:hover {
            background: var(--primary);
            color: white;
        }

        /* Color variations for cards */
        .card-users .card-icon-wrapper { background: #f0fdf4; color: #16a34a; }
        .card-users::before { background: #16a34a; }
        .card-users .card-button { border-color: #16a34a; color: #16a34a; }
        .card-users .card-button:hover { background: #16a34a; color: white; }

        .card-enroll .card-icon-wrapper { background: #fef2f2; color: #dc2626; }
        .card-enroll::before { background: #dc2626; }
        .card-enroll .card-button { border-color: #dc2626; color: #dc2626; }
        .card-enroll .card-button:hover { background: #dc2626; color: white; }

        @media (max-width: 900px) {
            body { flex-direction: column; }
            .sidebar { width: 100%; flex-direction: row; align-items: center; justify-content: space-between; padding: 10px 20px; box-sizing: border-box; }
            .sidebar-header { border-bottom: none; padding: 0; }
            .sidebar-menu { display: flex; padding: 0; gap: 10px; }
            .menu-label { display: none; }
            .sidebar a { padding: 10px; border-left: none; border-bottom: 3px solid transparent; }
            .sidebar a span { display: none; }
            .sidebar a i { margin-right: 0; font-size: 20px; }
            .sidebar a:hover { border-left-color: transparent; border-bottom-color: var(--primary); background: transparent; }
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
                <h2>NetGuard Admin</h2>
            </div>
            
            <div class="sidebar-menu">
                <div class="menu-label">System Control</div>
                <asp:LinkButton ID="btnmyprofile" runat="server" OnClick="btnmyprofile_Click" CausesValidation="false">
                    <i class="fa-solid fa-user-circle"></i> <span>My Profile</span>
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnlogout" runat="server" OnClick="btnlogout_Click" CausesValidation="false">
                    <i class="fa-solid fa-sign-out-alt"></i> <span>Secure Logout</span>
                </asp:LinkButton>
            </div>
        </div>

        <!-- Main Workspace -->
        <div class="main-content">
            <div class="top-navbar">
                <h1 class="page-title">Command Center</h1>
                <div class="admin-badge">
                    <i class="fa-solid fa-shield-halved"></i> Administrator Access
                </div>
            </div>

            <div class="dashboard-container">
                <div class="card-grid">
                    
                    <!-- User Management Card -->
                    <div class="admin-card card-users">
                        <div class="card-icon-wrapper">
                            <i class="fa-solid fa-users-cog"></i>
                        </div>
                        <div class="card-title">User Management</div>
                        <div class="card-description">
                            Control platform access. Add, modify, or disable member and administrator accounts. Review user activity.
                        </div>
                        <asp:Button 
                            ID="btnUserManagement"
                            runat="server"
                            Text="Manage Users"
                            CssClass="card-button"
                            OnClick="btnUserManagement_Click" />
                    </div>
                    
                    <!-- Course Management Card -->
                    <div class="admin-card">
                        <div class="card-icon-wrapper">
                            <i class="fa-solid fa-book-open"></i>
                        </div>
                        <div class="card-title">Course Management</div>
                        <div class="card-description">
                            Design the curriculum. Create new cybersecurity modules, update course materials, and manage visibility.
                        </div>
                        <asp:Button 
                            ID="btnCourseManagement"
                            runat="server"
                            Text="Manage Courses"
                            CssClass="card-button"
                            OnClick="btnCourseManagement_Click" />
                    </div>
                    
                    <!-- Enrollment Management Card -->
                    <div class="admin-card card-enroll">
                        <div class="card-icon-wrapper">
                            <i class="fa-solid fa-graduation-cap"></i>
                        </div>
                        <div class="card-title">Enrollment Management</div>
                        <div class="card-description">
                            Oversee student progression. Handle course registrations, manage student enrollments, and track participation.
                        </div>
                        <asp:Button 
                            ID="btnEnrollmentManagement"
                            runat="server"
                            Text="Manage Enrollments"
                            CssClass="card-button"
                            OnClick="btnEnrollmentManagement_Click" />
                    </div>

                </div>
            </div>
        </div>
    </form>
</body>
</html>
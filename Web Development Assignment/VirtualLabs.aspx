<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VirtualLabs.aspx.cs" Inherits="Web_Development_Assignment.VirtualLabs" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Virtual Labs - NetGuard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            background: #f5f7fa;
            color: #333;
        }

        .header {
            background: #0099ff;
            color: white;
            padding: 15px 25px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 10px rgba(0,153,255,0.3);
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .header-title {
            font-size: 18px;
            font-weight: 700;
        }

        .back-button {
            background: white;
            color: #0099ff;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 700;
            font-size: 14px;
            transition: background 0.2s;
        }

        .back-button:hover {
            background: #e6f3ff;
        }

        .header-brand {
            font-size: 14px;
            opacity: 0.9;
            font-weight: 500;
        }

        .container {
            max-width: 900px;
            margin: 35px auto;
            padding: 0 20px;
        }

        .page-intro {
            background: white;
            border-radius: 12px;
            padding: 20px 25px;
            margin-bottom: 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            border-left: 5px solid #0099ff;
        }

        .page-intro h2 {
            margin: 0 0 6px 0;
            color: #0099ff;
            font-size: 20px;
        }

        .page-intro p {
            margin: 0;
            color: #666;
            font-size: 14px;
        }

        .lab-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .lab-card {
            background: white;
            border-radius: 10px;
            padding: 20px 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            border-left: 5px solid #0099ff;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .lab-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }

        .lab-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #111827, #1f2937);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #0099ff;
            font-size: 20px;
            flex-shrink: 0;
        }

        .lab-info {
            flex-grow: 1;
        }

        .lab-title {
            font-size: 16px;
            font-weight: 700;
            color: #1f2937;
            margin: 0 0 5px 0;
        }

        .lab-desc {
            font-size: 14px;
            color: #6b7280;
            margin: 0;
        }

        .btn-launch {
            background: linear-gradient(135deg, #0099ff, #007acc);
            color: white;
            border: none;
            padding: 10px 22px;
            border-radius: 8px;
            font-weight: 700;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: opacity 0.2s, transform 0.2s;
            white-space: nowrap;
            flex-shrink: 0;
            box-shadow: 0 4px 12px rgba(0,153,255,0.3);
        }

        .btn-launch:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }

        .empty-state {
            background: white;
            border-radius: 12px;
            padding: 60px 30px;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            border: 2px dashed #e5e7eb;
        }

        .empty-state i {
            font-size: 50px;
            color: #d1d5db;
            margin-bottom: 15px;
            display: block;
        }

        .empty-state h3 {
            color: #6b7280;
            margin: 0 0 8px 0;
        }

        .empty-state p {
            color: #9ca3af;
            margin: 0;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">
            <div class="header-left">
                <asp:Button ID="btnBack" runat="server" Text="← Back to Course" CssClass="back-button" OnClick="btnBack_Click" CausesValidation="false" />
                <span class="header-title">
                    <i class="fa-solid fa-laptop-code"></i>
                    <asp:Label ID="lblCourseTitle" runat="server" Text="Virtual Labs"></asp:Label>
                </span>
            </div>
            <span class="header-brand"><i class="fa-solid fa-shield-halved"></i> NetGuard Learning</span>
        </div>

        <div class="container">
            <div class="page-intro">
                <h2><i class="fa-solid fa-flask"></i> Hands-On Lab Environment</h2>
                <p>Welcome to the secure sandbox environment. These virtual labs provide hands-on cybersecurity experience without risking your personal machine.</p>
            </div>

            <div class="lab-list">
                <asp:Repeater ID="rptLabs" runat="server">
                    <ItemTemplate>
                        <div class="lab-card">
                            <div class="lab-icon">
                                <i class="fa-solid fa-terminal"></i>
                            </div>
                            <div class="lab-info">
                                <p class="lab-title"><%# Eval("LabTitle") %></p>
                                <p class="lab-desc"><%# Eval("Description") %></p>
                            </div>
                            <a href='<%# Eval("LabLink") %>' target="_blank" class="btn-launch">
                                <i class="fa-solid fa-play"></i> Launch Lab
                            </a>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <asp:Panel ID="pnlNoLabs" runat="server" Visible="false">
                <div class="empty-state">
                    <i class="fa-solid fa-laptop-code"></i>
                    <h3>No Labs Available</h3>
                    <p>No virtual labs are currently available for this module.</p>
                </div>
            </asp:Panel>
        </div>
    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Feedback.aspx.cs" Inherits="Web_Development_Assignment.Feedback" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Feedback - NetGuard</title>
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

        .page-wrapper {
            display: flex;
            justify-content: center;
            padding: 40px 20px;
            min-height: calc(100vh - 60px);
        }

        .feedback-card {
            background: white;
            border-radius: 16px;
            padding: 35px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.08);
            width: 100%;
            max-width: 580px;
            border: 1px solid rgba(0,0,0,0.05);
            height: fit-content;
        }

        .card-header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f3f4f6;
        }

        .card-header .icon-circle {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #0099ff, #007acc);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px auto;
            font-size: 24px;
            color: white;
        }

        .card-header h2 {
            margin: 0 0 6px 0;
            color: #1f2937;
            font-size: 22px;
        }

        .card-header p {
            margin: 0;
            color: #6b7280;
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 22px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            font-size: 13px;
            margin-bottom: 8px;
            color: #374151;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 12px 15px;
            border: 1.5px solid #e5e7eb;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 15px;
            font-family: inherit;
            background: #f9fafb;
            transition: all 0.2s;
            outline: none;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            border-color: #0099ff;
            background: white;
            box-shadow: 0 0 0 3px rgba(0,153,255,0.1);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 110px;
        }

        .star-rating {
            display: flex;
            gap: 5px;
            font-size: 24px;
            color: #f59e0b;
            margin-bottom: 8px;
        }

        .rating-select-wrapper {
            position: relative;
        }

        .rating-select-wrapper select {
            appearance: none;
            padding-right: 40px;
        }

        .rating-select-wrapper::after {
            content: '\f107';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
            pointer-events: none;
        }

        .btn-row {
            display: flex;
            gap: 12px;
            margin-top: 10px;
        }

        .btn {
            flex: 1;
            padding: 13px;
            border: none;
            border-radius: 8px;
            font-weight: 700;
            font-size: 15px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-primary {
            background: linear-gradient(135deg, #0099ff, #007acc);
            color: white;
            box-shadow: 0 4px 12px rgba(0,153,255,0.3);
        }

        .btn-primary:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }

        .btn-secondary {
            background: #f3f4f6;
            color: #6b7280;
            border: 1.5px solid #e5e7eb;
        }

        .btn-secondary:hover {
            background: #e5e7eb;
        }

        .message {
            display: block;
            text-align: center;
            margin-top: 18px;
            font-size: 14px;
            font-weight: 600;
            padding: 12px;
            border-radius: 8px;
        }

        .message.success {
            color: #166534;
            background: #dcfce7;
            border: 1px solid #86efac;
        }

        .message.error {
            color: #991b1b;
            background: #fee2e2;
            border: 1px solid #fca5a5;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">
            <div class="header-left">
                <asp:Button ID="btnBack" runat="server" Text="← Back to Dashboard" CssClass="back-button" OnClick="btnBack_Click" CausesValidation="false" />
                <span class="header-title"><i class="fa-solid fa-comment-dots"></i> Course Feedback</span>
            </div>
            <span class="header-brand"><i class="fa-solid fa-shield-halved"></i> NetGuard Learning</span>
        </div>

        <div class="page-wrapper">
            <div class="feedback-card">
                <div class="card-header">
                    <div class="icon-circle">
                        <i class="fa-solid fa-star"></i>
                    </div>
                    <h2>Share Your Experience</h2>
                    <p>Your feedback helps us improve the learning experience for everyone</p>
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-book"></i> Course Name</label>
                    <asp:TextBox ID="txtCourseName" runat="server" placeholder="Which course are you reviewing?"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-star-half-stroke"></i> Rating</label>
                    <div class="rating-select-wrapper">
                        <asp:DropDownList ID="ddlRating" runat="server">
                            <asp:ListItem Text="⭐⭐⭐⭐⭐  Excellent (5/5)" Value="5"></asp:ListItem>
                            <asp:ListItem Text="⭐⭐⭐⭐  Good (4/5)" Value="4"></asp:ListItem>
                            <asp:ListItem Text="⭐⭐⭐  Average (3/5)" Value="3"></asp:ListItem>
                            <asp:ListItem Text="⭐⭐  Poor (2/5)" Value="2"></asp:ListItem>
                            <asp:ListItem Text="⭐  Terrible (1/5)" Value="1"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-pen-to-square"></i> Comments</label>
                    <asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" Rows="5" placeholder="Tell us what you liked or what could be improved..."></asp:TextBox>
                </div>

                <div class="btn-row">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit Feedback" CssClass="btn btn-primary" OnClick="btnSubmit_Click" />
                </div>

                <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>

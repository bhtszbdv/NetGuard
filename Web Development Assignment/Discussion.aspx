<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Discussion.aspx.cs" Inherits="Web_Development_Assignment.Discussion" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Course Discussion - NetGuard</title>
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
            padding: 15px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .back-button {
            background: white;
            color: #0099ff;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
            transition: background 0.2s;
        }

        .back-button:hover {
            background: #e6f3ff;
        }

        .container {
            max-width: 900px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .forum-header {
            background: white;
            padding: 20px 25px;
            border-radius: 12px;
            margin-bottom: 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            border-left: 5px solid #0099ff;
        }

        .forum-header h2 {
            margin: 0 0 5px 0;
            color: #0099ff;
        }

        .forum-header p {
            margin: 0;
            color: #666;
            font-size: 14px;
        }

        /* Message Board Styles */
        .message-board {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.06);
            display: flex;
            flex-direction: column;
            gap: 20px;
            min-height: 400px;
        }

        .empty-messages {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            flex-grow: 1;
            color: #888;
            font-style: italic;
            text-align: center;
            padding: 40px 0;
        }

        .message-card {
            display: flex;
            gap: 15px;
            padding-bottom: 20px;
            border-bottom: 1px solid #edf2f7;
        }

        .message-card:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }

        .avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: #e2e8f0;
            color: #4a5568;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 18px;
            flex-shrink: 0;
        }

        .avatar.admin {
            background: #0099ff;
            color: white;
        }

        .message-content {
            flex-grow: 1;
        }

        .message-meta {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 5px;
        }

        .user-tag {
            font-weight: bold;
            color: #2d3748;
            font-size: 15px;
        }

        .role-badge {
            background: #edf2f7;
            color: #4a5568;
            font-size: 10px;
            padding: 2px 6px;
            border-radius: 4px;
            font-weight: bold;
            text-transform: uppercase;
        }

        .role-badge.admin {
            background: #e6f3ff;
            color: #0099ff;
        }

        .post-time {
            font-size: 12px;
            color: #a0aec0;
        }

        .message-text {
            font-size: 14.5px;
            color: #4a5568;
            line-height: 1.6;
            white-space: pre-wrap;
            word-break: break-word;
        }

        /* Post Form Styles */
        .post-box {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.06);
            margin-top: 25px;
        }

        .post-box h3 {
            margin-top: 0;
            color: #2d3748;
            font-size: 16px;
            margin-bottom: 15px;
        }

        .post-textarea {
            width: 100%;
            box-sizing: border-box;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #cbd5e0;
            outline: none;
            font-size: 14.5px;
            resize: vertical;
            transition: border-color 0.2s;
            margin-bottom: 15px;
        }

        .post-textarea:focus {
            border-color: #0099ff;
        }

        .btn-post {
            background: #0099ff;
            color: white;
            border: none;
            padding: 10px 24px;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            font-size: 15px;
            transition: background 0.2s;
            float: right;
        }

        .btn-post:hover {
            background: #007acc;
        }

        .guest-warning {
            background: #fffaf0;
            border: 1px solid #feebc8;
            color: #dd6b20;
            padding: 15px;
            border-radius: 8px;
            font-weight: 500;
            text-align: center;
        }

        .btn-delete-post {
            background: none;
            border: none;
            color: #e53e3e;
            cursor: pointer;
            font-size: 12px;
            padding: 0;
            font-weight: 600;
            margin-left: auto;
        }

        .btn-delete-post:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">
            <asp:LinkButton ID="btnback" runat="server" CssClass="back-button" OnClick="btnback_Click" CausesValidation="false">Back to Module</asp:LinkButton>
            <h2>Discussion Board</h2>
            <div></div>
        </div>

        <div class="container">
            <div class="forum-header">
                <h2><asp:Label ID="lblCourseTitle" runat="server" Text="Course Discussion"></asp:Label></h2>
                <p>Welcome to the module forum! Collaborate with classmates and get answers from the course staff.</p>
            </div>

            <!-- Messages List -->
            <div class="message-board">
                <asp:Repeater ID="rptMessages" runat="server" OnItemCommand="rptMessages_ItemCommand">
                    <HeaderTemplate></HeaderTemplate>
                    
                    <ItemTemplate>
                        <div class="message-card">
                            <!-- Avatar using initial of username -->
                            <div class='<%# "avatar " + (Eval("UserType").ToString() == "Admin" ? "admin" : "") %>'>
                                <%# Eval("Username").ToString().Substring(0, 1).ToUpper() %>
                            </div>
                            <div class="message-content">
                                <div class="message-meta">
                                    <span class="user-tag"><%# Eval("Username") %></span>
                                    <span class='<%# "role-badge " + (Eval("UserType").ToString() == "Admin" ? "admin" : "") %>'>
                                        <%# Eval("UserType") %>
                                    </span>
                                    <span class="post-time"><%# Eval("DatePosted", "{0:dd MMM yyyy, hh:mm tt}") %></span>
                                    
                                    <!-- Admin delete link button -->
                                    <asp:Button ID="btnDeletePost" runat="server" Text="Delete" 
                                        CommandName="DeletePost" CommandArgument='<%# Eval("DiscussionID") %>' 
                                        CssClass="btn-delete-post" 
                                        Visible='<%# Session["UserType"] != null && Session["UserType"].ToString() == "Admin" %>'
                                        OnClientClick="return confirm('Are you sure you want to delete this post?');" 
                                        CausesValidation="false" />
                                </div>
                                <div class="message-text"><%# HttpUtility.HtmlEncode(Eval("Message")) %></div>
                            </div>
                        </div>
                    </ItemTemplate>
                    
                    <FooterTemplate>
                        <asp:PlaceHolder ID="phEmpty" runat="server" Visible='<%# rptMessages.Items.Count == 0 %>'>
                            <div class="empty-messages">
                                💬 No discussions posted yet. Be the first to start the conversation!
                            </div>
                        </asp:PlaceHolder>
                    </FooterTemplate>
                </asp:Repeater>
            </div>

            <!-- Reply Box -->
            <div class="post-box">
                <asp:Panel ID="pnlPostMessage" runat="server">
                    <h3>Post a Message</h3>
                    <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="4" 
                        CssClass="post-textarea" placeholder="Type your question or response here..."></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvMessage" runat="server" ControlToValidate="txtMessage" 
                        ErrorMessage="Message cannot be empty." ForeColor="Red" Font-Size="12px" Display="Dynamic" 
                        ValidationGroup="ForumGroup"></asp:RequiredFieldValidator>
                    
                    <asp:Button ID="btnSubmitPost" runat="server" Text="Post Message" CssClass="btn-post" 
                        OnClick="btnSubmitPost_Click" ValidationGroup="ForumGroup" />
                    <div style="clear: both;"></div>
                </asp:Panel>

                <asp:Panel ID="pnlGuestWarning" runat="server" Visible="false">
                    <div class="guest-warning">
                        🔒 You are currently viewing as a guest. Please <a href="Login.aspx" style="color: #dd6b20; font-weight: bold;">Login</a> or <a href="CreateAccount.aspx" style="color: #dd6b20; font-weight: bold;">Create Account</a> to join the discussion.
                    </div>
                </asp:Panel>
            </div>
        </div>
    </form>
</body>
</html>

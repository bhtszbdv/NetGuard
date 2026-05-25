<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Notifications.aspx.cs" Inherits="Web_Development_Assignment.Notifications" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Notifications - NetGuard</title>
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
            max-width: 700px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.06);
            border: 1px solid #e1e8ed;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #f0f4f8;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }

        .card-header h2 {
            color: #0099ff;
            margin: 0;
            font-size: 22px;
        }

        .action-link {
            color: #0099ff;
            text-decoration: none;
            font-weight: bold;
            font-size: 14px;
            margin-left: 15px;
            background: none;
            border: none;
            cursor: pointer;
            padding: 0;
        }

        .action-link:hover {
            text-decoration: underline;
        }

        .notification-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .notification-item {
            display: flex;
            gap: 15px;
            padding: 15px;
            border-radius: 8px;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            transition: all 0.2s;
            position: relative;
        }

        .notification-item.unread {
            background: #f0f8ff;
            border-color: #bee3f8;
        }

        .unread-dot {
            width: 8px;
            height: 8px;
            background: #0099ff;
            border-radius: 50%;
            position: absolute;
            top: 20px;
            left: -4px;
        }

        .bell-icon {
            font-size: 20px;
            color: #a0aec0;
            flex-shrink: 0;
            margin-top: 2px;
        }

        .notification-item.unread .bell-icon {
            color: #0099ff;
        }

        .notification-body {
            flex-grow: 1;
        }

        .notification-text {
            font-size: 14.5px;
            color: #2d3748;
            margin: 0 0 5px 0;
            line-height: 1.4;
        }

        .notification-item.unread .notification-text {
            font-weight: 600;
        }

        .notification-date {
            font-size: 11.5px;
            color: #718096;
        }

        .btn-delete-notif {
            background: none;
            border: none;
            color: #a0aec0;
            cursor: pointer;
            font-size: 16px;
            line-height: 1;
            padding: 0 5px;
            align-self: flex-start;
        }

        .btn-delete-notif:hover {
            color: #e53e3e;
        }

        .empty-state {
            text-align: center;
            color: #718096;
            font-style: italic;
            padding: 40px 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
        }

        .empty-icon {
            font-size: 40px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">
            <asp:LinkButton ID="btnback" runat="server" CssClass="back-button" OnClick="btnback_Click" CausesValidation="false">Back to Dashboard</asp:LinkButton>
            <h2>NetGuard Learning Portal</h2>
            <div></div>
        </div>

        <div class="container">
            <div class="card">
                <div class="card-header">
                    <h2>Notifications</h2>
                    <div>
                        <asp:Button ID="btnMarkRead" runat="server" Text="Mark all as read" CssClass="action-link" OnClick="btnMarkRead_Click" CausesValidation="false" />
                        <asp:Button ID="btnClearAll" runat="server" Text="Clear all" CssClass="action-link" OnClick="btnClearAll_Click" OnClientClick="return confirm('Are you sure you want to delete all notifications?');" CausesValidation="false" />
                    </div>
                </div>

                <div class="notification-list">
                    <asp:Repeater ID="rptNotifications" runat="server" OnItemCommand="rptNotifications_ItemCommand">
                        <ItemTemplate>
                            <div class='<%# "notification-item " + (Convert.ToBoolean(Eval("IsRead")) ? "" : "unread") %>'>
                                <asp:PlaceHolder ID="phUnreadDot" runat="server" Visible='<%# !Convert.ToBoolean(Eval("IsRead")) %>'>
                                    <div class="unread-dot"></div>
                                </asp:PlaceHolder>
                                
                                <div class="bell-icon">🔔</div>
                                
                                <div class="notification-body">
                                    <p class="notification-text"><%# Eval("Message") %></p>
                                    <span class="notification-date"><%# Eval("DateCreated", "{0:dd MMM yyyy, hh:mm tt}") %></span>
                                </div>

                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteNotification" 
                                    CommandArgument='<%# Eval("NotificationID") %>' CssClass="btn-delete-notif" 
                                    CausesValidation="false">×</asp:LinkButton>
                            </div>
                        </ItemTemplate>
                        
                        <FooterTemplate>
                            <asp:PlaceHolder ID="phEmpty" runat="server" Visible='<%# rptNotifications.Items.Count == 0 %>'>
                                <div class="empty-state">
                                    <div class="empty-icon">📭</div>
                                    <div>All caught up! You have no new notifications.</div>
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

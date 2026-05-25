<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VirtualLabs.aspx.cs" Inherits="Web_Development_Assignment.VirtualLabs" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Virtual Labs</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #2b2b2b;
            color: #f1f1f1;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 900px;
            margin: auto;
            background-color: #3b3b3b;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.5);
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #00ff00;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        .header h2 {
            margin: 0;
            color: #00ff00;
        }
        .btn-back {
            background-color: #555;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }
        .btn-back:hover { background-color: #777; }
        
        .lab-card {
            background-color: #1e1e1e;
            border: 1px solid #444;
            border-left: 5px solid #00ff00;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 4px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .lab-info h3 {
            margin: 0 0 5px 0;
            color: #00ff00;
        }
        .lab-info p {
            margin: 0;
            color: #ccc;
            font-size: 14px;
        }
        .btn-launch {
            background-color: #0099ff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
        }
        .btn-launch:hover {
            background-color: #007acc;
        }
        .empty-message {
            text-align: center;
            padding: 30px;
            color: #999;
            font-size: 16px;
            font-style: italic;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="header">
                <h2>
                    <asp:Label ID="lblCourseTitle" runat="server" Text="Virtual Labs Environment"></asp:Label>
                </h2>
                <asp:Button ID="btnBack" runat="server" Text="Back to Course" CssClass="btn-back" OnClick="btnBack_Click" />
            </div>

            <p style="color: #aaa; margin-bottom: 25px;">
                Welcome to the secure sandbox environment. These virtual labs provide hands-on experience without risking your personal machine.
            </p>

            <asp:Repeater ID="rptLabs" runat="server">
                <ItemTemplate>
                    <div class="lab-card">
                        <div class="lab-info">
                            <h3><%# Eval("LabTitle") %></h3>
                            <p><%# Eval("Description") %></p>
                        </div>
                        <div>
                            <!-- Link to external lab environment or simulation -->
                            <a href='<%# Eval("LabLink") %>' target="_blank" class="btn-launch">Launch Lab</a>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <asp:Panel ID="pnlNoLabs" runat="server" Visible="false" CssClass="empty-message">
                <p>No virtual labs are currently available for this module.</p>
            </asp:Panel>
        </div>
    </form>
</body>
</html>

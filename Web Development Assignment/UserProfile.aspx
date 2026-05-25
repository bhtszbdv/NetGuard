<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="Web_Development_Assignment.UserProfile" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Profile Settings</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            width: 400px;
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .form-group input:disabled {
            background-color: #e9ecef;
            color: #6c757d;
            cursor: not-allowed;
        }
        .btn-update {
            width: 100%;
            padding: 10px;
            background-color: #0099ff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }
        .btn-update:hover {
            background-color: #007acc;
        }
        .btn-back {
            width: 100%;
            padding: 10px;
            background-color: #6c757d;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }
        .btn-back:hover {
            background-color: #5a6268;
        }
        .message {
            text-align: center;
            margin-top: 15px;
            font-weight: bold;
        }
        .message.success { color: green; }
        .message.error { color: red; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>User Profile Settings</h2>
            
            <div class="form-group">
                <label>Username (Cannot be changed)</label>
                <asp:TextBox ID="txtUsername" runat="server" Enabled="false"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>First Name</label>
                <asp:TextBox ID="txtFirstName" runat="server" required="true"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Last Name</label>
                <asp:TextBox ID="txtLastName" runat="server" required="true"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Email</label>
                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" required="true"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Mobile Number</label>
                <asp:TextBox ID="txtMobile" runat="server"></asp:TextBox>
            </div>

            <asp:Button ID="btnUpdate" runat="server" Text="Save Changes" CssClass="btn-update" OnClick="btnUpdate_Click" />
            <asp:Button ID="btnBack" runat="server" Text="Back to Dashboard" CssClass="btn-back" OnClick="btnBack_Click" CausesValidation="false" />
            
            <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
        </div>
    </form>
</body>
</html>

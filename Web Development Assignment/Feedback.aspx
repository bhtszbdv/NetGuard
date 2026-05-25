<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Feedback.aspx.cs" Inherits="Web_Development_Assignment.Feedback" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Submit Feedback</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            padding: 20px;
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
            width: 500px;
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
        .form-group input, .form-group textarea, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .btn-submit {
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
        .btn-submit:hover {
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
        .btn-back:hover { background-color: #5a6268; }
        .message {
            text-align: center;
            margin-top: 15px;
            font-weight: bold;
            display: block;
        }
        .message.success { color: green; }
        .message.error { color: red; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Course Feedback</h2>
            
            <div class="form-group">
                <label>Course Name</label>
                <asp:TextBox ID="txtCourseName" runat="server" placeholder="Which course are you reviewing?"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Rating</label>
                <asp:DropDownList ID="ddlRating" runat="server">
                    <asp:ListItem Text="Excellent (5/5)" Value="5"></asp:ListItem>
                    <asp:ListItem Text="Good (4/5)" Value="4"></asp:ListItem>
                    <asp:ListItem Text="Average (3/5)" Value="3"></asp:ListItem>
                    <asp:ListItem Text="Poor (2/5)" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Terrible (1/5)" Value="1"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="form-group">
                <label>Comments</label>
                <asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" Rows="4" placeholder="Tell us what you liked or what could be improved..."></asp:TextBox>
            </div>

            <asp:Button ID="btnSubmit" runat="server" Text="Submit Feedback" CssClass="btn-submit" OnClick="btnSubmit_Click" />
            <asp:Button ID="btnBack" runat="server" Text="Back to Dashboard" CssClass="btn-back" OnClick="btnBack_Click" CausesValidation="false" />
            
            <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
        </div>
    </form>
</body>
</html>

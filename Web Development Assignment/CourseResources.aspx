<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourseResources.aspx.cs" Inherits="Web_Development_Assignment.CourseResources" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Course Resources</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 900px;
            margin: auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #0099ff;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        .header h2 {
            margin: 0;
            color: #333;
        }
        .btn-back {
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }
        .btn-back:hover { background-color: #5a6268; }
        
        .resource-card {
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            border-left: 5px solid #0099ff;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 4px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .resource-info h3 {
            margin: 0 0 5px 0;
            color: #0099ff;
        }
        .resource-info p {
            margin: 0;
            color: #555;
            font-size: 14px;
        }
        .btn-download {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
        }
        .btn-download:hover {
            background-color: #218838;
        }
        .empty-message {
            text-align: center;
            padding: 30px;
            color: #777;
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
                    <asp:Label ID="lblCourseTitle" runat="server" Text="Course Resources"></asp:Label>
                </h2>
                <asp:Button ID="btnBack" runat="server" Text="Back to Course" CssClass="btn-back" OnClick="btnBack_Click" />
            </div>

            <asp:Repeater ID="rptResources" runat="server">
                <ItemTemplate>
                    <div class="resource-card">
                        <div class="resource-info">
                            <h3><%# Eval("Title") %></h3>
                            <p><%# Eval("Description") %></p>
                        </div>
                        <div>
                            <!-- We use a target blank link to simulate viewing the file -->
                            <a href='<%# Eval("FilePath") %>' target="_blank" class="btn-download">View / Download</a>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <asp:Panel ID="pnlNoResources" runat="server" Visible="false" CssClass="empty-message">
                <p>No resources have been uploaded for this course yet.</p>
            </asp:Panel>
        </div>
    </form>
</body>
</html>

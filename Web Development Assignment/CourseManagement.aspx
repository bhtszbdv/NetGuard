<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourseManagement.aspx.cs" Inherits="Web_Development_Assignment.CourseManagement" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin - Course Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1000px;
            margin: auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        h2 {
            color: #333;
            border-bottom: 2px solid #0099ff;
            padding-bottom: 10px;
        }
        .header-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
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
        
        .add-course-section {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
        }
        .form-row {
            display: flex;
            gap: 15px;
            margin-bottom: 10px;
        }
        .form-group {
            flex: 1;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            font-size: 14px;
        }
        .form-group input, .form-group textarea, .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn-add {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }
        .btn-add:hover { background-color: #218838; }
        
        .grid-view {
            width: 100%;
            border-collapse: collapse;
        }
        .grid-view th {
            background-color: #0099ff;
            color: white;
            padding: 10px;
            text-align: left;
        }
        .grid-view td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        .grid-view tr:hover { background-color: #f1f1f1; }
        
        .message {
            font-weight: bold;
            margin-bottom: 15px;
            display: block;
        }
        .message.success { color: green; }
        .message.error { color: red; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="header-actions">
                <h2>Course Management</h2>
                <asp:Button ID="btnBack" runat="server" Text="Back to Dashboard" CssClass="btn-back" OnClick="btnBack_Click" CausesValidation="false" />
            </div>
            
            <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>

            <!-- Add New Course Section -->
            <div class="add-course-section">
                <h3>Add New Course</h3>
                <div class="form-row">
                    <div class="form-group" style="flex: 2;">
                        <label>Course Title</label>
                        <asp:TextBox ID="txtAddTitle" runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <label>Visibility</label>
                        <asp:DropDownList ID="ddlAddIsPublic" runat="server">
                            <asp:ListItem Text="Public (1)" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Private (0)" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>Description</label>
                        <asp:TextBox ID="txtAddDescription" runat="server" TextMode="MultiLine" Rows="3"></asp:TextBox>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>Image Path (e.g. images/cybersecurity.jpg)</label>
                        <asp:TextBox ID="txtAddImage" runat="server"></asp:TextBox>
                    </div>
                </div>
                <asp:Button ID="btnAddCourse" runat="server" Text="Add Course" CssClass="btn-add" OnClick="btnAddCourse_Click" />
            </div>

            <!-- GridView to display and edit courses -->
            <asp:GridView ID="gvCourses" runat="server" CssClass="grid-view" AutoGenerateColumns="False" 
                DataKeyNames="CourseID" OnRowEditing="gvCourses_RowEditing" OnRowCancelingEdit="gvCourses_RowCancelingEdit" 
                OnRowUpdating="gvCourses_RowUpdating" OnRowDeleting="gvCourses_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="CourseID" HeaderText="ID" ReadOnly="True" ItemStyle-Width="50px" />
                    <asp:BoundField DataField="CourseTitle" HeaderText="Course Title" />
                    <asp:BoundField DataField="CourseDescription" HeaderText="Description" />
                    <asp:BoundField DataField="CourseImage" HeaderText="Image Path" />
                    
                    <asp:TemplateField HeaderText="Public?">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Convert.ToBoolean(Eval("IsPublic")) ? "Yes" : "No" %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlEditIsPublic" runat="server" SelectedValue='<%# Convert.ToBoolean(Eval("IsPublic")) ? "1" : "0" %>'>
                                <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                <asp:ListItem Text="No" Value="0"></asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" ControlStyle-ForeColor="#0099ff" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>

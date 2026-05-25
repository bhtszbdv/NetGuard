<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="Web_Development_Assignment.UserManagement" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin - User Management</title>
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
        
        .add-user-section {
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
        .form-group input, .form-group select {
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
                <h2>User Management</h2>
                <asp:Button ID="btnBack" runat="server" Text="Back to Dashboard" CssClass="btn-back" OnClick="btnBack_Click" CausesValidation="false" />
            </div>
            
            <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>

            <!-- Add New User Section -->
            <div class="add-user-section">
                <h3>Add New User</h3>
                <div class="form-row">
                    <div class="form-group">
                        <label>Username</label>
                        <asp:TextBox ID="txtAddUsername" runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Password</label>
                        <asp:TextBox ID="txtAddPassword" runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Role</label>
                        <asp:DropDownList ID="ddlAddRole" runat="server">
                            <asp:ListItem Text="Member" Value="Member"></asp:ListItem>
                            <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>First Name</label>
                        <asp:TextBox ID="txtAddFirstName" runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Last Name</label>
                        <asp:TextBox ID="txtAddLastName" runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <asp:TextBox ID="txtAddEmail" runat="server" TextMode="Email"></asp:TextBox>
                    </div>
                </div>
                <asp:Button ID="btnAddUser" runat="server" Text="Add User" CssClass="btn-add" OnClick="btnAddUser_Click" />
            </div>

            <!-- GridView to display and edit users -->
            <asp:GridView ID="gvUsers" runat="server" CssClass="grid-view" AutoGenerateColumns="False" 
                DataKeyNames="UID" OnRowEditing="gvUsers_RowEditing" OnRowCancelingEdit="gvUsers_RowCancelingEdit" 
                OnRowUpdating="gvUsers_RowUpdating" OnRowDeleting="gvUsers_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="UID" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="Username" HeaderText="Username" ReadOnly="True" />
                    
                    <asp:TemplateField HeaderText="Role">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("UserType") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlEditRole" runat="server" SelectedValue='<%# Bind("UserType") %>'>
                                <asp:ListItem Text="Member" Value="Member"></asp:ListItem>
                                <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                    <asp:BoundField DataField="LastName" HeaderText="Last Name" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="Mobile" HeaderText="Mobile" />

                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" ControlStyle-ForeColor="#0099ff" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>

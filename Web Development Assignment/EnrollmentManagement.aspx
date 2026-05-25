<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EnrollmentManagement.aspx.cs" Inherits="Web_Development_Assignment.EnrollmentManagement" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Enrollment Management - NetGuard Admin</title>
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
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 30px;
        }

        @media (max-width: 900px) {
            .container {
                grid-template-columns: 1fr;
            }
        }

        .card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.06);
            border: 1px solid #e1e8ed;
        }

        h2 {
            color: #0099ff;
            margin-top: 0;
            margin-bottom: 20px;
            font-size: 20px;
            border-bottom: 2px solid #f0f4f8;
            padding-bottom: 10px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 6px;
            font-size: 14px;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #cbd5e0;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 14px;
            outline: none;
        }

        .form-control:focus {
            border-color: #0099ff;
        }

        .btn-submit {
            background: #0099ff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            font-size: 15px;
            width: 100%;
            transition: background 0.2s;
            margin-top: 10px;
        }

        .btn-submit:hover {
            background: #007acc;
        }

        /* Search and Table Styles */
        .search-box {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        .search-control {
            flex-grow: 1;
            padding: 10px;
            border: 1px solid #cbd5e0;
            border-radius: 6px;
            font-size: 14px;
            outline: none;
        }

        .btn-search {
            background: #e2e8f0;
            color: #4a5568;
            border: 1px solid #cbd5e0;
            padding: 0 20px;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
        }

        .btn-search:hover {
            background: #cbd5e0;
        }

        .enrollment-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
            margin-top: 10px;
        }

        .enrollment-table th {
            background: #f7fafc;
            color: #4a5568;
            text-align: left;
            padding: 12px 15px;
            border-bottom: 2px solid #edf2f7;
            font-weight: 600;
        }

        .enrollment-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #edf2f7;
            color: #2d3748;
        }

        .enrollment-table tr:hover {
            background: #f7fafc;
        }

        .btn-delete {
            background: #e53e3e;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 12px;
            cursor: pointer;
            font-weight: 600;
            transition: background 0.2s;
        }

        .btn-delete:hover {
            background: #c53030;
        }

        .empty-state {
            text-align: center;
            color: #718096;
            font-style: italic;
            padding: 30px 0;
        }

        .message-label {
            font-size: 13px;
            font-weight: 600;
            margin-top: 10px;
            display: block;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">
            <asp:LinkButton ID="btnback" runat="server" CssClass="back-button" OnClick="btnback_Click" CausesValidation="false">Back to Dashboard</asp:LinkButton>
            <h2>NetGuard Administrator</h2>
            <div></div>
        </div>

        <div class="container">
            <!-- Left Panel: Create Enrollment Form -->
            <div class="card">
                <h2>New Enrollment</h2>
                
                <div class="form-group">
                    <label>Select Student</label>
                    <asp:DropDownList ID="ddlStudents" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvStudent" runat="server" ControlToValidate="ddlStudents" InitialValue="" ErrorMessage="Please select a student" ForeColor="Red" Font-Size="11px" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <label>Select Course</label>
                    <asp:DropDownList ID="ddlCourses" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvCourse" runat="server" ControlToValidate="ddlCourses" InitialValue="" ErrorMessage="Please select a course" ForeColor="Red" Font-Size="11px" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>

                <asp:Button ID="btnEnroll" runat="server" Text="Enroll Student" CssClass="btn-submit" OnClick="btnEnroll_Click" />
                
                <asp:Label ID="lblMessage" runat="server" CssClass="message-label"></asp:Label>
            </div>

            <!-- Right Panel: View and Search Enrollments -->
            <div class="card">
                <h2>Active Course Enrollments</h2>

                <div class="search-box">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="search-control" placeholder="Search by student name or course title..." AutoPostBack="True" OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn-search" OnClick="btnSearch_Click" CausesValidation="false" />
                </div>

                <asp:GridView ID="gvEnrollments" runat="server" AutoGenerateColumns="False" 
                    CssClass="enrollment-table" GridLines="None" 
                    OnRowDeleting="gvEnrollments_RowDeleting" DataKeyNames="EnrollmentID">
                    <Columns>
                        <asp:BoundField DataField="EnrollmentID" HeaderText="ID" />
                        <asp:BoundField DataField="StudentName" HeaderText="Student" />
                        <asp:BoundField DataField="Username" HeaderText="Username" />
                        <asp:BoundField DataField="CourseTitle" HeaderText="Course" />
                        
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:Button ID="btnDeleteEnrollment" runat="server" CommandName="Delete" 
                                    Text="Unenroll" CssClass="btn-delete" 
                                    OnClientClick="return confirm('Are you sure you want to remove this enrollment?');" 
                                    CausesValidation="false" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

                <asp:PlaceHolder ID="phEmpty" runat="server" Visible="false">
                    <div class="empty-state">
                        No enrollment records found.
                    </div>
                </asp:PlaceHolder>
            </div>
        </div>
    </form>
</body>
</html>

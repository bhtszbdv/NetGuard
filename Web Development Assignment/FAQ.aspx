<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FAQ.aspx.cs" Inherits="Web_Development_Assignment.FAQ" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Frequently Asked Questions - NetGuard</title>
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
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
        }

        h1 {
            color: #0099ff;
            text-align: center;
            margin-bottom: 10px;
        }

        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
        }

        /* Category Filter Styles */
        .categories {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }

        .category-btn {
            background: white;
            color: #0099ff;
            border: 1px solid #0099ff;
            padding: 8px 16px;
            border-radius: 20px;
            cursor: pointer;
            font-weight: 600;
            font-size: 14px;
            text-decoration: none;
            transition: all 0.2s;
        }

        .category-btn:hover, .category-btn.active {
            background: #0099ff;
            color: white;
        }

        /* Accordion Styles */
        .faq-item {
            background: white;
            border-radius: 8px;
            margin-bottom: 15px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            overflow: hidden;
            border: 1px solid #e1e8ed;
        }

        .faq-question {
            padding: 18px 20px;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #ffffff;
            user-select: none;
            transition: background 0.2s;
        }

        .faq-question:hover {
            background: #fcfdfe;
        }

        .faq-answer {
            padding: 0 20px;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease-out, padding 0.3s ease-out;
            color: #555;
            font-size: 14px;
            line-height: 1.6;
            background: #fafbfc;
            border-top: 0 solid #eee;
        }

        .faq-item.active .faq-question {
            color: #0099ff;
        }

        .faq-item.active .faq-answer {
            padding: 15px 20px 20px 20px;
            max-height: 200px;
            border-top: 1px solid #eee;
        }

        .arrow {
            transition: transform 0.2s;
            font-size: 12px;
        }

        .faq-item.active .arrow {
            transform: rotate(180deg);
        }

        .tag {
            display: inline-block;
            background: #e6f3ff;
            color: #0099ff;
            font-size: 11px;
            padding: 3px 8px;
            border-radius: 4px;
            font-weight: bold;
            margin-left: 10px;
            vertical-align: middle;
        }

        /* Admin Section Styles */
        .admin-section {
            background: #fff;
            border-radius: 12px;
            padding: 25px;
            margin-top: 40px;
            border: 2px dashed #0099ff;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }

        .admin-section h3 {
            margin-top: 0;
            color: #0099ff;
            margin-bottom: 20px;
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
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 14px;
        }

        .form-control:focus {
            border-color: #0099ff;
            outline: none;
        }

        .btn-action {
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            border: none;
            font-size: 14px;
        }

        .btn-add {
            background: #0099ff;
            color: white;
            width: 100%;
            padding: 12px;
            font-size: 16px;
            margin-top: 10px;
        }

        .btn-add:hover {
            background: #007acc;
        }

        .btn-edit {
            background: #ffc107;
            color: #333;
            margin-left: 10px;
            padding: 4px 8px;
            font-size: 11px;
        }

        .btn-delete {
            background: #dc3545;
            color: white;
            margin-left: 5px;
            padding: 4px 8px;
            font-size: 11px;
        }

        .admin-controls {
            display: flex;
            align-items: center;
        }

        .validator {
            color: red;
            font-size: 12px;
            margin-top: 4px;
            display: block;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">
            <asp:LinkButton ID="btnback" runat="server" CssClass="back-button" OnClick="btnback_Click" CausesValidation="false">Back</asp:LinkButton>
            <h2>NetGuard Learning Portal</h2>
            <div></div>
        </div>

        <div class="container">
            <h1>Frequently Asked Questions</h1>
            <p class="subtitle">Have questions? Find answers to commonly asked questions below.</p>

            <!-- Category Filters -->
            <div class="categories">
                <asp:LinkButton ID="btnAll" runat="server" CssClass="category-btn active" OnClick="Filter_Click" CommandArgument="All" CausesValidation="false">All</asp:LinkButton>
                <asp:LinkButton ID="btnGeneral" runat="server" CssClass="category-btn" OnClick="Filter_Click" CommandArgument="General" CausesValidation="false">General</asp:LinkButton>
                <asp:LinkButton ID="btnCourses" runat="server" CssClass="category-btn" OnClick="Filter_Click" CommandArgument="Courses" CausesValidation="false">Courses</asp:LinkButton>
                <asp:LinkButton ID="btnAccount" runat="server" CssClass="category-btn" OnClick="Filter_Click" CommandArgument="Account" CausesValidation="false">Account</asp:LinkButton>
                <asp:LinkButton ID="btnDiscussions" runat="server" CssClass="category-btn" OnClick="Filter_Click" CommandArgument="Discussions" CausesValidation="false">Discussions</asp:LinkButton>
                <asp:LinkButton ID="btnLabs" runat="server" CssClass="category-btn" OnClick="Filter_Click" CommandArgument="Labs" CausesValidation="false">Labs</asp:LinkButton>
            </div>

            <!-- FAQ List -->
            <asp:Repeater ID="rptFAQs" runat="server" OnItemCommand="rptFAQs_ItemCommand">
                <ItemTemplate>
                    <div class="faq-item">
                        <div class="faq-question" onclick="toggleFaq(this)">
                            <div>
                                <%# Eval("Question") %>
                                <span class="tag"><%# Eval("Category") %></span>
                            </div>
                            <div style="display: flex; align-items: center;">
                                <asp:PlaceHolder ID="phAdmin" runat="server" Visible='<%# Session["UserType"] != null && Session["UserType"].ToString() == "Admin" %>'>
                                    <div class="admin-controls" onclick="event.stopPropagation();">
                                        <asp:Button ID="btnEditFaq" runat="server" Text="Edit" CommandName="Edit" CommandArgument='<%# Eval("FAQID") %>' CssClass="btn-action btn-edit" CausesValidation="false" />
                                        <asp:Button ID="btnDeleteFaq" runat="server" Text="Delete" CommandName="Delete" CommandArgument='<%# Eval("FAQID") %>' CssClass="btn-action btn-delete" OnClientClick="return confirm('Are you sure you want to delete this FAQ?');" CausesValidation="false" />
                                    </div>
                                </asp:PlaceHolder>
                                <span class="arrow" style="margin-left: 15px;">▼</span>
                            </div>
                        </div>
                        <div class="faq-answer">
                            <%# Eval("Answer") %>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <!-- Admin Section to Add/Edit FAQ -->
            <asp:Panel ID="pnlAdmin" runat="server" CssClass="admin-section" Visible="false">
                <h3 id="adminTitle" runat="server">Add New FAQ (Administrator Panel)</h3>
                
                <asp:HiddenField ID="hfFaqId" runat="server" />

                <div class="form-group">
                    <label>Category</label>
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
                        <asp:ListItem Value="General">General</asp:ListItem>
                        <asp:ListItem Value="Courses">Courses</asp:ListItem>
                        <asp:ListItem Value="Account">Account</asp:ListItem>
                        <asp:ListItem Value="Discussions">Discussions</asp:ListItem>
                        <asp:ListItem Value="Labs">Labs</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="form-group">
                    <label>Question</label>
                    <asp:TextBox ID="txtQuestion" runat="server" CssClass="form-control" placeholder="Enter FAQ question"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvQuestion" runat="server" ControlToValidate="txtQuestion" ErrorMessage="Question is required" CssClass="validator" ValidationGroup="AdminFAQ"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <label>Answer</label>
                    <asp:TextBox ID="txtAnswer" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Enter FAQ answer"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvAnswer" runat="server" ControlToValidate="txtAnswer" ErrorMessage="Answer is required" CssClass="validator" ValidationGroup="AdminFAQ"></asp:RequiredFieldValidator>
                </div>

                <asp:Button ID="btnSaveFAQ" runat="server" Text="Save FAQ" CssClass="btn-action btn-add" OnClick="btnSaveFAQ_Click" ValidationGroup="AdminFAQ" />
                <asp:Button ID="btnCancelFAQ" runat="server" Text="Cancel" CssClass="btn-action btn-delete" style="width:100%; margin-top:10px; padding:12px; font-size:16px;" OnClick="btnCancelFAQ_Click" Visible="false" CausesValidation="false" />
            </asp:Panel>
        </div>
    </form>

    <script>
        function toggleFaq(element) {
            const item = element.parentElement;
            item.classList.toggle('active');
        }
    </script>
</body>
</html>

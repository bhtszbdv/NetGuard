<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Resources.aspx.cs" Inherits="Web_Development_Assignment.Resources" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        <asp:Repeater ID="rptResources" runat="server">
            <ItemTemplate>
                <div class="module-card">
                    <div class="module-title"><%# Eval("Title") %></div>
                    <div class="module-desc"><%# Eval("Description") %></div>

                    <a href='<%# Eval("FilePath") %>' target="_blank">Open File</a>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        </div>
    </form>
</body>
</html>

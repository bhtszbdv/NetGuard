<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="Web_Development_Assignment.ChangePassword" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Change Password - NetGuard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px 0;
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            color: #333;
        }

        .card-wrapper {
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.4);
            padding: 50px;
            width: 450px;
            max-width: 90%;
            position: relative;
        }

        .card-wrapper h1 {
            text-align: center;
            color: #333;
            margin: 0 0 10px 0;
            font-size: 26px;
        }

        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
            font-size: 14px;
            line-height: 1.5;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            font-size: 13px;
            margin-bottom: 8px;
            color: #555;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .input-icon-wrapper {
            position: relative;
        }

        .input-icon-wrapper i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #888;
        }

        /* Styles the clickable eye icon */
        .toggle-password {
            position: absolute !important;
            left: auto !important;
            right: 15px;
            cursor: pointer;
            transition: color 0.3s;
        }

        .toggle-password:hover {
            color: #333;
        }

        /* Added 40px padding to both left and right to accommodate both icons */
        .form-group input {
            width: 100%;
            padding: 12px 40px 12px 40px; 
            border-radius: 8px;
            border: 1.5px solid #e1e5eb;
            outline: none;
            box-sizing: border-box;
            font-size: 15px;
            transition: all 0.3s;
            background: #f8f9fa;
        }

        .form-group input:focus {
            border-color: #0099ff;
            background: #fff;
            box-shadow: 0 0 0 4px rgba(0,153,255,0.1);
        }

        .form-group input:focus + i {
            color: #0099ff;
        }

        .btn {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            font-size: 15px;
            cursor: pointer;
            margin-top: 15px;
            transition: all 0.3s ease;
            box-sizing: border-box;
            display: block;
            text-align: center;
        }

        .btn-primary {
            background: linear-gradient(135deg, #0099ff, #007acc);
            color: white;
            box-shadow: 0 4px 15px rgba(0,153,255,0.3);
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #007acc, #005f99);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,153,255,0.4);
        }

        .btn-secondary {
            background: transparent;
            color: #555;
            border: 1.5px solid #ccc;
            text-decoration: none;
            margin-top: 15px;
        }

        .btn-secondary:hover {
            background: #f8f9fa;
            border-color: #888;
        }

        .validator {
            font-size: 12px;
            color: #dc3545;
            margin-top: 4px;
            display: block;
        }

        .strength-indicator {
            font-size: 12px;
            font-weight: 600;
            margin-top: 6px;
        }

        .message {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #dc3545;
            font-size: 14px;
            font-weight: 500;
        }

        .success-text {
            color: #28a745;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="card-wrapper">
            <h1>Change Password</h1>
            <p class="subtitle">Secure your account by updating your password.</p>

            <div class="form-group">
                <label>Current Password</label>
                <div class="input-icon-wrapper">
                    <i class="fa-solid fa-unlock"></i>
                    <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password" placeholder="Enter current password"></asp:TextBox>
                    <i class="fa-regular fa-eye toggle-password" onclick="toggleVisibility(this)"></i>
                </div>
                <asp:RequiredFieldValidator ID="rfvCurrentPassword" runat="server" ControlToValidate="txtCurrentPassword" ErrorMessage="Current password is required" CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <label>New Password</label>
                <div class="input-icon-wrapper">
                    <i class="fa-solid fa-lock"></i>
                    <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" placeholder="Enter new password" onkeyup="checkPasswordStrength(this.value)"></asp:TextBox>
                    <i class="fa-regular fa-eye toggle-password" onclick="toggleVisibility(this)"></i>
                </div>
                <asp:RequiredFieldValidator ID="rfvNewPassword" runat="server" ControlToValidate="txtNewPassword" ErrorMessage="New password is required" CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revNewPassword" runat="server" ControlToValidate="txtNewPassword" ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$" ErrorMessage="Must be 8+ chars, with upper, lower, & number." CssClass="validator" Display="Dynamic"></asp:RegularExpressionValidator>
                <asp:CompareValidator ID="cvNotSamePassword" runat="server" ControlToValidate="txtNewPassword" ControlToCompare="txtCurrentPassword" Operator="NotEqual" ErrorMessage="Cannot be the same as your current password" CssClass="validator" Display="Dynamic"></asp:CompareValidator>
                <div id="strengthLabel" class="strength-indicator"></div>
            </div>

            <div class="form-group">
                <label>Confirm New Password</label>
                <div class="input-icon-wrapper">
                    <i class="fa-solid fa-lock-open"></i>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Confirm new password"></asp:TextBox>
                    <i class="fa-regular fa-eye toggle-password" onclick="toggleVisibility(this)"></i>
                </div>
                <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" ErrorMessage="Please confirm your password" CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtNewPassword" ErrorMessage="Passwords do not match" CssClass="validator" Display="Dynamic"></asp:CompareValidator>
            </div>

            <asp:Button ID="btnUpdatePassword" runat="server" Text="Update Password" CssClass="btn btn-primary" OnClick="btnUpdatePassword_Click" />
            <a id="btnCancel" runat="server" class="btn btn-secondary">Cancel</a>
            
            <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
        </div>    
    </form>

    <script type="text/javascript">
        function checkPasswordStrength(password) {
            var label = document.getElementById("strengthLabel");
            if (!password) {
                label.innerHTML = "";
                return;
            }

            var strength = 0;
            if (password.length >= 8) strength++;
            if (password.match(/[a-z]/) && password.match(/[A-Z]/)) strength++;
            if (password.match(/\d/)) strength++;
            if (password.match(/[^a-zA-Z\d]/)) strength++;

            if (strength <= 1) {
                label.innerHTML = "Strength: Weak 🔴";
                label.style.color = "#dc3545";
            } else if (strength === 2 || strength === 3) {
                label.innerHTML = "Strength: Moderate 🟡";
                label.style.color = "#ffc107";
            } else {
                label.innerHTML = "Strength: Strong 🟢";
                label.style.color = "#28a745";
            }
        }

        function toggleVisibility(iconElement) {
            // Find the textbox right before the clicked icon
            var inputField = iconElement.previousElementSibling;

            // Swap the type between password and text, and change the icon
            if (inputField.type === "password") {
                inputField.type = "text";
                iconElement.classList.remove("fa-eye");
                iconElement.classList.add("fa-eye-slash");
            } else {
                inputField.type = "password";
                iconElement.classList.remove("fa-eye-slash");
                iconElement.classList.add("fa-eye");
            }
        }
    </script>
</body>
</html>
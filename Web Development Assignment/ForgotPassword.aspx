<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="Web_Development_Assignment.ForgotPassword" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forgot Password - NetGuard</title>
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
            color: #fff;
        }

        .auth-wrapper {
            display: flex;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.4);
            border: 1px solid rgba(255,255,255,0.1);
            overflow: hidden;
            width: 900px;
            max-width: 95%;
        }

        .auth-left {
            flex: 1;
            padding: 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, rgba(0, 153, 255, 0.8), rgba(0, 85, 170, 0.9));
            text-align: center;
            position: relative;
        }

        .auth-left .logo {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 25px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.5);
            border: 3px solid rgba(255,255,255,0.2);
        }

        .auth-left h2 {
            margin: 0 0 15px 0;
            font-size: 28px;
            font-weight: 700;
        }

        .auth-left p {
            margin: 0;
            font-size: 15px;
            line-height: 1.6;
            color: rgba(255,255,255,0.9);
        }

        .auth-right {
            flex: 1;
            padding: 50px;
            background: #ffffff;
            color: #333;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .auth-right h1 {
            text-align: center;
            color: #333;
            margin: 0 0 10px 0;
            font-size: 26px;
        }

        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 25px;
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

        .form-group input {
            width: 100%;
            padding: 12px 12px 12px 40px;
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
        }

        .btn-secondary:hover {
            background: #f8f9fa;
            border-color: #888;
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

        @media (max-width: 768px) {
            .auth-wrapper {
                flex-direction: column;
                width: 90%;
            }
            .auth-left {
                padding: 30px;
            }
            .auth-left .logo {
                width: 100px;
                height: 100px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="auth-wrapper">
            <!-- Left Branding Side -->
            <div class="auth-left">
                <img src="images/netguard_logo.png" alt="NetGuard Logo" class="logo" />
                <h2>Account Recovery</h2>
                <p>We've got you covered. Verify your identity to securely reset your password and get back to learning.</p>
            </div>

            <!-- Right Reset Form Side -->
            <div class="auth-right">
                <h1>Reset Password</h1>
                
                <!-- Step 1: Verification Form -->
                <asp:Panel ID="pnlVerify" runat="server">
                    <p class="subtitle">Enter your details to verify your identity.</p>
                    
                    <div class="form-group">
                        <label>Username</label>
                        <div class="input-icon-wrapper">
                            <i class="fa-solid fa-user"></i>
                            <asp:TextBox ID="txtUsername" runat="server" placeholder="Enter your username"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" ErrorMessage="Username is required" CssClass="validator" Display="Dynamic" ValidationGroup="VerifyGroup"></asp:RequiredFieldValidator>
                    </div>

                    <div class="form-group">
                        <label>Email Address</label>
                        <div class="input-icon-wrapper">
                            <i class="fa-solid fa-envelope"></i>
                            <asp:TextBox ID="txtEmail" runat="server" placeholder="Enter registered email"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required" CssClass="validator" Display="Dynamic" ValidationGroup="VerifyGroup"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" ErrorMessage="Invalid email format" CssClass="validator" Display="Dynamic" ValidationGroup="VerifyGroup"></asp:RegularExpressionValidator>
                    </div>

                    <div class="form-group">
                        <label>Mobile Number</label>
                        <div class="input-icon-wrapper">
                            <i class="fa-solid fa-phone"></i>
                            <asp:TextBox ID="txtMobile" runat="server" placeholder="Enter mobile (e.g. 01XXXXXXXX)"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ControlToValidate="txtMobile" ErrorMessage="Mobile is required" CssClass="validator" Display="Dynamic" ValidationGroup="VerifyGroup"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revMobile" runat="server" ControlToValidate="txtMobile" ValidationExpression="^01[0-9]{8,9}$" ErrorMessage="Invalid mobile format" CssClass="validator" Display="Dynamic" ValidationGroup="VerifyGroup"></asp:RegularExpressionValidator>
                    </div>

                    <asp:Button ID="btnVerify" runat="server" Text="Verify Identity" CssClass="btn btn-primary" OnClick="btnVerify_Click" ValidationGroup="VerifyGroup" />
                </asp:Panel>

                <!-- Step 2: New Password Form -->
                <asp:Panel ID="pnlReset" runat="server" Visible="false">
                    <p class="subtitle" style="color: #28a745; font-weight: 600;">Verification successful. Please enter your new password.</p>
                    
                    <div class="form-group">
                        <label>New Password</label>
                        <div class="input-icon-wrapper">
                            <i class="fa-solid fa-lock"></i>
                            <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" placeholder="Enter new password" onkeyup="checkPasswordStrength(this.value)"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvNewPassword" runat="server" ControlToValidate="txtNewPassword" ErrorMessage="Password is required" CssClass="validator" Display="Dynamic" ValidationGroup="ResetGroup"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revNewPassword" runat="server" ControlToValidate="txtNewPassword" ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$" ErrorMessage="Must be 8+ chars, with upper, lower, & number." CssClass="validator" Display="Dynamic" ValidationGroup="ResetGroup"></asp:RegularExpressionValidator>
                        <div id="strengthLabel" class="strength-indicator"></div>
                    </div>

                    <div class="form-group">
                        <label>Confirm Password</label>
                        <div class="input-icon-wrapper">
                            <i class="fa-solid fa-lock-open"></i>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Confirm new password"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" ErrorMessage="Please confirm your password" CssClass="validator" Display="Dynamic" ValidationGroup="ResetGroup"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtNewPassword" ErrorMessage="Passwords do not match" CssClass="validator" Display="Dynamic" ValidationGroup="ResetGroup"></asp:CompareValidator>
                    </div>

                    <asp:Button ID="btnReset" runat="server" Text="Reset Password" CssClass="btn btn-primary" OnClick="btnReset_Click" ValidationGroup="ResetGroup" />
                </asp:Panel>

                <!-- Step 3: Success Message -->
                <asp:Panel ID="pnlSuccess" runat="server" Visible="false">
                    <div class="message success-text" style="margin-bottom: 15px; font-size: 18px;">
                        <i class="fa-solid fa-circle-check" style="font-size: 24px; display: block; margin-bottom: 10px;"></i>
                        Password successfully reset!
                    </div>
                    <p class="subtitle">You can now proceed to log in with your new password.</p>
                </asp:Panel>

                <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
                
                <a href="Login.aspx" class="btn btn-secondary">Return to Login</a>
            </div>
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
    </script>
</body>
</html>

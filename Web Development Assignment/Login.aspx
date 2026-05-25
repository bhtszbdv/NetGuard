<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Web_Development_Assignment.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - NetGuard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            /* Premium dark glowing gradient background */
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            color: #fff;
        }

        .login-wrapper {
            display: flex;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.4);
            border: 1px solid rgba(255,255,255,0.1);
            overflow: hidden;
            width: 850px;
            max-width: 95%;
        }

        .login-left {
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

        .login-left .logo {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 25px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.5);
            border: 3px solid rgba(255,255,255,0.2);
        }

        .login-left h2 {
            margin: 0 0 15px 0;
            font-size: 28px;
            font-weight: 700;
        }

        .login-left p {
            margin: 0;
            font-size: 15px;
            line-height: 1.6;
            color: rgba(255,255,255,0.9);
        }

        .login-right {
            flex: 1;
            padding: 50px;
            background: #ffffff;
            color: #333;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-right h1 {
            text-align: center;
            color: #333;
            margin: 0 0 30px 0;
            font-size: 26px;
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
        }

        .btn-secondary:hover {
            background: #f8f9fa;
            border-color: #888;
        }

        .actions {
            display: flex;
            justify-content: space-between;
            margin-top: 25px;
            font-size: 14px;
        }

        .actions a {
            color: #0099ff;
            font-weight: 600;
            text-decoration: none;
            transition: color 0.2s;
        }

        .actions a:hover {
            color: #005f99;
            text-decoration: underline;
        }

        .message {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #dc3545;
            font-size: 14px;
            font-weight: 500;
        }

        .validator {
            font-size: 12px;
            color: #dc3545;
            margin-top: 4px;
            display: block;
        }

        @media (max-width: 768px) {
            .login-wrapper {
                flex-direction: column;
                width: 90%;
            }
            .login-left {
                padding: 30px;
            }
            .login-left .logo {
                width: 100px;
                height: 100px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-wrapper">
            <!-- Left Branding Side -->
            <div class="login-left">
                <img src="images/netguard_logo.png" alt="NetGuard Logo" class="logo" />
                <h2>NetGuard Platform</h2>
                <p>The premier cybersecurity learning environment. Secure, interactive, and advanced training at your fingertips.</p>
            </div>

            <!-- Right Login Form Side -->
            <div class="login-right">
                <h1>Welcome Back</h1>
                
                <div class="form-group">
                    <label>Username</label>
                    <div class="input-icon-wrapper">
                        <i class="fa-solid fa-user"></i>
                        <asp:TextBox ID="txtusername" runat="server" placeholder="Enter your username"></asp:TextBox>
                    </div>
                    <asp:RequiredFieldValidator 
                        ID="rfvusername" 
                        runat="server" 
                        ControlToValidate="txtusername" 
                        ErrorMessage="Username is required"
                        CssClass="validator" Display="Dynamic" />
                </div>
                
                <div class="form-group">
                    <label>Password</label>
                    <div class="input-icon-wrapper">
                        <i class="fa-solid fa-lock"></i>
                        <asp:TextBox ID="txtpassword" runat="server" TextMode="Password" placeholder="Enter your password"></asp:TextBox>
                    </div>
                    <asp:RequiredFieldValidator 
                        ID="rfvpassword" 
                        runat="server" 
                        ControlToValidate="txtpassword" 
                        ErrorMessage="Password is required"
                        CssClass="validator" Display="Dynamic" />
                </div>
                
                <asp:Button 
                    ID="btnLogin" 
                    runat="server" 
                    Text="Secure Login" 
                    CssClass="btn btn-primary"
                    OnClick="btnLogin_Click" />
                    
                <asp:Button 
                    ID="btnguestlogin" 
                    runat="server" 
                    Text="Continue as Guest" 
                    CssClass="btn btn-secondary"
                    OnClick="Button1_Click"
                    CausesValidation="false" />
                    
                <div class="actions">
                    <asp:LinkButton 
                        ID="btncreate" 
                        runat="server" 
                        OnClick="LinkButton1_Click"
                        CausesValidation="false">
                        Create Account
                    </asp:LinkButton>
                    
                    <asp:LinkButton 
                        ID="btnForgotPassword" 
                        runat="server" 
                        OnClick="btnForgotPassword_Click"
                        CausesValidation="false">
                        Forgot Password?
                    </asp:LinkButton>
                </div>
                
                <asp:Label ID="lblmessage" runat="server" CssClass="message"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>
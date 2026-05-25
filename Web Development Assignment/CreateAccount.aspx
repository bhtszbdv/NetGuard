<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateAccount.aspx.cs" Inherits="Web_Development_Assignment.CreateAccount" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Create Account - NetGuard</title>
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

        .register-wrapper {
            display: flex;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.4);
            border: 1px solid rgba(255,255,255,0.1);
            overflow: hidden;
            width: 950px;
            max-width: 95%;
        }

        .register-left {
            flex: 1;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, rgba(0, 153, 255, 0.8), rgba(0, 85, 170, 0.9));
            text-align: center;
            position: relative;
        }

        .register-left .logo {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 25px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.5);
            border: 3px solid rgba(255,255,255,0.2);
        }

        .register-left h2 {
            margin: 0 0 15px 0;
            font-size: 28px;
            font-weight: 700;
        }

        .register-left p {
            margin: 0;
            font-size: 15px;
            line-height: 1.6;
            color: rgba(255,255,255,0.9);
        }

        .register-right {
            flex: 1.2;
            padding: 40px;
            background: #ffffff;
            color: #333;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .register-right h1 {
            text-align: center;
            color: #333;
            margin: 0 0 25px 0;
            font-size: 26px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .form-group {
            margin-bottom: 15px;
            position: relative;
        }

        .form-group.full-width {
            grid-column: span 2;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            font-size: 13px;
            margin-bottom: 6px;
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
            padding: 10px 10px 10px 40px;
            border-radius: 8px;
            border: 1.5px solid #e1e5eb;
            outline: none;
            box-sizing: border-box;
            font-size: 14.5px;
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
            margin-top: 20px;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: linear-gradient(135deg, #0099ff, #007acc);
            color: white;
            box-shadow: 0 4px 15px rgba(0,153,255,0.3);
            grid-column: span 2;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #007acc, #005f99);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,153,255,0.4);
        }

        .back-link {
            text-align: center;
            margin-top: 20px;
            grid-column: span 2;
        }

        .back-link a {
            color: #0099ff;
            font-weight: 600;
            text-decoration: none;
            font-size: 14px;
        }

        .back-link a:hover {
            text-decoration: underline;
        }

        .error, .server-error {
            font-size: 12px;
            color: #dc3545;
            margin-top: 4px;
            display: block;
        }

        @media (max-width: 768px) {
            .register-wrapper {
                flex-direction: column;
            }
            .form-grid {
                grid-template-columns: 1fr;
            }
            .form-group.full-width, .btn-primary, .back-link {
                grid-column: span 1;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="register-wrapper">
            <!-- Left Branding Side -->
            <div class="register-left">
                <img src="images/netguard_logo.png" alt="NetGuard Logo" class="logo" />
                <h2>Join NetGuard</h2>
                <p>Create an account today to access thousands of hours of premium cybersecurity courses, virtual labs, and expert discussions.</p>
            </div>

            <!-- Right Registration Form Side -->
            <div class="register-right">
                <h1>Create Account</h1>
                
                <div class="form-grid">
                    <!-- Username -->
                    <div class="form-group full-width">
                        <label>Username</label>
                        <div class="input-icon-wrapper">
                            <i class="fa-solid fa-user"></i>
                            <asp:TextBox ID="txtusername" runat="server" OnTextChanged="txtusername_TextChanged" placeholder="Choose a username"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator 
                            ID="rfvusername" 
                            runat="server" 
                            ControlToValidate="txtusername"
                            ErrorMessage="Username Required"
                            CssClass="error" Display="Dynamic" />
                        <asp:Label ID="lblUsernameError" runat="server" CssClass="server-error" />
                    </div>

                    <!-- Password -->
                    <div class="form-group full-width">
                        <label>Password</label>
                        <div class="input-icon-wrapper">
                            <i class="fa-solid fa-lock"></i>
                            <asp:TextBox ID="txtpassword" runat="server" TextMode="Password" OnTextChanged="txtpassword_TextChanged" placeholder="Create a strong password"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator 
                            ID="rfvpassword" 
                            runat="server" 
                            ControlToValidate="txtpassword"
                            ErrorMessage="Password Required"
                            CssClass="error" Display="Dynamic" />
                        <asp:Label ID="lblPasswordError" runat="server" CssClass="server-error" />
                    </div>

                    <!-- First Name -->
                    <div class="form-group">
                        <label>First Name</label>
                        <div class="input-icon-wrapper">
                            <i class="fa-solid fa-id-card"></i>
                            <asp:TextBox ID="txtfirstname" runat="server" OnTextChanged="txtfirstname_TextChanged" placeholder="First Name"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator 
                            ID="rfvfirstname" 
                            runat="server" 
                            ControlToValidate="txtfirstname"
                            ErrorMessage="First Name Required"
                            CssClass="error" Display="Dynamic" />
                    </div>

                    <!-- Last Name -->
                    <div class="form-group">
                        <label>Last Name</label>
                        <div class="input-icon-wrapper">
                            <i class="fa-solid fa-id-card"></i>
                            <asp:TextBox ID="txtlastname" runat="server" OnTextChanged="txtlastname_TextChanged" placeholder="Last Name"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator 
                            ID="rfvlastname" 
                            runat="server" 
                            ControlToValidate="txtlastname"
                            ErrorMessage="Last Name Required"
                            CssClass="error" Display="Dynamic" />
                    </div>

                    <!-- Email -->
                    <div class="form-group">
                        <label>Email Address</label>
                        <div class="input-icon-wrapper">
                            <i class="fa-solid fa-envelope"></i>
                            <asp:TextBox ID="txtemail" runat="server" OnTextChanged="txtemail_TextChanged" placeholder="Email Address"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator 
                            ID="rfvemail" 
                            runat="server" 
                            ControlToValidate="txtemail"
                            ErrorMessage="Email Required"
                            CssClass="error" Display="Dynamic" />
                        <asp:Label ID="lblEmailError" runat="server" CssClass="server-error" />
                    </div>

                    <!-- Mobile -->
                    <div class="form-group">
                        <label>Mobile Number</label>
                        <div class="input-icon-wrapper">
                            <i class="fa-solid fa-phone"></i>
                            <asp:TextBox ID="txtmobile" runat="server" OnTextChanged="TextBox6_TextChanged" placeholder="Mobile Number"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator 
                            ID="rfvmobile" 
                            runat="server" 
                            ControlToValidate="txtmobile"
                            ErrorMessage="Mobile Required"
                            CssClass="error" Display="Dynamic" />
                        <asp:Label ID="lblMobileError" runat="server" CssClass="server-error" />
                    </div>

                    <!-- Submit Button -->
                    <asp:Button 
                        ID="btncreate" 
                        runat="server" 
                        Text="Register Securely"
                        CssClass="btn btn-primary"
                        OnClick="btncreate_Click" />

                    <!-- Back to Login -->
                    <div class="back-link">
                        <a href="Login.aspx">Already have an account? Sign in</a>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
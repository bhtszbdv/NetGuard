<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Web_Development_Assignment.Contact" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Contact Us - NetGuard</title>
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
            grid-template-columns: 1fr 1fr;
            gap: 40px;
        }

        @media (max-width: 768px) {
            .container {
                grid-template-columns: 1fr;
            }
        }

        .contact-card {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }

        h2 {
            color: #0099ff;
            margin-top: 0;
            margin-bottom: 20px;
            font-size: 24px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .form-control {
            width: 100%;
            padding: 10px 12px;
            border-radius: 8px;
            border: 1px solid #ccc;
            outline: none;
            font-size: 14px;
            box-sizing: border-box;
            transition: border-color 0.2s;
        }

        .form-control:focus {
            border-color: #0099ff;
            box-shadow: 0 0 5px rgba(0, 153, 255, 0.25);
        }

        .btn-submit {
            background: #0099ff;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            transition: background 0.2s;
        }

        .btn-submit:hover {
            background: #007acc;
        }

        .info-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 25px;
        }

        .info-icon {
            font-size: 24px;
            color: #0099ff;
            margin-right: 15px;
            width: 30px;
            text-align: center;
        }

        .info-text h4 {
            margin: 0 0 5px 0;
            font-size: 16px;
            color: #333;
        }

        .info-text p {
            margin: 0;
            color: #666;
            font-size: 14px;
            line-height: 1.5;
        }

        .success-message {
            background: #e6f9ec;
            color: #1e7e34;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid #c3e6cb;
            font-weight: 500;
            text-align: center;
        }

        .validator {
            color: red;
            font-size: 12px;
            margin-top: 5px;
            display: block;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">
            <asp:LinkButton ID="btnback" runat="server" CssClass="back-button" OnClick="btnback_Click" CausesValidation="false">Back to Dashboard</asp:LinkButton>
            <h2>NetGuard Learning Portal</h2>
            <div></div>
        </div>

        <div class="container">
            <!-- Contact Form -->
            <div class="contact-card">
                <h2>Send Us a Message</h2>
                
                <asp:Panel ID="pnlSuccess" runat="server" Visible="false">
                    <div class="success-message">
                        Thank you for reaching out! Your message has been sent successfully. We will get back to you shortly.
                    </div>
                </asp:Panel>

                <div class="form-group">
                    <label>Full Name</label>
                    <asp:TextBox ID="txtname" runat="server" CssClass="form-control" placeholder="Enter your full name"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvname" runat="server" ControlToValidate="txtname" ErrorMessage="Name is required" CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <label>Email Address</label>
                    <asp:TextBox ID="txtemail" runat="server" CssClass="form-control" placeholder="Enter your email address"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvemail" runat="server" ControlToValidate="txtemail" ErrorMessage="Email is required" CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revemail" runat="server" ControlToValidate="txtemail" ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" ErrorMessage="Invalid email address format" CssClass="validator" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>

                <div class="form-group">
                    <label>Subject</label>
                    <asp:TextBox ID="txtsubject" runat="server" CssClass="form-control" placeholder="What is this regarding?"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvsubject" runat="server" ControlToValidate="txtsubject" ErrorMessage="Subject is required" CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <label>Message</label>
                    <asp:TextBox ID="txtmessage" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" placeholder="Write your message here..."></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvmessage" runat="server" ControlToValidate="txtmessage" ErrorMessage="Message is required" CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>

                <asp:Button ID="btnSubmit" runat="server" Text="Send Message" CssClass="btn-submit" OnClick="btnSubmit_Click" />
            </div>

            <!-- Contact Info -->
            <div class="contact-card" style="background: linear-gradient(135deg, #ffffff, #f0f7ff);">
                <h2>Contact Information</h2>
                <p style="color: #666; font-size: 15px; line-height: 1.6; margin-bottom: 30px;">
                    Have questions about NetGuard or our courses? Reach out to us, and our team will get back to you within 24 hours.
                </p>

                <div class="info-item">
                    <div class="info-icon">📍</div>
                    <div class="info-text">
                        <h4>Our Location</h4>
                        <p>Technology Park Malaysia, Bukit Jalil, Kuala Lumpur, Malaysia</p>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon">✉️</div>
                    <div class="info-text">
                        <h4>Email Support</h4>
                        <p>support@netguard.edu.my<br />info@netguard.edu.my</p>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon">📞</div>
                    <div class="info-text">
                        <h4>Phone Number</h4>
                        <p>+60 3-8996 1000<br />Mon-Fri, 9:00 AM - 5:00 PM</p>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon">🛡️</div>
                    <div class="info-text">
                        <h4>Security Incident Report</h4>
                        <p>For urgent security concerns, contact our security team at security@netguard.edu.my</p>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>

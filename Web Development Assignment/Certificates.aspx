<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Certificates.aspx.cs" Inherits="Web_Development_Assignment.Certificates" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Course Certificate</title>
    <style>
        body {
            font-family: 'Times New Roman', serif;
            background-color: #ddd;
            margin: 0;
            padding: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .cert-container {
            background-color: white;
            border: 15px solid #0099ff;
            padding: 50px;
            width: 800px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            position: relative;
        }
        .cert-inner {
            border: 2px solid #ccc;
            padding: 40px;
        }
        .cert-title {
            font-size: 50px;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        .cert-subtitle {
            font-size: 20px;
            color: #666;
            margin-bottom: 40px;
        }
        .cert-name {
            font-size: 40px;
            font-weight: bold;
            color: #0099ff;
            border-bottom: 2px solid #ccc;
            display: inline-block;
            padding-bottom: 10px;
            margin-bottom: 30px;
            font-style: italic;
        }
        .cert-course {
            font-size: 28px;
            font-weight: bold;
            color: #444;
            margin-top: 20px;
            margin-bottom: 40px;
        }
        .cert-date {
            font-size: 18px;
            color: #555;
            margin-top: 50px;
        }
        
        /* Floating controls for printing/going back */
        .controls {
            position: absolute;
            top: -45px;
            right: 0;
        }
        .btn {
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
            margin-left: 10px;
        }
        .btn-back { background-color: #6c757d; color: white; }
        .btn-back:hover { background-color: #5a6268; }
        .btn-print { background-color: #28a745; color: white; }
        .btn-print:hover { background-color: #218838; }

        @media print {
            body { background-color: white; padding: 0; }
            .controls { display: none; }
            .cert-container { box-shadow: none; border-color: #000; width: 100%; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="cert-container">
            <div class="controls">
                <button type="button" class="btn btn-print" onclick="window.print()">Print Certificate</button>
                <asp:Button ID="btnBack" runat="server" Text="Back to Dashboard" CssClass="btn btn-back" OnClick="btnBack_Click" />
            </div>

            <div class="cert-inner">
                <div class="cert-title">Certificate of Completion</div>
                <div class="cert-subtitle">This certificate is proudly presented to</div>
                
                <div class="cert-name">
                    <asp:Label ID="lblStudentName" runat="server" Text="Student Name"></asp:Label>
                </div>
                
                <div class="cert-subtitle">for successfully completing the course requirements for</div>
                
                <div class="cert-course">
                    <asp:Label ID="lblCourseTitle" runat="server" Text="Cybersecurity Basics"></asp:Label>
                </div>
                
                <div class="cert-date">
                    Awarded on: <asp:Label ID="lblDate" runat="server"></asp:Label><br /><br />
                    <em>Authorized by NetGuard Learning Platform</em>
                </div>
            </div>
        </div>
    </form>
</body>
</html>

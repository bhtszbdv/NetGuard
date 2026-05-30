<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Certificates.aspx.cs" Inherits="Web_Development_Assignment.Certificates" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Certificate of Completion - NetGuard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 30px 20px;
            box-sizing: border-box;
        }

        .controls {
            display: flex;
            gap: 12px;
            margin-bottom: 25px;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-weight: 700;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-back {
            background: rgba(255,255,255,0.15);
            color: white;
            border: 1px solid rgba(255,255,255,0.3);
            backdrop-filter: blur(10px);
        }

        .btn-back:hover {
            background: rgba(255,255,255,0.25);
        }

        .btn-print {
            background: linear-gradient(135deg, #0099ff, #007acc);
            color: white;
            box-shadow: 0 4px 15px rgba(0,153,255,0.4);
        }

        .btn-print:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }

        /* Certificate */
        .cert-container {
            background: white;
            width: 820px;
            max-width: 100%;
            border-radius: 4px;
            box-shadow: 0 25px 60px rgba(0,0,0,0.5);
            overflow: hidden;
            position: relative;
        }

        .cert-top-bar {
            background: linear-gradient(135deg, #0099ff, #005f99);
            height: 12px;
        }

        .cert-bottom-bar {
            background: linear-gradient(135deg, #0099ff, #005f99);
            height: 12px;
        }

        .cert-body {
            padding: 50px 60px;
            border: 3px solid #f0f0f0;
            margin: 15px;
            text-align: center;
            position: relative;
        }

        .cert-watermark {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) rotate(-30deg);
            font-size: 120px;
            color: rgba(0,153,255,0.04);
            font-weight: 900;
            pointer-events: none;
            white-space: nowrap;
        }

        .cert-logo-row {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            margin-bottom: 25px;
        }

        .cert-logo-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #0099ff, #005f99);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 22px;
        }

        .cert-brand-name {
            font-size: 22px;
            font-weight: 800;
            color: #0099ff;
            letter-spacing: 1px;
        }

        .cert-divider {
            width: 80px;
            height: 3px;
            background: linear-gradient(90deg, #0099ff, #007acc);
            margin: 20px auto;
            border-radius: 2px;
        }

        .cert-title {
            font-size: 42px;
            font-weight: 800;
            color: #1f2937;
            letter-spacing: 2px;
            text-transform: uppercase;
            margin: 0 0 10px 0;
            font-family: 'Times New Roman', serif;
        }

        .cert-subtitle {
            font-size: 16px;
            color: #6b7280;
            margin: 0 0 30px 0;
        }

        .cert-name {
            font-size: 42px;
            font-weight: 700;
            color: #0099ff;
            font-style: italic;
            font-family: 'Times New Roman', Georgia, serif;
            padding: 10px 40px;
            border-bottom: 2px solid #e5e7eb;
            display: inline-block;
            margin-bottom: 5px;
        }

        .cert-name-label {
            font-size: 12px;
            color: #9ca3af;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 30px;
        }

        .cert-course-label {
            font-size: 16px;
            color: #6b7280;
            margin: 0 0 12px 0;
        }

        .cert-course {
            font-size: 26px;
            font-weight: 800;
            color: #1f2937;
            margin: 0 0 35px 0;
            padding: 0 20px;
        }

        .cert-footer {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-top: 40px;
            padding-top: 25px;
            border-top: 1px solid #f3f4f6;
        }

        .cert-footer-left, .cert-footer-right {
            text-align: center;
        }

        .cert-footer-signature {
            font-size: 20px;
            font-style: italic;
            font-family: 'Times New Roman', serif;
            color: #374151;
            margin-bottom: 5px;
        }

        .cert-footer-label {
            font-size: 11px;
            text-transform: uppercase;
            color: #9ca3af;
            letter-spacing: 1px;
        }

        .cert-footer-center {
            text-align: center;
        }

        .cert-seal {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #0099ff, #005f99);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 8px auto;
            color: white;
            font-size: 32px;
            box-shadow: 0 4px 15px rgba(0,153,255,0.4);
        }

        .cert-date {
            font-size: 13px;
            color: #6b7280;
        }

        @media print {
            body {
                background: white;
                padding: 0;
                display: block;
            }

            .controls {
                display: none;
            }

            .cert-container {
                box-shadow: none;
                width: 100%;
                max-width: 100%;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="controls">
            <asp:Button ID="btnBack" runat="server" Text="← Back to Dashboard" CssClass="btn btn-back" OnClick="btnBack_Click" CausesValidation="false" />
            <button type="button" class="btn btn-print" onclick="window.print()">
                <i class="fa-solid fa-print"></i> Print Certificate
            </button>
        </div>

        <div class="cert-container">
            <div class="cert-top-bar"></div>

            <div class="cert-body">
                <div class="cert-watermark">NETGUARD</div>

                <div class="cert-logo-row">
                    <div class="cert-logo-icon">
                        <i class="fa-solid fa-shield-halved"></i>
                    </div>
                    <span class="cert-brand-name">NETGUARD</span>
                </div>

                <div class="cert-title">Certificate of Completion</div>
                <div class="cert-divider"></div>

                <p class="cert-subtitle">This certificate is proudly presented to</p>

                <div class="cert-name">
                    <asp:Label ID="lblStudentName" runat="server" Text="Student Name"></asp:Label>
                </div>
                <p class="cert-name-label">Student</p>

                <p class="cert-course-label">for successfully completing the course</p>
                <div class="cert-course">
                    <asp:Label ID="lblCourseTitle" runat="server" Text="Cybersecurity Fundamentals"></asp:Label>
                </div>

                <div class="cert-footer">
                    <div class="cert-footer-left">
                        <div class="cert-footer-signature">NetGuard Platform</div>
                        <div class="cert-footer-label">Authorized By</div>
                    </div>

                    <div class="cert-footer-center">
                        <div class="cert-seal">
                            <i class="fa-solid fa-award"></i>
                        </div>
                        <div class="cert-date">
                            Awarded: <asp:Label ID="lblDate" runat="server"></asp:Label>
                        </div>
                    </div>

                    <div class="cert-footer-right">
                        <div class="cert-footer-signature">Cybersecurity Academy</div>
                        <div class="cert-footer-label">Institution</div>
                    </div>
                </div>
            </div>

            <div class="cert-bottom-bar"></div>
        </div>
    </form>
</body>
</html>

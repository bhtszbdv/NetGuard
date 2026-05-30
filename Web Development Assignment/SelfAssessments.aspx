<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelfAssessments.aspx.cs" Inherits="Web_Development_Assignment.SelfAssessments" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Self-Assessment - NetGuard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
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
            padding: 15px 25px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 10px rgba(0,153,255,0.3);
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .header-title {
            font-size: 18px;
            font-weight: 700;
        }

        .back-link {
            background: white;
            color: #0099ff;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 700;
            font-size: 14px;
            transition: background 0.2s;
            text-decoration: none;
        }

        .back-link:hover {
            background: #e6f3ff;
        }

        .header-brand {
            font-size: 14px;
            opacity: 0.9;
            font-weight: 500;
        }

        .page-wrapper {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 40px 20px;
            min-height: calc(100vh - 60px);
        }

        .quiz-container {
            background: white;
            border-radius: 16px;
            padding: 35px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.08);
            width: 100%;
            max-width: 650px;
            border: 1px solid rgba(0,0,0,0.05);
        }

        .quiz-header-inner {
            text-align: center;
            margin-bottom: 25px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f3f4f6;
        }

        .quiz-header-inner h2 {
            margin: 0 0 5px 0;
            color: #1f2937;
            font-size: 22px;
        }

        .quiz-header-inner p {
            margin: 0;
            color: #6b7280;
            font-size: 14px;
        }

        .progress-container {
            width: 100%;
            background-color: #e9ecef;
            border-radius: 10px;
            margin-bottom: 25px;
            height: 8px;
            overflow: hidden;
        }

        .progress-bar {
            height: 100%;
            background: linear-gradient(90deg, #0099ff, #007acc);
            border-radius: 10px;
            transition: width 0.4s ease;
        }

        .question-badge {
            display: inline-block;
            background: linear-gradient(135deg, #0099ff, #007acc);
            color: white;
            padding: 4px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 12px;
        }

        .question-text {
            font-size: 17px;
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 22px;
            line-height: 1.5;
        }

        .options-list {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .options-list li {
            padding: 12px 16px;
            border: 2px solid #e5e7eb;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
        }

        .options-list li:hover {
            border-color: #0099ff;
            background: #f0f9ff;
        }

        .options-list input[type="radio"] {
            accent-color: #0099ff;
            width: 17px;
            height: 17px;
            flex-shrink: 0;
            margin-right: 12px;
        }

        .options-list label {
            cursor: pointer;
            font-size: 15px;
            color: #374151;
        }

        .warning-label {
            color: #dc3545;
            font-size: 13px;
            font-weight: 600;
            margin-top: 10px;
            display: block;
        }

        .nav-buttons {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 28px;
            gap: 10px;
        }

        .btn {
            padding: 11px 22px;
            border: none;
            border-radius: 8px;
            font-weight: 700;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-skip {
            background: #f3f4f6;
            color: #6b7280;
            border: 1px solid #e5e7eb;
        }

        .btn-skip:hover {
            background: #e5e7eb;
        }

        .btn-next {
            background: linear-gradient(135deg, #0099ff, #007acc);
            color: white;
            box-shadow: 0 4px 12px rgba(0,153,255,0.3);
        }

        .btn-next:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }

        .btn-submit {
            background: linear-gradient(135deg, #28a745, #218838);
            color: white;
            box-shadow: 0 4px 12px rgba(40,167,69,0.3);
        }

        .btn-submit:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }

        .score-tracker {
            display: flex;
            justify-content: space-around;
            margin-top: 25px;
            padding: 15px;
            background: #f9fafb;
            border-radius: 10px;
            border: 1px solid #e5e7eb;
        }

        .score-item {
            text-align: center;
        }

        .score-item .score-label {
            font-size: 11px;
            text-transform: uppercase;
            color: #9ca3af;
            font-weight: 600;
            letter-spacing: 0.5px;
            display: block;
            margin-bottom: 3px;
        }

        .score-item .score-value {
            font-size: 18px;
            font-weight: 700;
            color: #1f2937;
        }

        /* Result Panel */
        .result-panel {
            text-align: center;
            padding: 20px 0;
        }

        .result-icon {
            font-size: 60px;
            margin-bottom: 15px;
        }

        .result-panel h3 {
            font-size: 24px;
            color: #1f2937;
            margin: 0 0 8px 0;
        }

        .result-panel p {
            color: #6b7280;
            margin: 0 0 20px 0;
        }

        .result-score-display {
            font-size: 64px;
            font-weight: 800;
            margin: 20px 0;
            line-height: 1;
        }

        .result-message {
            font-size: 15px;
            color: #374151;
            font-weight: 500;
            padding: 15px;
            background: #f9fafb;
            border-radius: 10px;
            margin-bottom: 25px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">
            <div class="header-left">
                <a href="javascript:history.back()" class="back-link">← Back to Course</a>
                <span class="header-title"><i class="fa-solid fa-clipboard-check"></i> Course Self-Assessment</span>
            </div>
            <span class="header-brand"><i class="fa-solid fa-shield-halved"></i> NetGuard Learning</span>
        </div>

        <div class="page-wrapper">
            <div class="quiz-container">
                <div class="quiz-header-inner">
                    <h2><i class="fa-solid fa-brain"></i> Knowledge Check</h2>
                    <p>Test your understanding of the module material</p>
                </div>

                <asp:Panel ID="pnlQuiz" runat="server">
                    <div class="progress-container">
                        <asp:Panel ID="pnlProgressBar" runat="server" CssClass="progress-bar" Width="0%"></asp:Panel>
                    </div>

                    <div class="question-badge">
                        <asp:Label ID="lblQuestionNumber" runat="server" Text="Question 1 of 5"></asp:Label>
                    </div>

                    <div class="question-text">
                        <asp:Label ID="lblQuestionText" runat="server" Text="What is the primary purpose of a firewall?"></asp:Label>
                    </div>

                    <asp:RadioButtonList ID="rblOptions" runat="server" CssClass="options-list" RepeatLayout="UnorderedList">
                    </asp:RadioButtonList>

                    <asp:Label ID="lblWarning" runat="server" CssClass="warning-label"></asp:Label>

                    <div class="nav-buttons">
                        <asp:Button ID="btnSkip" runat="server" Text="Skip Question" CssClass="btn btn-skip" OnClick="btnSkip_Click" />
                        <asp:Button ID="btnNext" runat="server" Text="Next Question →" CssClass="btn btn-next" OnClick="btnNext_Click" />
                        <asp:Button ID="btnSubmit" runat="server" Text="Finish Quiz ✓" CssClass="btn btn-submit" OnClick="btnSubmit_Click" Visible="false" />
                    </div>

                    <div class="score-tracker">
                        <div class="score-item">
                            <span class="score-label">Correct</span>
                            <span class="score-value"><asp:Label ID="lblCorrect" runat="server" Text="0"></asp:Label></span>
                        </div>
                        <div class="score-item">
                            <span class="score-label">Skipped</span>
                            <span class="score-value"><asp:Label ID="lblSkipped" runat="server" Text="0"></asp:Label></span>
                        </div>
                        <div class="score-item">
                            <span class="score-label">Remaining</span>
                            <span class="score-value"><asp:Label ID="lblRemaining" runat="server" Text="5"></asp:Label></span>
                        </div>
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlResult" runat="server" CssClass="result-panel" Visible="false">
                    <div class="result-icon">🏆</div>
                    <h3>Assessment Complete!</h3>
                    <p>You have finished the quiz for this module.</p>
                    <div class="result-score-display">
                        <asp:Label ID="lblFinalScore" runat="server" Text="100%"></asp:Label>
                    </div>
                    <div class="result-message">
                        <asp:Label ID="lblFeedbackMsg" runat="server"></asp:Label>
                    </div>
                    <asp:Button ID="btnBackToCourse" runat="server" Text="← Back to Course" CssClass="btn btn-next" OnClick="btnBackToCourse_Click" />
                </asp:Panel>
            </div>
        </div>
    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelfAssessments.aspx.cs" Inherits="Web_Development_Assignment.SelfAssessments" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quiz & Self-Assessments</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .quiz-container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            width: 600px;
            max-width: 100%;
        }
        h2 {
            color: #333;
            text-align: center;
            margin-top: 0;
        }
        
        .progress-container {
            width: 100%;
            background-color: #e9ecef;
            border-radius: 5px;
            margin-bottom: 20px;
            height: 10px;
            overflow: hidden;
        }
        .progress-bar {
            height: 100%;
            background-color: #0099ff;
            transition: width 0.3s ease;
        }
        
        .question-header {
            font-weight: bold;
            font-size: 18px;
            margin-bottom: 15px;
            color: #0099ff;
        }
        .question-text {
            font-size: 16px;
            margin-bottom: 20px;
            color: #333;
        }
        
        .options-list {
            list-style-type: none;
            padding: 0;
        }
        .options-list td {
            display: block;
            margin-bottom: 10px;
        }
        .options-list input[type="radio"] {
            margin-right: 10px;
        }
        .options-list label {
            cursor: pointer;
            font-size: 15px;
        }

        .navigation-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 25px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            font-size: 14px;
        }
        .btn-skip { background-color: #6c757d; color: white; }
        .btn-skip:hover { background-color: #5a6268; }
        .btn-next { background-color: #0099ff; color: white; }
        .btn-next:hover { background-color: #007acc; }
        .btn-submit { background-color: #28a745; color: white; }
        .btn-submit:hover { background-color: #218838; }

        .score-tracker {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
            padding-top: 15px;
            border-top: 1px solid #ddd;
            font-size: 14px;
            color: #555;
        }
        
        .result-panel {
            text-align: center;
        }
        .result-score {
            font-size: 48px;
            font-weight: bold;
            color: #28a745;
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="quiz-container">
            <h2>Course Self-Assessment</h2>
            
            <asp:Panel ID="pnlQuiz" runat="server">
                <!-- Progress Bar -->
                <div class="progress-container">
                    <asp:Panel ID="pnlProgressBar" runat="server" CssClass="progress-bar" Width="0%"></asp:Panel>
                </div>
                
                <div class="question-header">
                    <asp:Label ID="lblQuestionNumber" runat="server" Text="Question 1 of 5"></asp:Label>
                </div>
                
                <div class="question-text">
                    <asp:Label ID="lblQuestionText" runat="server" Text="What is the primary purpose of a firewall?"></asp:Label>
                </div>
                
                <asp:RadioButtonList ID="rblOptions" runat="server" CssClass="options-list">
                </asp:RadioButtonList>
                
                <asp:Label ID="lblWarning" runat="server" ForeColor="Red" Font-Bold="true"></asp:Label>

                <div class="navigation-buttons">
                    <asp:Button ID="btnSkip" runat="server" Text="Skip Question" CssClass="btn btn-skip" OnClick="btnSkip_Click" />
                    <asp:Button ID="btnNext" runat="server" Text="Next Question" CssClass="btn btn-next" OnClick="btnNext_Click" />
                    <asp:Button ID="btnSubmit" runat="server" Text="Finish Quiz" CssClass="btn btn-submit" OnClick="btnSubmit_Click" Visible="false" />
                </div>
                
                <div class="score-tracker">
                    <asp:Label ID="lblCorrect" runat="server" Text="Correct: 0"></asp:Label>
                    <asp:Label ID="lblSkipped" runat="server" Text="Skipped: 0"></asp:Label>
                    <asp:Label ID="lblRemaining" runat="server" Text="Remaining: 5"></asp:Label>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlResult" runat="server" CssClass="result-panel" Visible="false">
                <h3>Assessment Complete!</h3>
                <p>You have finished the quiz for this module.</p>
                <div class="result-score">
                    <asp:Label ID="lblFinalScore" runat="server" Text="100%"></asp:Label>
                </div>
                <p><asp:Label ID="lblFeedbackMsg" runat="server"></asp:Label></p>
                <br />
                <asp:Button ID="btnBackToCourse" runat="server" Text="Back to Course" CssClass="btn btn-next" OnClick="btnBackToCourse_Click" />
            </asp:Panel>

        </div>
    </form>
</body>
</html>

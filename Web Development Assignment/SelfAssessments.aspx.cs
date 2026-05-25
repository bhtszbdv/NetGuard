using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;

namespace Web_Development_Assignment
{
    public partial class SelfAssessments : System.Web.UI.Page
    {
        // Simple class to hold quiz data in memory for the assessment
        [Serializable]
        public class Question
        {
            public string Text { get; set; }
            public string[] Options { get; set; }
            public int CorrectOptionIndex { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // Initialize Quiz State
                ViewState["CurrentIndex"] = 0;
                ViewState["CorrectCount"] = 0;
                ViewState["SkippedCount"] = 0;
                
                LoadQuestionsIntoViewState();
                LoadCurrentQuestion();
            }
        }

        private void LoadQuestionsIntoViewState()
        {
            // We simulate pulling questions for the course.
            // Since there is no Questions table in the schema, we hardcode a standard Cybersecurity quiz.
            List<Question> questions = new List<Question>
            {
                new Question { 
                    Text = "What is the primary purpose of a firewall?", 
                    Options = new string[] { "To prevent physical theft of servers", "To monitor and control incoming and outgoing network traffic", "To speed up the internet connection", "To encrypt passwords" },
                    CorrectOptionIndex = 1 
                },
                new Question { 
                    Text = "Which of the following is an example of a Social Engineering attack?", 
                    Options = new string[] { "SQL Injection", "Phishing", "DDoS", "Cross-Site Scripting (XSS)" },
                    CorrectOptionIndex = 1 
                },
                new Question { 
                    Text = "What does 'HTTPS' stand for?", 
                    Options = new string[] { "HyperText Transfer Protocol Secure", "HyperText Transmission Protocol System", "Hyperlink Transfer Technology Protocol", "HyperText Transfer Protocol Standard" },
                    CorrectOptionIndex = 0 
                },
                new Question { 
                    Text = "Which type of malware is designed to demand payment in exchange for restoring access to data?", 
                    Options = new string[] { "Spyware", "Adware", "Ransomware", "Trojan" },
                    CorrectOptionIndex = 2 
                },
                new Question { 
                    Text = "What is a 'Zero-Day' vulnerability?", 
                    Options = new string[] { "A vulnerability that has been fixed", "A software bug known to the vendor but without a patch yet", "A computer with zero viruses", "A network with no firewalls" },
                    CorrectOptionIndex = 1 
                }
            };

            ViewState["Questions"] = questions;
        }

        private void LoadCurrentQuestion()
        {
            List<Question> questions = (List<Question>)ViewState["Questions"];
            int currentIndex = (int)ViewState["CurrentIndex"];
            int correctCount = (int)ViewState["CorrectCount"];
            int skippedCount = (int)ViewState["SkippedCount"];

            lblWarning.Text = "";
            rblOptions.ClearSelection();

            if (currentIndex < questions.Count)
            {
                Question q = questions[currentIndex];
                lblQuestionNumber.Text = $"Question {currentIndex + 1} of {questions.Count}";
                lblQuestionText.Text = q.Text;
                
                rblOptions.Items.Clear();
                for (int i = 0; i < q.Options.Length; i++)
                {
                    rblOptions.Items.Add(new ListItem(q.Options[i], i.ToString()));
                }

                // Update Progress Bar
                double progress = ((double)currentIndex / questions.Count) * 100;
                pnlProgressBar.Width = new Unit(progress, UnitType.Percentage);

                // Update Tracker
                lblCorrect.Text = $"Correct: {correctCount}";
                lblSkipped.Text = $"Skipped: {skippedCount}";
                lblRemaining.Text = $"Remaining: {questions.Count - currentIndex}";

                if (currentIndex == questions.Count - 1)
                {
                    btnNext.Visible = false;
                    btnSubmit.Visible = true;
                }
            }
        }

        private void ProcessAnswer(bool isSkipped)
        {
            List<Question> questions = (List<Question>)ViewState["Questions"];
            int currentIndex = (int)ViewState["CurrentIndex"];
            
            if (isSkipped)
            {
                ViewState["SkippedCount"] = (int)ViewState["SkippedCount"] + 1;
            }
            else
            {
                if (rblOptions.SelectedIndex == -1)
                {
                    lblWarning.Text = "Please select an answer or click Skip.";
                    return;
                }

                Question q = questions[currentIndex];
                if (rblOptions.SelectedIndex == q.CorrectOptionIndex)
                {
                    ViewState["CorrectCount"] = (int)ViewState["CorrectCount"] + 1;
                }
            }

            // Move to next
            ViewState["CurrentIndex"] = currentIndex + 1;

            if ((int)ViewState["CurrentIndex"] < questions.Count)
            {
                LoadCurrentQuestion();
            }
            else
            {
                ShowResults();
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            ProcessAnswer(false);
        }

        protected void btnSkip_Click(object sender, EventArgs e)
        {
            ProcessAnswer(true);
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            ProcessAnswer(false);
        }

        private void ShowResults()
        {
            pnlQuiz.Visible = false;
            pnlResult.Visible = true;

            List<Question> questions = (List<Question>)ViewState["Questions"];
            int correctCount = (int)ViewState["CorrectCount"];
            
            double scorePercentage = ((double)correctCount / questions.Count) * 100;
            lblFinalScore.Text = $"{scorePercentage:0}%";

            if (scorePercentage >= 80)
            {
                lblFeedbackMsg.Text = "Excellent! You have a great understanding of the material.";
                lblFinalScore.ForeColor = System.Drawing.Color.Green;
            }
            else if (scorePercentage >= 50)
            {
                lblFeedbackMsg.Text = "Good job, but there's room for improvement. Review the notes and try again!";
                lblFinalScore.ForeColor = System.Drawing.Color.Orange;
            }
            else
            {
                lblFeedbackMsg.Text = "Don't give up! We recommend re-reading the module resources.";
                lblFinalScore.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnBackToCourse_Click(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["CourseID"];
            if (!string.IsNullOrEmpty(courseId))
            {
                Response.Redirect($"CoursePage.aspx?CourseID={courseId}");
            }
            else
            {
                Response.Redirect("MemberDashboard.aspx");
            }
        }
    }
}
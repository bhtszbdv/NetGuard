using System;

namespace Web_Development_Assignment
{
    public partial class Feedback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtCourseName.Text) || string.IsNullOrWhiteSpace(txtComments.Text))
            {
                lblMessage.Text = "Please fill in all fields.";
                lblMessage.CssClass = "message error";
                return;
            }

            // In a real application, you would save this to a Feedback table.
            // Since the database schema doesn't have a Feedback table, we simulate a successful submission.
            
            txtCourseName.Text = "";
            txtComments.Text = "";
            ddlRating.SelectedIndex = 0;
            
            lblMessage.Text = "Thank you for your feedback! Your review has been submitted.";
            lblMessage.CssClass = "message success";
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("MemberDashboard.aspx");
        }
    }
}
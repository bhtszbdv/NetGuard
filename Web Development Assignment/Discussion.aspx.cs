using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web_Development_Assignment
{
    public partial class Discussion : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Request.QueryString["CourseID"]))
            {
                Response.Redirect("MemberDashboard.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCourseDetails();
                BindMessages();
                ConfigurePostingPermissions();
            }
        }

        private void LoadCourseDetails()
        {
            string courseID = Request.QueryString["CourseID"];
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT CourseTitle FROM Courses WHERE CourseID = @CourseID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CourseID", courseID);
                    try
                    {
                        conn.Open();
                        object titleObj = cmd.ExecuteScalar();
                        if (titleObj != null)
                        {
                            lblCourseTitle.Text = $"{titleObj.ToString()} - Discussion Forum";
                        }
                        else
                        {
                            Response.Redirect("MemberDashboard.aspx");
                        }
                    }
                    catch (Exception ex)
                    {
                        // Fallback
                        lblCourseTitle.Text = "Course Discussion";
                    }
                }
            }
        }

        private void BindMessages()
        {
            string courseID = Request.QueryString["CourseID"];
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // Join with Users table to get the correct UserType dynamically
                string query = @"
                    SELECT d.DiscussionID, d.CourseID, d.Username, d.Message, d.DatePosted, 
                           ISNULL(u.UserType, 'Member') AS UserType 
                    FROM Discussions d 
                    LEFT JOIN Users u ON d.Username = u.Username 
                    WHERE d.CourseID = @CourseID 
                    ORDER BY d.DatePosted ASC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CourseID", courseID);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        rptMessages.DataSource = dt;
                        rptMessages.DataBind();
                    }
                }
            }
        }

        private void ConfigurePostingPermissions()
        {
            // If user is guest or not logged in, they can read but not write posts
            if (Session["Username"] == null || Session["UserType"] == null || Session["UserType"].ToString() == "Guest")
            {
                pnlPostMessage.Visible = false;
                pnlGuestWarning.Visible = true;
            }
            else
            {
                pnlPostMessage.Visible = true;
                pnlGuestWarning.Visible = false;
            }
        }

        protected void btnSubmitPost_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // Ensure user is allowed to post
                if (Session["Username"] == null || Session["UserType"].ToString() == "Guest")
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                string username = Session["Username"].ToString();
                string message = txtMessage.Text.Trim();
                string courseID = Request.QueryString["CourseID"];

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "INSERT INTO Discussions (CourseID, Username, Message, DatePosted) VALUES (@CourseID, @Username, @Message, @DatePosted)";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@CourseID", courseID);
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Message", message);
                        cmd.Parameters.AddWithValue("@DatePosted", DateTime.Now);

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();
                            
                            // Clear input
                            txtMessage.Text = "";
                            
                            // Re-bind messages
                            BindMessages();
                        }
                        catch (Exception ex)
                        {
                            Response.Write($"<script>alert('Failed to post message: {ex.Message}');</script>");
                        }
                    }
                }
            }
        }

        protected void rptMessages_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeletePost")
            {
                // Verify if Admin
                if (Session["UserType"] != null && Session["UserType"].ToString() == "Admin")
                {
                    int postID = Convert.ToInt32(e.CommandArgument);
                    DeletePost(postID);
                }
                else
                {
                    Response.Write("<script>alert('Unauthorized action.');</script>");
                }
            }
        }

        private void DeletePost(int postID)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "DELETE FROM Discussions WHERE DiscussionID = @DiscussionID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@DiscussionID", postID);
                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        
                        // Re-bind messages
                        BindMessages();
                    }
                    catch (Exception ex)
                    {
                        Response.Write($"<script>alert('Error deleting post: {ex.Message}');</script>");
                    }
                }
            }
        }

        protected void btnback_Click(object sender, EventArgs e)
        {
            string courseID = Request.QueryString["CourseID"];
            Response.Redirect($"CoursePage.aspx?CourseID={courseID}");
        }
    }
}
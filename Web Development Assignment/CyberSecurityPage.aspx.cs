using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web_Development_Assignment
{
    public partial class CyberSecurityPage : System.Web.UI.Page
    {
        string connStr =
            ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCourse();
                InitializeProgressTracking();
            }
        }

        void LoadCourse()
        {
            string courseID = Request.QueryString["CourseID"];

            if (courseID == null)
                return;

            SqlConnection conn = new SqlConnection(connStr);

            string query = "SELECT CourseTitle FROM Courses WHERE CourseID=@CourseID";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@CourseID", courseID);

            conn.Open();

            object result = cmd.ExecuteScalar();

            if (result != null)
            {
                lblCourseTitle.Text = result.ToString();
            }

            conn.Close();
        }

        void InitializeProgressTracking()
        {
            // Initialize progress tracking for the course
            // This will be expanded to track user progress through lessons
        }

        protected void btnback_Click(object sender, EventArgs e)
        {
            Response.Redirect("MemberDashboard.aspx");
        }
    }
}

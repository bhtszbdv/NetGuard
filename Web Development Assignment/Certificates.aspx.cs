using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Web_Development_Assignment
{
    public partial class Certificates : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblDate.Text = DateTime.Now.ToString("MMMM dd, yyyy");
                
                LoadStudentName();

                string courseId = Request.QueryString["CourseID"];
                if (!string.IsNullOrEmpty(courseId))
                {
                    LoadCourseTitle(courseId);
                }
                else
                {
                    // Fallback
                    lblCourseTitle.Text = "Cybersecurity Fundamentals";
                }
            }
        }

        private void LoadStudentName()
        {
            string username = Session["Username"].ToString();
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT FirstName, LastName FROM Users WHERE Username = @Username";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string fName = reader["FirstName"].ToString();
                                string lName = reader["LastName"].ToString();
                                lblStudentName.Text = $"{fName} {lName}";
                            }
                        }
                    }
                    catch
                    {
                        lblStudentName.Text = username.ToUpper();
                    }
                }
            }
        }

        private void LoadCourseTitle(string courseId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT CourseTitle FROM Courses WHERE CourseID = @CourseID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CourseID", courseId);
                    try
                    {
                        conn.Open();
                        object result = cmd.ExecuteScalar();
                        if (result != null)
                        {
                            lblCourseTitle.Text = result.ToString();
                        }
                    }
                    catch { }
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("MemberDashboard.aspx");
        }
    }
}
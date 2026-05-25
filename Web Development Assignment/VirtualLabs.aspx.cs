using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Web_Development_Assignment
{
    public partial class VirtualLabs : System.Web.UI.Page
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
                string courseId = Request.QueryString["CourseID"];
                if (string.IsNullOrEmpty(courseId))
                {
                    Response.Redirect("MemberDashboard.aspx");
                    return;
                }

                LoadCourseTitle(courseId);
                LoadLabs(courseId);
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
                            lblCourseTitle.Text = $"Terminal: {result.ToString()} Labs";
                        }
                    }
                    catch
                    {
                        lblCourseTitle.Text = "Terminal: Virtual Labs";
                    }
                }
            }
        }

        private void LoadLabs(string courseId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT LabTitle, Description, LabLink FROM VirtualLabs WHERE CourseID = @CourseID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CourseID", courseId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            rptLabs.DataSource = dt;
                            rptLabs.DataBind();
                            pnlNoLabs.Visible = false;
                        }
                        else
                        {
                            // Inject mock labs for the assignment presentation if DB is empty
                            dt.Rows.Add("Lab 1: Firewall Configuration Simulation", "Practice writing firewall rules to block malicious IPs.", "https://example.com/lab1");
                            dt.Rows.Add("Lab 2: Phishing Email Analysis", "Analyze headers of real-world phishing emails safely.", "https://example.com/lab2");
                            
                            rptLabs.DataSource = dt;
                            rptLabs.DataBind();
                            pnlNoLabs.Visible = false;
                        }
                    }
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
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
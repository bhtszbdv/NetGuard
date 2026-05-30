using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Web_Development_Assignment
{
    public partial class Resources : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadResources();
            }
        }

        private void LoadResources()
        {
            string courseID = Request.QueryString["CourseID"];

            if (string.IsNullOrEmpty(courseID))
            {
                pnlEmpty.Visible = true;
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT Title, Description, FilePath FROM Resources WHERE CourseID = @CourseID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CourseID", courseID);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            rptResources.DataSource = reader;
                            rptResources.DataBind();
                        }

                        if (rptResources.Items.Count == 0)
                        {
                            pnlEmpty.Visible = true;
                        }
                    }
                    catch
                    {
                        pnlEmpty.Visible = true;
                    }
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["CourseID"];
            if (!string.IsNullOrEmpty(courseId))
            {
                Response.Redirect("CoursePage.aspx?CourseID=" + courseId);
            }
            else
            {
                Response.Redirect("MemberDashboard.aspx");
            }
        }
    }
}

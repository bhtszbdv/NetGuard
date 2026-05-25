using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web_Development_Assignment
{
    public partial class Resources : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadResources();
            }

        }
        void LoadResources()
        {
            string courseID = Request.QueryString["CourseID"];

            if (courseID == null)
            {
                Response.Write("CourseID not found.");
                return;
            }

            string connStr =
                ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;

            SqlConnection conn = new SqlConnection(connStr);

            string query =
                "SELECT Title, Description, FilePath " +
                "FROM Resources " +
                "WHERE CourseID=@CourseID";

            SqlCommand cmd = new SqlCommand(query, conn);

            cmd.Parameters.AddWithValue("@CourseID", courseID);

            conn.Open();

            SqlDataReader reader = cmd.ExecuteReader();

            rptResources.DataSource = reader;
            rptResources.DataBind();

            conn.Close();
        }

    }
}
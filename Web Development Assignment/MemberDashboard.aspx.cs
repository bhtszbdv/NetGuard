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
    public partial class WebForm2 : System.Web.UI.Page
    {
        string connStr =
            ConfigurationManager.ConnectionStrings["DBConnection"]
            .ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAllCourses();
                LoadMyCourses();
            }
        }

        void LoadAllCourses()
        {
            SqlConnection conn =
                new SqlConnection(connStr);

            string query =
                "SELECT * FROM Courses";

            SqlDataAdapter da =
                new SqlDataAdapter(query, conn);

            DataTable dt =
                new DataTable();

            da.Fill(dt);

            rptallcourses.DataSource = dt;
            rptallcourses.DataBind();
        }

        void LoadMyCourses()
        {
            if (Session["Username"] == null)
            {
                pnlMyCourses.Visible = false;
                return;
            }

            SqlConnection conn =
                new SqlConnection(connStr);

            string query =
                "SELECT Courses.* " +
                "FROM Courses " +
                "INNER JOIN Enrollments " +
                "ON Courses.CourseID = Enrollments.CourseID " +
                "INNER JOIN Users " +
                "ON Users.UID = Enrollments.UID " +
                "WHERE Users.Username=@Username";

            SqlCommand cmd =
                new SqlCommand(query, conn);

            cmd.Parameters.AddWithValue(
                "@Username",
                Session["Username"]);

            SqlDataAdapter da =
                new SqlDataAdapter(cmd);

            DataTable dt =
                new DataTable();

            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                pnlMyCourses.Visible = true;

                rptmycourses.DataSource = dt;
                rptmycourses.DataBind();
            }
            else
            {
                pnlMyCourses.Visible = false;
            }
        }
        protected void btnCertificates_Click(object sender, EventArgs e)
        {
            if (Session["UserType"] != null && Session["UserType"].ToString() == "Guest")
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                Response.Redirect("Certificates.aspx");
            }
        }

        protected void btncertifates_Click(object sender, EventArgs e)
        {
            Response.Redirect("Certificates.aspx");
        }

        protected void btnfeedback_Click1(object sender, EventArgs e)
        {
            Response.Redirect("Feedback.aspx");
        }

        protected void btncontactus_Click(object sender, EventArgs e)
        {
            Response.Redirect("Contact.aspx");
        }

        protected void btnFAQ_Click1(object sender, EventArgs e)
        {
            Response.Redirect("FAQ.aspx");
        }
        protected void txtsearch_TextChanged(object sender, EventArgs e)
        {
            string keyword = txtsearch.Text.Trim();
            SqlConnection conn1 = new SqlConnection(connStr);

            string queryAll =
                "SELECT * FROM Courses WHERE CourseTitle LIKE @keyword";

            SqlCommand cmdAll = new SqlCommand(queryAll, conn1);
            cmdAll.Parameters.AddWithValue("@keyword", "%" + keyword + "%");

            SqlDataAdapter daAll = new SqlDataAdapter(cmdAll);
            DataTable dtAll = new DataTable();

            daAll.Fill(dtAll);
            rptallcourses.DataSource = dtAll;
            rptallcourses.DataBind();

            if (Session["Username"] != null)
            {
                SqlConnection conn2 =
                    new SqlConnection(connStr);

                string queryMy =
                    "SELECT Courses.* " +
                    "FROM Courses " +
                    "INNER JOIN Enrollments " +
                    "ON Courses.CourseID = Enrollments.CourseID " +
                    "INNER JOIN Users " +
                    "ON Users.UID = Enrollments.UID " +
                    "WHERE Users.Username=@Username " +
                    "AND Courses.CourseTitle LIKE @keyword";

                SqlCommand cmdMy =
                    new SqlCommand(queryMy, conn2);

                cmdMy.Parameters.AddWithValue(
                    "@Username",
                    Session["Username"]);

                cmdMy.Parameters.AddWithValue(
                    "@keyword",
                    "%" + keyword + "%");

                SqlDataAdapter daMy =
                    new SqlDataAdapter(cmdMy);

                DataTable dtMy =
                    new DataTable();
                daMy.Fill(dtMy);

                if (dtMy.Rows.Count > 0)
                {
                    pnlMyCourses.Visible = true;

                    rptmycourses.DataSource = dtMy;
                    rptmycourses.DataBind();
                }
                else
                {
                    pnlMyCourses.Visible = false;
                }
            }
        }
        protected void btnprofile_Click(object sender, EventArgs e)
        {
            if (Session["UserType"] != null &&
                Session["UserType"].ToString() == "Member")
            {
                Response.Redirect("UserProfile.aspx");
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
        protected void OpenCourse(object sender, CommandEventArgs e)
        {
            string courseID = e.CommandArgument.ToString();
            Response.Redirect("CoursePage.aspx?CourseID=" + courseID);
        }

        protected void rptmycourses_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

        }

        protected void btnNotifications_Click(object sender, EventArgs e)
        {
            if (Session["UserType"] != null && Session["UserType"].ToString() == "Guest")
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                Response.Redirect("Notifications.aspx");
            }
        }

        protected void btnlogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}
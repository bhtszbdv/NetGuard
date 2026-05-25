using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web_Development_Assignment
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] == null ||
                Session["UserType"].ToString() != "Admin")
            {
                Response.Redirect("Login.aspx");
            }
        }
        protected void btnUserManagement_Click(object sender, EventArgs e)
        {
            Response.Redirect("UserManagement.aspx");
        }

        protected void btnCourseManagement_Click(object sender, EventArgs e)
        {
            Response.Redirect("CourseManagement.aspx");
        }
        protected void btnEnrollmentManagement_Click(object sender, EventArgs e)
        {
            Response.Redirect("EnrollmentManagement.aspx");
        }

        protected void btnmyprofile_Click(object sender, EventArgs e)
        {
            if (Session["UserType"] != null &&
                Session["UserType"].ToString() == "Admin")
            {
                Response.Redirect("UserProfile.aspx");
            }
            else
            {
                Response.Redirect("Login.aspx");
            }

        }

        protected void btnchangepwd_Click(object sender, EventArgs e)
        {
            // Ensure the user is an Admin before redirecting
            if (Session["UserType"] != null && Session["UserType"].ToString() == "Admin")
            {
                Response.Redirect("ChangePassword.aspx");
            }
            else
            {
                Response.Redirect("Login.aspx");
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
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
    public partial class Notifications : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Security check: Guests and non-logged-in users cannot access notifications
            if (Session["Username"] == null || Session["UserType"] == null || Session["UserType"].ToString() == "Guest")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                BindNotifications();
            }
        }

        private void BindNotifications()
        {
            string username = Session["Username"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM Notifications WHERE Username = @Username ORDER BY DateCreated DESC";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        rptNotifications.DataSource = dt;
                        rptNotifications.DataBind();

                        // Disable buttons if list is empty
                        bool hasItems = dt.Rows.Count > 0;
                        btnMarkRead.Visible = hasItems;
                        btnClearAll.Visible = hasItems;
                    }
                }
            }
        }

        protected void btnMarkRead_Click(object sender, EventArgs e)
        {
            string username = Session["Username"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "UPDATE Notifications SET IsRead = 1 WHERE Username = @Username AND IsRead = 0";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        BindNotifications();
                    }
                    catch (Exception ex)
                    {
                        Response.Write($"<script>alert('Error marking notifications as read: {ex.Message}');</script>");
                    }
                }
            }
        }

        protected void btnClearAll_Click(object sender, EventArgs e)
        {
            string username = Session["Username"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "DELETE FROM Notifications WHERE Username = @Username";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        BindNotifications();
                    }
                    catch (Exception ex)
                    {
                        Response.Write($"<script>alert('Error clearing notifications: {ex.Message}');</script>");
                    }
                }
            }
        }

        protected void rptNotifications_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteNotification")
            {
                int notifId = Convert.ToInt32(e.CommandArgument);
                DeleteSingleNotification(notifId);
            }
        }

        private void DeleteSingleNotification(int notifId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "DELETE FROM Notifications WHERE NotificationID = @NotificationID AND Username = @Username";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@NotificationID", notifId);
                    cmd.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        BindNotifications();
                    }
                    catch (Exception ex)
                    {
                        Response.Write($"<script>alert('Error deleting notification: {ex.Message}');</script>");
                    }
                }
            }
        }

        protected void btnback_Click(object sender, EventArgs e)
        {
            if (Session["UserType"] != null && Session["UserType"].ToString() == "Admin")
            {
                Response.Redirect("AdminDashboard.aspx");
            }
            else
            {
                Response.Redirect("MemberDashboard.aspx");
            }
        }
    }
}
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
    public partial class ForgotPassword : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMessage.Text = "";
            }
        }

        protected void btnVerify_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            if (Page.IsValid)
            {
                string username = txtUsername.Text.Trim();
                string email = txtEmail.Text.Trim();
                string mobile = txtMobile.Text.Trim();

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "SELECT COUNT(*) FROM Users WHERE Username = @Username AND Email = @Email AND Mobile = @Mobile";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Mobile", mobile);

                        try
                        {
                            conn.Open();
                            int count = (int)cmd.ExecuteScalar();

                            if (count > 0)
                            {
                                ViewState["ResetUsername"] = username;
                                pnlVerify.Visible = false;
                                pnlReset.Visible = true;
                            }
                            else
                            {
                                lblMessage.CssClass = "message error-text";
                                lblMessage.Text = "Verification failed. The details do not match any registered account.";
                            }
                        }
                        catch (Exception ex)
                        {
                            lblMessage.CssClass = "message error-text";
                            lblMessage.Text = $"Database error: {ex.Message}";
                        }
                    }
                }
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            if (Page.IsValid)
            {
                if (ViewState["ResetUsername"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                string username = ViewState["ResetUsername"].ToString();
                string newPassword = txtNewPassword.Text.Trim();

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "UPDATE Users SET Password = @Password WHERE Username = @Username";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Password", newPassword);
                        cmd.Parameters.AddWithValue("@Username", username);

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();

                            // Insert notification about password change
                            string notifyQuery = "INSERT INTO Notifications (Username, Message, DateCreated, IsRead) VALUES (@Username, @Message, GETDATE(), 0)";
                            using (SqlCommand notifyCmd = new SqlCommand(notifyQuery, conn))
                            {
                                notifyCmd.Parameters.AddWithValue("@Username", username);
                                notifyCmd.Parameters.AddWithValue("@Message", "Your account password was successfully reset using the forgot password module.");
                                notifyCmd.ExecuteNonQuery();
                            }

                            pnlReset.Visible = false;
                            pnlSuccess.Visible = true;
                        }
                        catch (Exception ex)
                        {
                            lblMessage.CssClass = "message error-text";
                            lblMessage.Text = $"Failed to reset password: {ex.Message}";
                        }
                    }
                }
            }
        }
    }
}

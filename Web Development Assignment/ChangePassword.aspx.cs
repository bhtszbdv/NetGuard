using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Web_Development_Assignment
{
    public partial class ChangePassword : System.Web.UI.Page
    { 
        string connStr = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMessage.Text = "";

                // Security check: Ensure the user is logged in
                if (Session["Username"] == null || Session["UserType"] == null)
                {
                    Response.Redirect("Login.aspx");
                }

                // Dynamic Cancel Button Routing
                string userType = Session["UserType"].ToString();
                if (userType == "Admin")
                {
                    // Update this if your admin dashboard file has a different name
                    btnCancel.HRef = "AdminDashboard.aspx";
                }
                else
                {
                    btnCancel.HRef = "MemberDashboard.aspx";
                }
            }
        }

        protected void btnUpdatePassword_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";

            if (Page.IsValid)
            {
                string username = Session["Username"].ToString();
                string currentPassword = txtCurrentPassword.Text.Trim();
                string newPassword = txtNewPassword.Text.Trim();

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    try
                    {
                        conn.Open();

                        // Step 1: Fetch the ACTUAL current password from the database
                        string fetchQuery = "SELECT Password FROM Users WHERE Username = @Username";
                        using (SqlCommand fetchCmd = new SqlCommand(fetchQuery, conn))
                        {
                            fetchCmd.Parameters.AddWithValue("@Username", username);

                            object dbResult = fetchCmd.ExecuteScalar();

                            if (dbResult != null)
                            {
                                string actualDbPassword = dbResult.ToString();

                                // Step 2: Validate that the current password they typed is correct
                                if (currentPassword != actualDbPassword)
                                {
                                    lblMessage.CssClass = "message error-text";
                                    lblMessage.Text = "The current password you entered is incorrect.";
                                    return; // Halt execution
                                }

                                // Step 3: The NEW security check (compared against the DB truth)
                                if (newPassword == actualDbPassword)
                                {
                                    lblMessage.CssClass = "message error-text";
                                    lblMessage.Text = "Your new password cannot be the same as your current password.";
                                    return; // Halt execution
                                }

                                // Step 4: Both checks passed, update the database
                                string updateQuery = "UPDATE Users SET Password = @NewPassword WHERE Username = @Username";
                                using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn))
                                {
                                    updateCmd.Parameters.AddWithValue("@NewPassword", newPassword);
                                    updateCmd.Parameters.AddWithValue("@Username", username);
                                    updateCmd.ExecuteNonQuery();
                                }

                                // Step 5: Insert security notification
                                string notifyQuery = "INSERT INTO Notifications (Username, Message, DateCreated, IsRead) VALUES (@Username, @Message, GETDATE(), 0)";
                                using (SqlCommand notifyCmd = new SqlCommand(notifyQuery, conn))
                                {
                                    notifyCmd.Parameters.AddWithValue("@Username", username);
                                    notifyCmd.Parameters.AddWithValue("@Message", "Your account password was successfully updated via the Profile Settings.");
                                    notifyCmd.ExecuteNonQuery();
                                }

                                // Show success message and clear fields
                                lblMessage.CssClass = "message success-text";
                                lblMessage.Text = "Password successfully updated!";

                                txtCurrentPassword.Text = "";
                                txtNewPassword.Text = "";
                                txtConfirmPassword.Text = "";
                            }
                            else
                            {
                                lblMessage.CssClass = "message error-text";
                                lblMessage.Text = "Account not found.";
                            }
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
}
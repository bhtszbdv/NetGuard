using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Web_Development_Assignment
{
    public partial class UserProfile : System.Web.UI.Page
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
                LoadUserData();
            }
        }

        private void LoadUserData()
        {
            string username = Session["Username"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT Username, FirstName, LastName, Email, Mobile FROM Users WHERE Username = @Username";
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
                                txtUsername.Text = reader["Username"].ToString();
                                txtFirstName.Text = reader["FirstName"].ToString();
                                txtLastName.Text = reader["LastName"].ToString();
                                txtEmail.Text = reader["Email"].ToString();
                                txtMobile.Text = reader["Mobile"].ToString();
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = "Error loading profile data: " + ex.Message;
                        lblMessage.CssClass = "message error";
                    }
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            string username = Session["Username"].ToString();
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string mobile = txtMobile.Text.Trim();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"UPDATE Users 
                                 SET FirstName = @FirstName, 
                                     LastName = @LastName, 
                                     Email = @Email, 
                                     Mobile = @Mobile 
                                 WHERE Username = @Username";
                                 
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@FirstName", firstName);
                    cmd.Parameters.AddWithValue("@LastName", lastName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Mobile", mobile);
                    cmd.Parameters.AddWithValue("@Username", username);

                    try
                    {
                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            lblMessage.Text = "Profile updated successfully!";
                            lblMessage.CssClass = "message success";
                        }
                        else
                        {
                            lblMessage.Text = "Failed to update profile.";
                            lblMessage.CssClass = "message error";
                        }
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = "Error updating profile: " + ex.Message;
                        lblMessage.CssClass = "message error";
                    }
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
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
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
    public partial class Contact : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Auto-fill user details if logged in (and not a guest)
                if (Session["Username"] != null && Session["UserType"].ToString() != "Guest")
                {
                    string username = Session["Username"].ToString();
                    LoadUserInfo(username);
                }
            }
        }

        private void LoadUserInfo(string username)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT FirstName, LastName, Email FROM Users WHERE Username = @Username";
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
                                txtname.Text = $"{reader["FirstName"]} {reader["LastName"]}";
                                txtemail.Text = reader["Email"].ToString();
                                
                                // Disable editing for logged in user details to lock profile information
                                txtname.ReadOnly = true;
                                txtemail.ReadOnly = true;
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        // Handle database error (silently fallback)
                    }
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string name = txtname.Text.Trim();
                string email = txtemail.Text.Trim();
                string subject = txtsubject.Text.Trim();
                string message = txtmessage.Text.Trim();

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "INSERT INTO ContactMessages (Name, Email, Subject, Message) VALUES (@Name, @Email, @Subject, @Message)";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Subject", subject);
                        cmd.Parameters.AddWithValue("@Message", message);

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();
                            
                            pnlSuccess.Visible = true;
                            
                            // Clear input fields
                            txtsubject.Text = "";
                            txtmessage.Text = "";
                            if (Session["Username"] == null || Session["UserType"].ToString() == "Guest")
                            {
                                txtname.Text = "";
                                txtemail.Text = "";
                            }
                        }
                        catch (Exception ex)
                        {
                            // In a real-world scenario we would log the exception
                            Response.Write($"<script>alert('Failed to send message: {ex.Message}');</script>");
                        }
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
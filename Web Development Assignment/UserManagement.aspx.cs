using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Web_Development_Assignment
{
    public partial class UserManagement : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] == null || Session["UserType"].ToString() != "Admin")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        private void BindGrid()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT UID, Username, UserType, FirstName, LastName, Email, Mobile FROM Users ORDER BY UID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvUsers.DataSource = dt;
                        gvUsers.DataBind();
                    }
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminDashboard.aspx");
        }

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtAddUsername.Text) || string.IsNullOrWhiteSpace(txtAddPassword.Text))
            {
                ShowMessage("Username and Password are required.", false);
                return;
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // Check if username exists
                string checkQuery = "SELECT COUNT(1) FROM Users WHERE Username = @Username";
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@Username", txtAddUsername.Text.Trim());
                    conn.Open();
                    int count = Convert.ToInt32(checkCmd.ExecuteScalar());
                    if (count > 0)
                    {
                        ShowMessage("Username already exists. Please choose another.", false);
                        return;
                    }
                }

                string query = "INSERT INTO Users (Username, Password, UserType, FirstName, LastName, Email) VALUES (@Username, @Password, @UserType, @FirstName, @LastName, @Email)";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", txtAddUsername.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", txtAddPassword.Text.Trim());
                    cmd.Parameters.AddWithValue("@UserType", ddlAddRole.SelectedValue);
                    cmd.Parameters.AddWithValue("@FirstName", txtAddFirstName.Text.Trim());
                    cmd.Parameters.AddWithValue("@LastName", txtAddLastName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", txtAddEmail.Text.Trim());

                    try
                    {
                        cmd.ExecuteNonQuery();
                        ShowMessage("User added successfully!", true);
                        
                        // Clear fields
                        txtAddUsername.Text = "";
                        txtAddPassword.Text = "";
                        txtAddFirstName.Text = "";
                        txtAddLastName.Text = "";
                        txtAddEmail.Text = "";
                        
                        BindGrid();
                    }
                    catch (Exception ex)
                    {
                        ShowMessage("Error adding user: " + ex.Message, false);
                    }
                }
            }
        }

        protected void gvUsers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvUsers.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void gvUsers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvUsers.EditIndex = -1;
            BindGrid();
        }

        protected void gvUsers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int uid = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvUsers.Rows[e.RowIndex];

            string userType = (row.FindControl("ddlEditRole") as DropDownList).SelectedValue;
            string firstName = (row.Cells[3].Controls[0] as TextBox).Text;
            string lastName = (row.Cells[4].Controls[0] as TextBox).Text;
            string email = (row.Cells[5].Controls[0] as TextBox).Text;
            string mobile = (row.Cells[6].Controls[0] as TextBox).Text;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "UPDATE Users SET UserType = @UserType, FirstName = @FirstName, LastName = @LastName, Email = @Email, Mobile = @Mobile WHERE UID = @UID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UID", uid);
                    cmd.Parameters.AddWithValue("@UserType", userType);
                    cmd.Parameters.AddWithValue("@FirstName", firstName);
                    cmd.Parameters.AddWithValue("@LastName", lastName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Mobile", mobile);

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        
                        gvUsers.EditIndex = -1;
                        BindGrid();
                        ShowMessage("User updated successfully!", true);
                    }
                    catch (Exception ex)
                    {
                        ShowMessage("Error updating user: " + ex.Message, false);
                    }
                }
            }
        }

        protected void gvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int uid = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    
                    // Note: Cannot delete user if they have enrollments, discussions, etc. due to Foreign Keys.
                    // Must clear foreign keys first or just let the exception happen. For simplicity, catching exception.
                    
                    string query = "DELETE FROM Users WHERE UID = @UID";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UID", uid);
                        cmd.ExecuteNonQuery();
                    }
                    
                    BindGrid();
                    ShowMessage("User deleted successfully!", true);
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 547) // Foreign Key constraint violation
                    {
                        ShowMessage("Cannot delete this user because they have associated records (enrollments, discussions, etc.).", false);
                    }
                    else
                    {
                        ShowMessage("Error deleting user: " + ex.Message, false);
                    }
                }
            }
        }

        private void ShowMessage(string msg, bool isSuccess)
        {
            lblMessage.Text = msg;
            lblMessage.CssClass = isSuccess ? "message success" : "message error";
        }
    }
}
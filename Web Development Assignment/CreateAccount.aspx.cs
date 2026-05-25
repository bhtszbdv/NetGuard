using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web_Development_Assignment
{
    public partial class CreateAccount : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btncreate_Click(object sender, EventArgs e)
        {
            lblUsernameError.Text = "";
            lblPasswordError.Text = "";
            lblEmailError.Text = "";
            lblMobileError.Text = "";

            string username = txtusername.Text.Trim();
            string password = txtpassword.Text.Trim();
            string firstname = txtfirstname.Text.Trim();
            string lastname = txtlastname.Text.Trim();
            string email = txtemail.Text.Trim();
            string mobile = txtmobile.Text.Trim();
            bool hasError = false;
            string passwordPattern = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$";

            if (!Regex.IsMatch(password, passwordPattern))
            {
                lblPasswordError.Text =
                    "Password must be 8+ chars, include uppercase, lowercase & number.";
                hasError = true;
            }
            string emailPattern = @"^[^@\s]+@[^@\s]+\.[^@\s]+$";
            if (!Regex.IsMatch(email, emailPattern))
            {
                lblEmailError.Text = "Invalid email format.";
                hasError = true;
            }

            string mobilePattern = @"^01[0-9]{8,9}$";
            if (!Regex.IsMatch(mobile, mobilePattern))
            {
                lblMobileError.Text = "Invalid mobile number (01XXXXXXXXX).";
                hasError = true;
            }
            if (hasError)
            {
                return;
            }

            string connStr =
                ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;

            SqlConnection conn = new SqlConnection(connStr);
            string checkQuery =
                "SELECT COUNT(*) FROM Users WHERE Username=@Username";

            SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
            checkCmd.Parameters.AddWithValue("@Username", username);

            conn.Open();

            int exists = (int)checkCmd.ExecuteScalar();

            if (exists > 0)
            {
                lblUsernameError.Text = "Username already exists!";
                conn.Close();
                return;
            }

            string query =
                "INSERT INTO Users " +
                "(Username, Password, UserType, FirstName, LastName, Email, Mobile) " +
                "VALUES " +
                "(@Username, @Password, 'Member', @FirstName, @LastName, @Email, @Mobile)";
            SqlCommand cmd = new SqlCommand(query, conn);

            cmd.Parameters.AddWithValue("@Username", username);
            cmd.Parameters.AddWithValue("@Password", password);
            cmd.Parameters.AddWithValue("@FirstName", firstname);
            cmd.Parameters.AddWithValue("@LastName", lastname);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@Mobile", mobile);
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Redirect("Login.aspx");
        }
        protected void txtusername_TextChanged(object sender, EventArgs e)
        {

        }

        protected void txtpassword_TextChanged(object sender, EventArgs e)
        {

        }

        protected void txtfirstname_TextChanged(object sender, EventArgs e)
        {

        }

        protected void txtlastname_TextChanged(object sender, EventArgs e)
        {

        }

        protected void txtemail_TextChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox6_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
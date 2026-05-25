using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data.SqlClient;

namespace Web_Development_Assignment
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitializeDatabaseIfNeeded();
            }
        }

        private void InitializeDatabaseIfNeeded()
        {
            string masterConnStr = "Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=master;Integrated Security=True";
            string dbName = "LearningSystemDB";

            using (SqlConnection conn = new SqlConnection(masterConnStr))
            {
                string checkQuery = "SELECT database_id FROM sys.databases WHERE name = @DbName";
                using (SqlCommand cmd = new SqlCommand(checkQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@DbName", dbName);
                    try
                    {
                        conn.Open();
                        object dbId = cmd.ExecuteScalar();
                        if (dbId == null)
                        {
                            // Database doesn't exist, create it!
                            string createQuery = "CREATE DATABASE LearningSystemDB";
                            using (SqlCommand createCmd = new SqlCommand(createQuery, conn))
                            {
                                createCmd.ExecuteNonQuery();
                            }

                            // Wait 1.5 seconds for SQL Server to register database creation
                            System.Threading.Thread.Sleep(1500);

                            // Now run the seed script!
                            RunDatabaseScript();
                        }
                    }
                    catch (Exception ex)
                    {
                        // Log database check error in Debug output
                        System.Diagnostics.Debug.WriteLine("Database auto-init error: " + ex.Message);
                    }
                }
            }
        }

        private void RunDatabaseScript()
        {
            string scriptPath = Server.MapPath("~/setup_database.sql");
            if (System.IO.File.Exists(scriptPath))
            {
                string scriptContent = System.IO.File.ReadAllText(scriptPath);
                
                // Split the script by GO statements on their own lines
                string[] batches = System.Text.RegularExpressions.Regex.Split(
                    scriptContent, 
                    @"^\s*GO\s*$", 
                    System.Text.RegularExpressions.RegexOptions.IgnoreCase | System.Text.RegularExpressions.RegexOptions.Multiline
                );

                string dbConnStr = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(dbConnStr))
                {
                    conn.Open();
                    foreach (string batch in batches)
                    {
                        string sql = batch.Trim();
                        // Skip database creation and database switching, since we handle connection directly
                        if (sql.StartsWith("CREATE DATABASE", StringComparison.OrdinalIgnoreCase) || 
                            sql.StartsWith("USE ", StringComparison.OrdinalIgnoreCase))
                        {
                            continue;
                        }
                        if (!string.IsNullOrEmpty(sql))
                        {
                            using (SqlCommand cmd = new SqlCommand(sql, conn))
                            {
                                try
                                {
                                    cmd.ExecuteNonQuery();
                                }
                                catch (Exception ex)
                                {
                                    System.Diagnostics.Debug.WriteLine("Script execution warning: " + ex.Message);
                                }
                            }
                        }
                    }
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtusername.Text.Trim();
            string password = txtpassword.Text.Trim();

            string connStr =
                ConfigurationManager.ConnectionStrings["DBConnection"]
                .ConnectionString;

            SqlConnection conn = new SqlConnection(connStr);

            string query =
                "SELECT * FROM Users " +
                "WHERE Username=@Username " +
                "AND Password=@Password";

            SqlCommand cmd = new SqlCommand(query, conn);

            cmd.Parameters.AddWithValue("@Username", username);
            cmd.Parameters.AddWithValue("@Password", password);
            try
            {
                conn.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    reader.Read();

                    Session["Username"] =
                        reader["Username"].ToString();
                    Session["UserType"] =
                        reader["UserType"].ToString();

                    if (Session["UserType"].ToString() == "Admin")
                    {
                        Response.Redirect("AdminDashboard.aspx");
                    }
                    else
                    {
                        Response.Redirect("MemberDashboard.aspx");
                    }
                }
                else
                {
                    lblmessage.Text =
                        "Invalid username or password!";
                }
            }
            catch (Exception ex)
            {
                lblmessage.Text = "Database connection error: " + ex.Message;
            }
            finally
            {
                conn.Close();
            }
        }

        protected void Button1_Click(object sender, EventArgs e) //continue as guest
        {
            Session["Username"] = "Guest";
            Session["UserType"] = "Guest";

            Response.Redirect("MemberDashboard.aspx");
        }

        protected void LinkButton1_Click(object sender, EventArgs e) //Create account
        {
            Response.Redirect("CreateAccount.aspx");
        }

        protected void btnForgotPassword_Click(object sender, EventArgs e)
        {
            Response.Redirect("ForgotPassword.aspx");
        }
    }
}
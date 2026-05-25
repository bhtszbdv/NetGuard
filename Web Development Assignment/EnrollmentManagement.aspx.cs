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
    public partial class EnrollmentManagement : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Security Check: Only Administrators allowed
            if (Session["UserType"] == null || Session["UserType"].ToString() != "Admin")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                PopulateDropdowns();
                BindEnrollments("");
            }
        }

        private void PopulateDropdowns()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // Load Members only (Students)
                string userQuery = "SELECT UID, Username + ' (' + FirstName + ' ' + LastName + ')' AS DisplayName FROM Users WHERE UserType = 'Member' ORDER BY Username";
                // Load All Courses
                string courseQuery = "SELECT CourseID, CourseTitle FROM Courses ORDER BY CourseTitle";

                using (SqlCommand userCmd = new SqlCommand(userQuery, conn))
                using (SqlCommand courseCmd = new SqlCommand(courseQuery, conn))
                {
                    try
                    {
                        conn.Open();
                        
                        // Populate Students Dropdown
                        using (SqlDataReader reader = userCmd.ExecuteReader())
                        {
                            ddlStudents.DataSource = reader;
                            ddlStudents.DataTextField = "DisplayName";
                            ddlStudents.DataValueField = "UID";
                            ddlStudents.DataBind();
                        }
                        ddlStudents.Items.Insert(0, new ListItem("-- Select Student --", ""));

                        // Populate Courses Dropdown
                        using (SqlDataReader reader = courseCmd.ExecuteReader())
                        {
                            ddlCourses.DataSource = reader;
                            ddlCourses.DataTextField = "CourseTitle";
                            ddlCourses.DataValueField = "CourseID";
                            ddlCourses.DataBind();
                        }
                        ddlCourses.Items.Insert(0, new ListItem("-- Select Course --", ""));
                    }
                    catch (Exception ex)
                    {
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        lblMessage.Text = $"Error loading drop-down options: {ex.Message}";
                    }
                }
            }
        }

        private void BindEnrollments(string searchTerm)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT e.EnrollmentID, u.Username, u.FirstName + ' ' + u.LastName AS StudentName, c.CourseTitle 
                    FROM Enrollments e 
                    INNER JOIN Users u ON e.UID = u.UID 
                    INNER JOIN Courses c ON e.CourseID = c.CourseID";

                if (!string.IsNullOrEmpty(searchTerm))
                {
                    query += @" WHERE u.Username LIKE @Search 
                               OR u.FirstName LIKE @Search 
                               OR u.LastName LIKE @Search 
                               OR c.CourseTitle LIKE @Search";
                }

                query += " ORDER BY e.EnrollmentID DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (!string.IsNullOrEmpty(searchTerm))
                    {
                        cmd.Parameters.AddWithValue("@Search", "%" + searchTerm + "%");
                    }

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        
                        if (dt.Rows.Count > 0)
                        {
                            gvEnrollments.DataSource = dt;
                            gvEnrollments.DataBind();
                            gvEnrollments.Visible = true;
                            phEmpty.Visible = false;
                        }
                        else
                        {
                            gvEnrollments.Visible = false;
                            phEmpty.Visible = true;
                        }
                    }
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindEnrollments(txtSearch.Text.Trim());
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindEnrollments(txtSearch.Text.Trim());
        }

        protected void btnEnroll_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            if (Page.IsValid)
            {
                int uid = Convert.ToInt32(ddlStudents.SelectedValue);
                int courseId = Convert.ToInt32(ddlCourses.SelectedValue);

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    // Check duplicate enrollment
                    string checkQuery = "SELECT COUNT(*) FROM Enrollments WHERE UID = @UID AND CourseID = @CourseID";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@UID", uid);
                        checkCmd.Parameters.AddWithValue("@CourseID", courseId);

                        try
                        {
                            conn.Open();
                            int exists = (int)checkCmd.ExecuteScalar();

                            if (exists > 0)
                            {
                                lblMessage.ForeColor = System.Drawing.Color.Red;
                                lblMessage.Text = "Student is already enrolled in this course.";
                                return;
                            }
                        }
                        catch (Exception ex)
                        {
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                            lblMessage.Text = $"Database error: {ex.Message}";
                            return;
                        }
                    }

                    // Insert enrollment record
                    string insertQuery = "INSERT INTO Enrollments (UID, CourseID) VALUES (@UID, @CourseID)";
                    using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                    {
                        insertCmd.Parameters.AddWithValue("@UID", uid);
                        insertCmd.Parameters.AddWithValue("@CourseID", courseId);

                        try
                        {
                            insertCmd.ExecuteNonQuery();

                            // Get course title and student username for notification
                            string detailsQuery = "SELECT CourseTitle, (SELECT Username FROM Users WHERE UID = @UID) AS Username FROM Courses WHERE CourseID = @CourseID";
                            string courseTitle = "";
                            string studentUsername = "";
                            using (SqlCommand detailsCmd = new SqlCommand(detailsQuery, conn))
                            {
                                detailsCmd.Parameters.AddWithValue("@UID", uid);
                                detailsCmd.Parameters.AddWithValue("@CourseID", courseId);
                                using (SqlDataReader reader = detailsCmd.ExecuteReader())
                                {
                                    if (reader.Read())
                                    {
                                        courseTitle = reader["CourseTitle"].ToString();
                                        studentUsername = reader["Username"].ToString();
                                    }
                                }
                            }

                            // Create notification for the student
                            if (!string.IsNullOrEmpty(studentUsername) && !string.IsNullOrEmpty(courseTitle))
                            {
                                string notifyQuery = "INSERT INTO Notifications (Username, Message, DateCreated, IsRead) VALUES (@Username, @Message, GETDATE(), 0)";
                                using (SqlCommand notifyCmd = new SqlCommand(notifyQuery, conn))
                                {
                                    notifyCmd.Parameters.AddWithValue("@Username", studentUsername);
                                    notifyCmd.Parameters.AddWithValue("@Message", $"You have been enrolled in the course: {courseTitle}.");
                                    notifyCmd.ExecuteNonQuery();
                                }
                            }

                            lblMessage.ForeColor = System.Drawing.Color.Green;
                            lblMessage.Text = "Student enrolled successfully!";
                            
                            // Reset selections
                            ddlStudents.SelectedIndex = 0;
                            ddlCourses.SelectedIndex = 0;

                            // Refresh Grid
                            BindEnrollments(txtSearch.Text.Trim());
                        }
                        catch (Exception ex)
                        {
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                            lblMessage.Text = $"Enrollment failed: {ex.Message}";
                        }
                    }
                }
            }
        }

        protected void gvEnrollments_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int enrollmentId = Convert.ToInt32(gvEnrollments.DataKeys[e.RowIndex].Value);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // Create unenrollment notification before deleting the record
                string studentDetailsQuery = "SELECT u.Username, c.CourseTitle FROM Enrollments e INNER JOIN Users u ON e.UID = u.UID INNER JOIN Courses c ON e.CourseID = c.CourseID WHERE e.EnrollmentID = @EnrollmentID";
                string studentUsername = "";
                string courseTitle = "";
                using (SqlCommand detailsCmd = new SqlCommand(studentDetailsQuery, conn))
                {
                    detailsCmd.Parameters.AddWithValue("@EnrollmentID", enrollmentId);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = detailsCmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                studentUsername = reader["Username"].ToString();
                                courseTitle = reader["CourseTitle"].ToString();
                            }
                        }
                    }
                    catch { }
                }

                // Delete enrollment query
                string query = "DELETE FROM Enrollments WHERE EnrollmentID = @EnrollmentID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@EnrollmentID", enrollmentId);

                    try
                    {
                        if (conn.State == ConnectionState.Closed) conn.Open();
                        cmd.ExecuteNonQuery();

                        // Create notification for unenrollment
                        if (!string.IsNullOrEmpty(studentUsername) && !string.IsNullOrEmpty(courseTitle))
                        {
                            string notifyQuery = "INSERT INTO Notifications (Username, Message, DateCreated, IsRead) VALUES (@Username, @Message, GETDATE(), 0)";
                            using (SqlCommand notifyCmd = new SqlCommand(notifyQuery, conn))
                            {
                                notifyCmd.Parameters.AddWithValue("@Username", studentUsername);
                                notifyCmd.Parameters.AddWithValue("@Message", $"You have been unenrolled from the course: {courseTitle}.");
                                notifyCmd.ExecuteNonQuery();
                            }
                        }

                        lblMessage.ForeColor = System.Drawing.Color.Green;
                        lblMessage.Text = "Enrollment removed successfully.";
                        
                        BindEnrollments(txtSearch.Text.Trim());
                    }
                    catch (Exception ex)
                    {
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        lblMessage.Text = $"Failed to remove enrollment: {ex.Message}";
                    }
                }
            }
        }

        protected void btnback_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminDashboard.aspx");
        }
    }
}
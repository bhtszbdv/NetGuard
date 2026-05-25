using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Web_Development_Assignment
{
    public partial class CourseManagement : System.Web.UI.Page
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
                string query = "SELECT CourseID, CourseTitle, CourseDescription, CourseImage, IsPublic FROM Courses ORDER BY CourseID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvCourses.DataSource = dt;
                        gvCourses.DataBind();
                    }
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminDashboard.aspx");
        }

        protected void btnAddCourse_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtAddTitle.Text))
            {
                ShowMessage("Course Title is required.", false);
                return;
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "INSERT INTO Courses (CourseTitle, CourseDescription, CourseImage, IsPublic) VALUES (@CourseTitle, @CourseDescription, @CourseImage, @IsPublic)";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CourseTitle", txtAddTitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@CourseDescription", txtAddDescription.Text.Trim());
                    cmd.Parameters.AddWithValue("@CourseImage", txtAddImage.Text.Trim());
                    cmd.Parameters.AddWithValue("@IsPublic", ddlAddIsPublic.SelectedValue);

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        ShowMessage("Course added successfully!", true);
                        
                        // Clear fields
                        txtAddTitle.Text = "";
                        txtAddDescription.Text = "";
                        txtAddImage.Text = "";
                        
                        BindGrid();
                    }
                    catch (Exception ex)
                    {
                        ShowMessage("Error adding course: " + ex.Message, false);
                    }
                }
            }
        }

        protected void gvCourses_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCourses.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void gvCourses_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCourses.EditIndex = -1;
            BindGrid();
        }

        protected void gvCourses_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int courseId = Convert.ToInt32(gvCourses.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvCourses.Rows[e.RowIndex];

            string title = (row.Cells[1].Controls[0] as TextBox).Text;
            string description = (row.Cells[2].Controls[0] as TextBox).Text;
            string image = (row.Cells[3].Controls[0] as TextBox).Text;
            string isPublic = (row.FindControl("ddlEditIsPublic") as DropDownList).SelectedValue;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "UPDATE Courses SET CourseTitle = @CourseTitle, CourseDescription = @CourseDescription, CourseImage = @CourseImage, IsPublic = @IsPublic WHERE CourseID = @CourseID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CourseID", courseId);
                    cmd.Parameters.AddWithValue("@CourseTitle", title);
                    cmd.Parameters.AddWithValue("@CourseDescription", description);
                    cmd.Parameters.AddWithValue("@CourseImage", image);
                    cmd.Parameters.AddWithValue("@IsPublic", isPublic);

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        
                        gvCourses.EditIndex = -1;
                        BindGrid();
                        ShowMessage("Course updated successfully!", true);
                    }
                    catch (Exception ex)
                    {
                        ShowMessage("Error updating course: " + ex.Message, false);
                    }
                }
            }
        }

        protected void gvCourses_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int courseId = Convert.ToInt32(gvCourses.DataKeys[e.RowIndex].Value);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    
                    // Same safe-guard for courses. A course cannot be deleted easily if it has enrollments, discussions, resources.
                    string query = "DELETE FROM Courses WHERE CourseID = @CourseID";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@CourseID", courseId);
                        cmd.ExecuteNonQuery();
                    }
                    
                    BindGrid();
                    ShowMessage("Course deleted successfully!", true);
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 547) // Foreign Key violation
                    {
                        ShowMessage("Cannot delete this course because it has active enrollments, resources, or discussions.", false);
                    }
                    else
                    {
                        ShowMessage("Error deleting course: " + ex.Message, false);
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
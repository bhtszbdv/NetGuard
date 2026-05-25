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
    public partial class FAQ : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set default filter to All
                ViewState["CategoryFilter"] = "All";
                BindFAQs("All");

                // Show Admin Panel if UserType is Admin
                if (Session["UserType"] != null && Session["UserType"].ToString() == "Admin")
                {
                    pnlAdmin.Visible = true;
                }
            }
        }

        private void BindFAQs(string category)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM FAQs";
                if (category != "All")
                {
                    query += " WHERE Category = @Category";
                }
                query += " ORDER BY Category, FAQID DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (category != "All")
                    {
                        cmd.Parameters.AddWithValue("@Category", category);
                    }

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        rptFAQs.DataSource = dt;
                        rptFAQs.DataBind();
                    }
                }
            }
        }

        protected void Filter_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string category = btn.CommandArgument;
            ViewState["CategoryFilter"] = category;

            // Reset active CSS class on all buttons
            btnAll.CssClass = "category-btn";
            btnGeneral.CssClass = "category-btn";
            btnCourses.CssClass = "category-btn";
            btnAccount.CssClass = "category-btn";
            btnDiscussions.CssClass = "category-btn";
            btnLabs.CssClass = "category-btn";

            // Set active class to current button
            btn.CssClass = "category-btn active";

            BindFAQs(category);
        }

        protected void rptFAQs_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int faqId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Edit")
            {
                LoadFaqForEdit(faqId);
            }
            else if (e.CommandName == "Delete")
            {
                DeleteFaq(faqId);
            }
        }

        private void LoadFaqForEdit(int faqId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM FAQs WHERE FAQID = @FAQID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@FAQID", faqId);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                hfFaqId.Value = reader["FAQID"].ToString();
                                txtQuestion.Text = reader["Question"].ToString();
                                txtAnswer.Text = reader["Answer"].ToString();
                                ddlCategory.SelectedValue = reader["Category"].ToString();

                                adminTitle.InnerText = "Edit FAQ";
                                btnSaveFAQ.Text = "Update FAQ";
                                btnCancelFAQ.Visible = true;
                                
                                // Scroll to admin panel
                                ClientScript.RegisterStartupScript(this.GetType(), "scroll", "window.scrollTo(0, document.body.scrollHeight);", true);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Write($"<script>alert('Error loading FAQ: {ex.Message}');</script>");
                    }
                }
            }
        }

        private void DeleteFaq(int faqId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "DELETE FROM FAQs WHERE FAQID = @FAQID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@FAQID", faqId);
                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        
                        // Rebind FAQs
                        string currentFilter = ViewState["CategoryFilter"] != null ? ViewState["CategoryFilter"].ToString() : "All";
                        BindFAQs(currentFilter);
                        
                        Response.Write("<script>alert('FAQ deleted successfully.');</script>");
                    }
                    catch (Exception ex)
                    {
                        Response.Write($"<script>alert('Error deleting FAQ: {ex.Message}');</script>");
                    }
                }
            }
        }

        protected void btnSaveFAQ_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string category = ddlCategory.SelectedValue;
                string question = txtQuestion.Text.Trim();
                string answer = txtAnswer.Text.Trim();
                string faqIdStr = hfFaqId.Value;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query;
                    bool isUpdate = !string.IsNullOrEmpty(faqIdStr);

                    if (isUpdate)
                    {
                        query = "UPDATE FAQs SET Question = @Question, Answer = @Answer, Category = @Category WHERE FAQID = @FAQID";
                    }
                    else
                    {
                        query = "INSERT INTO FAQs (Question, Answer, Category) VALUES (@Question, @Answer, @Category)";
                    }

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Question", question);
                        cmd.Parameters.AddWithValue("@Answer", answer);
                        cmd.Parameters.AddWithValue("@Category", category);

                        if (isUpdate)
                        {
                            cmd.Parameters.AddWithValue("@FAQID", Convert.ToInt32(faqIdStr));
                        }

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();

                            // Reset form
                            ResetAdminForm();

                            // Rebind FAQs
                            string currentFilter = ViewState["CategoryFilter"] != null ? ViewState["CategoryFilter"].ToString() : "All";
                            BindFAQs(currentFilter);

                            Response.Write($"<script>alert('FAQ {(isUpdate ? "updated" : "added")} successfully.');</script>");
                        }
                        catch (Exception ex)
                        {
                            Response.Write($"<script>alert('Error saving FAQ: {ex.Message}');</script>");
                        }
                    }
                }
            }
        }

        protected void btnCancelFAQ_Click(object sender, EventArgs e)
        {
            ResetAdminForm();
        }

        private void ResetAdminForm()
        {
            hfFaqId.Value = "";
            txtQuestion.Text = "";
            txtAnswer.Text = "";
            ddlCategory.SelectedIndex = 0;
            adminTitle.InnerText = "Add New FAQ (Administrator Panel)";
            btnSaveFAQ.Text = "Save FAQ";
            btnCancelFAQ.Visible = false;
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
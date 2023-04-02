using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace WebApplication1
{
    public partial class RemPersonnel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            WelcomeHeader.InnerText = "Welcome, Administrator!";
        }
        protected void SUBMIT_Click_RemPer(object sender, EventArgs e)
        {
            string connString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
            MySqlConnection connection = new MySqlConnection(connString);

            connection.Open();

            try
            {
                //  remove a Personnel
                if (DropDownList2.SelectedValue == "Doctor")
                {
                    string sql = "DELETE FROM doctor WHERE DoctorID = @ID";
                    MySqlCommand command = new MySqlCommand(sql, connection);
                    command.Parameters.AddWithValue("@ID", perID.Text);
                    command.ExecuteNonQuery();
                }
                if (DropDownList2.SelectedValue == "Nurse")
                {
                    string sql = "DELETE FROM nurse WHERE NID = @ID";
                    MySqlCommand command = new MySqlCommand(sql, connection);
                    command.Parameters.AddWithValue("@ID", perID.Text);
                    command.ExecuteNonQuery();
                }
                if (DropDownList2.SelectedValue == "Staff")
                {
                    string sql = "DELETE FROM office WHERE StaffID = @ID";
                    MySqlCommand command = new MySqlCommand(sql, connection);
                    command.Parameters.AddWithValue("@ID", perID.Text);
                    command.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error: " + ex.Message + '\n');
            }

            connection.Close();
        }
        protected void ButtonClear_Click(object sender, EventArgs e)
        {
            perID.Text = "";
        }
        protected void ButtonExit_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminView.aspx?AdminID=");//doesn't have + adminId in url
        }
        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
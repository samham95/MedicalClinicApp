using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace WebApplication1
{
    public partial class RemOffice : System.Web.UI.Page
    {

        private string adminID;
        protected void Page_Load(object sender, EventArgs e)
        {
            adminID = Request.QueryString["adminID"];
        }
        protected void SUBMIT_Click_RemOff(object sender, EventArgs e)
        {
            string connString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
            MySqlConnection connection = new MySqlConnection(connString);

            connection.Open();

            try
            {

                string query = "SELECT officeAddress from office WHERE officeID = @address";
                MySqlCommand cmd = new MySqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@address", Convert.ToInt32(id.Text));
                object result = cmd.ExecuteScalar();
                string outcome = result.ToString();
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('DELETED office located at " + outcome + "');", true);

                //  remove a office
                string sql = "DELETE FROM office WHERE officeID = @address";
                MySqlCommand command = new MySqlCommand(sql, connection);
                command.Parameters.AddWithValue("@address", Convert.ToInt32(id.Text));
                command.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Unable to delete - office does not exist');", true);
            }

            connection.Close();
        }
        protected void ButtonClear_Click(object sender, EventArgs e)
        {
            id.Text = "";
        }
        protected void ButtonExit_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminView.aspx?adminID=" + adminID);
        }
        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
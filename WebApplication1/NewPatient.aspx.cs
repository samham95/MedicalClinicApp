using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace WebApplication1
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            dob.Attributes.Add("placeholder", "yyyy-mm-dd");
            dob.Attributes.Add("type", "date");
            dob.Attributes.Add("onkeydown", "return false");

            if (!IsPostBack)
            {
                // Create a list to hold the time slots
                List<string> timeSlots = new List<string>();

                // Add the time slots to the list
                DateTime startTime = DateTime.Parse("8:00 AM");
                DateTime endTime = DateTime.Parse("6:00 PM");
                while (startTime <= endTime)
                {
                    timeSlots.Add(startTime.ToString("h:mm tt"));
                    startTime = startTime.AddMinutes(30);
                }

                // Bind the list to the dropdown list
                ddlTimeRequested.DataSource = timeSlots;
                ddlTimeRequested.DataBind();
            }
        }

        protected void SUBMIT_Click(object sender, EventArgs e)

        {

            string connString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb;Uid=dbadmin;Pwd=Medical123!;";
            MySqlConnection connection = new MySqlConnection(connString);
            string pcp_name = pcp.Text;

            try
            {
                connection.Open();

                // Get doctorID for selceted PCP for new patient
                string[] names = pcp_name.Split(' ');
                string fname_pcp = names[0];
                string lname_pcp = names[1];

                string query = "SELECT doctorID FROM doctor WHERE lname=@pcp_2 and fname=@pcp_1";
                MySqlCommand cmd = new MySqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@pcp_1", lname_pcp);
                cmd.Parameters.AddWithValue("@pcp_2", fname_pcp);

                MySqlDataReader reader = cmd.ExecuteReader();
                reader.Read();
                string doctorID = reader["doctorID"].ToString();
                reader.Close();
                string sql = "INSERT INTO patients (fname, Mintial, lname, dob, phone_num, email, Address, doctorID) VALUES (@fname, @lname, @Minitial, @dob, @phone_num, @email, @Address)";
                MySqlCommand command = new MySqlCommand(sql, connection);

                command.Parameters.AddWithValue("@fname", fname.Text);
                command.Parameters.AddWithValue("@Minitial", mi.Text);
                command.Parameters.AddWithValue("@lname", lname.Text);
                command.Parameters.AddWithValue("@dob", dob.Text);
                command.Parameters.AddWithValue("@phone_num", phone_num.Text);
                command.Parameters.AddWithValue("@email", email.Text);
                command.Parameters.AddWithValue("@Address", address.Text);
                command.Parameters.AddWithValue("@doctorID", doctorID);
                command.Parameters.AddWithValue("@Address", address.Text);

                command.ExecuteNonQuery();

                connection.Close();
                string email_in = email.Text;
                Response.Redirect("success.aspx?email=" + email_in);
            }
            catch (Exception ex)
            {
                //Response.Redirect("unsuccessful.aspx");
               Response.Write("Error: " + ex.ToString() + pcp_name);
            }
        }

        protected void mySQL_azure_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace WebApplication1
{
    public partial class PatAppEditaspx : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            string patientID = (Request.QueryString["patientID"]).ToString();
            HyperLink1.NavigateUrl = "PatientPortal.aspx?patientID=" + patientID;
        }

        protected void SUBMIT_Click(object sender, EventArgs e)
        {
            string connString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
            MySqlConnection connection = new MySqlConnection(connString);
            string sql = "UPDATE patients where patientID = @patientID SET fname = @fname AND Minitial= @Minitial AND lname= @lname AND dob= @dob AND phone_num = @phone_num AND email = @email AND Address = @Address";
            MySqlCommand command = new MySqlCommand(sql, connection);
            int patID = Convert.ToInt32(Request.QueryString["patientID"]);


            command.Parameters.AddWithValue("@fname", fname.Text);
            command.Parameters.AddWithValue("@Minitial", mi.Text);
            command.Parameters.AddWithValue("@lname", lname.Text);
            command.Parameters.AddWithValue("@dob", dob.Text);
            command.Parameters.AddWithValue("@phone_num", phone_num.Text);
            command.Parameters.AddWithValue("@email", email.Text);
            command.Parameters.AddWithValue("@patientID", patID);
            command.Parameters.AddWithValue("@Address", address.Text);

            Response.Redirect("PatientPortal.aspx?patientID=" + patID.ToString());
        }
    }
}
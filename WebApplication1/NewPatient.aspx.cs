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

                // populate office locations
                string connString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb;Uid=dbadmin;Pwd=Medical123!;";
                string query = "SELECT officeAddress from office";
                MySqlConnection connection = new MySqlConnection(connString);
                MySqlCommand command = new MySqlCommand(query, connection);
                connection.Open();
                MySqlDataReader reader = command.ExecuteReader();
                List<string> officelocs = new List<string>();
                officelocs.Add("");
                while (reader.Read())
                {
                    officelocs.Add(reader["officeAddress"].ToString());

                }
                DropDownList1.DataSource = officelocs;
                DropDownList1.DataBind();
                reader.Close();
                connection.Close();
                DropDownList1.SelectedIndex = 0;

            }
        }

        protected void SUBMIT_Click(object sender, EventArgs e)

        {

            string connString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb;Uid=dbadmin;Pwd=Medical123!;";
            MySqlConnection connection = new MySqlConnection(connString);
            string pcp_name = primary.SelectedValue;
            bool hasReferral = CheckBox5.Checked;

            connection.Open();

            // Get doctorID for selceted PCP for new patient
            string query = "SELECT doctorID FROM doctor WHERE CONCAT(fname, ' ', lname) = @selectedPCP";
            MySqlCommand cmd = new MySqlCommand(query, connection);
            cmd.Parameters.AddWithValue("@selectedPCP", pcp_name);
            object result = cmd.ExecuteScalar();
            int doctorID = Convert.ToInt32(result);


            try
            {
                // Inset new patient data
                string sql = "INSERT INTO patients (fname, Minitial, lname, dob, phone_num, email, Address, doctorID, referral) VALUES (@fname, @Minitial, @lname, @dob, @phone_num, @email, @Address, @doctorID, @referral)";
                MySqlCommand command = new MySqlCommand(sql, connection);

                command.Parameters.AddWithValue("@fname", fname.Text);
                command.Parameters.AddWithValue("@Minitial", mi.Text);
                command.Parameters.AddWithValue("@lname", lname.Text);
                command.Parameters.AddWithValue("@dob", dob.Text);
                command.Parameters.AddWithValue("@phone_num", phone_num.Text);
                command.Parameters.AddWithValue("@email", email.Text);
                command.Parameters.AddWithValue("@Address", address.Text);
                command.Parameters.AddWithValue("@doctorID", doctorID);
                command.Parameters.AddWithValue("@referral", hasReferral);

                command.ExecuteNonQuery();

 
                // Get PatientID & officeID
                string query_pid = "SELECT patientID FROM patients WHERE fname=@fname AND lname=@lname AND Minitial=@Minitial AND email=@email AND phone_num=@phone_num";
                string query_oid = "SELECT officeID FROM office WHERE officeAddress = @OfficeAddress";

                MySqlCommand cmmd = new MySqlCommand(query_pid, connection);
                cmmd.Parameters.AddWithValue("@fname", fname.Text);
                cmmd.Parameters.AddWithValue("@Minitial", mi.Text);
                cmmd.Parameters.AddWithValue("@lname", lname.Text);
                cmmd.Parameters.AddWithValue("@phone_num", phone_num.Text);
                cmmd.Parameters.AddWithValue("@email", email.Text);
                MySqlDataReader reader = cmmd.ExecuteReader();
                reader.Read();
                string patientID = reader["patientID"].ToString();
                reader.Close();

                MySqlCommand cmd_oid = new MySqlCommand(query_oid, connection);
                cmd_oid.Parameters.AddWithValue("@OfficeAddress", DropDownList1.SelectedValue);
                Object reader2 = cmd_oid.ExecuteScalar();
                int officeID = Convert.ToInt32(reader2);

                //insert appointment with PCP
                string insert_app = "INSERT INTO appointment (doctorID, patientID, officeID, appointmentDate) VALUES (@doctorID, @patientID,@officeID,@date)";
                MySqlCommand cmd2 = new MySqlCommand(insert_app, connection);
                cmd2.Parameters.AddWithValue("@doctorID", doctorID);
                cmd2.Parameters.AddWithValue("@patientID", patientID);
                cmd2.Parameters.AddWithValue("@officeID", officeID);
                cmd2.Parameters.AddWithValue("@date", date_requested.Text);
                cmd2.ExecuteNonQuery();
                connection.Close();

                //Redirect
                Response.Redirect("success.aspx?patientID=" + patientID);

            }
            catch (Exception ex)
            {
               //Response.Redirect("unsuccessful.aspx");
               Response.Write("Error: " + ex.Message + '\n' + result);
            }

            connection.Close();
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string officeAddress = DropDownList1.SelectedValue;
            // Query the database to get the primary care physicians for the selected office
            string connString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb;Uid=dbadmin;Pwd=Medical123!;";
            string query = "SELECT DISTINCT CONCAT(doctor.fname, ' ', doctor.lname) AS fullname FROM doctor,office,schedule WHERE doctor.doctorID=schedule.doctor AND office.officeAddress = @OfficeAddress AND (Monday = officeID OR Tuesday = officeID OR Wednesday = officeID OR Thursday = officeID OR Friday = officeID)";
            MySqlConnection connection = new MySqlConnection(connString);
            MySqlCommand command = new MySqlCommand(query, connection);
            command.Parameters.AddWithValue("@officeAddress", officeAddress);
            connection.Open();
            MySqlDataReader reader = command.ExecuteReader();

            // Create a list to hold the primary care physician names for the selected office
            List<string> PCPs = new List<string>();
            reader.Read();
            if (reader.HasRows)
            {
                PCPs.Add(reader["fullname"].ToString());
                // Loop through the records and add the primary care physician names to the list
                while (reader.Read())
                {
                    string pcp_name = reader["fullname"].ToString();
                    PCPs.Add(pcp_name);
                }

                // Bind the primary care physician names to the dropdown list
                primary.Items.Clear();
                primary.DataSource = PCPs;
                primary.DataBind();
            }
            else { primary.Items.Clear(); }
            reader.Close();
            connection.Close();
        }

        protected void primary_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
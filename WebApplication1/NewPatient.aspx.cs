using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Globalization;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace WebApplication1
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)

        {
            // check if selected appointment available
            if (IsPostBack)
            {
                ErrorMessage_date2.Text = "";
                string connString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
                MySqlConnection connection = new MySqlConnection(connString);
                string query = "SELECT * FROM appointment, doctor WHERE appointmentDate = @AppDate AND appointmentTime = @AppTime AND CONCAT(doctor.fname, ' ', doctor.lname) = @fullname AND appointment.doctorID = doctor.doctorID";

                MySqlCommand command = new MySqlCommand(query, connection);

                string AppDate = date_requested.Text;
                string AppTime = ddlTimeRequested.SelectedValue.ToString();
                string fullname = primary.SelectedValue;
                if (AppTime != "")
                {
                    DateTime dateTime = DateTime.ParseExact(AppTime, "h:mm tt", CultureInfo.InvariantCulture);
                    AppTime = dateTime.ToString("hh:mm");
                }
      
                command.Parameters.AddWithValue("@AppDate", AppDate);
                command.Parameters.AddWithValue("@AppTime", AppTime);
                command.Parameters.AddWithValue("@fullname", fullname);
                connection.Open();
                DateTime currentDate = DateTime.Now;

                    try
                    {
                        MySqlDataReader reader = command.ExecuteReader();
                        reader.Read();
                    if (fullname != "" && AppTime != "" && AppDate != "" && DropDownList1.SelectedValue != "" && date_requested.Text != "")
                    {
                        DateTime selected_date = DateTime.Parse(AppDate);

                            if (currentDate > selected_date || selected_date.DayOfWeek.ToString() == "Saturday" || selected_date.DayOfWeek.ToString() == "Sunday")
                            {
                                ErrorMessage_date.Text = "";
                                ErrorMessage_date2.Text = "Invalid Date";
                            }
                            
                            else if (reader.HasRows)
                            {
                                ErrorMessage_date.Text = "Appointment Unavailable. Please make different selection!";
                            }
                            else
                            {
                                ErrorMessage_date.Text = "Appointment Available!";
                            }
                        }
                        else
                        {
                            ErrorMessage_date.Text = "Please make sure to complete all preceeding selections";
                        }
                    }

                    catch (Exception)
                    {
                        ErrorMessage_date.Text = "Please make sure to complete all preceeding selections";
                    }

                // scroll to appointment section on post back
                ScriptManager.RegisterStartupScript(this, GetType(), "scrollToBottom", "window.scrollTo(0, document.body.scrollHeight/2);", true);
            }


            if (!IsPostBack)
            {

                // Create a list to hold the time slots
                List<string> timeSlots = new List<string>();
                timeSlots.Add("");
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
                ddlTimeRequested.SelectedIndex = 0;

                // populate office locations
                string connString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
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


            dob.Attributes.Add("placeholder", "yyyy-mm-dd");
            dob.Attributes.Add("type", "date");
            dob.Attributes.Add("onkeydown", "return false");

        }

        protected void SUBMIT_Click(object sender, EventArgs e)

        {

            string connString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
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
                string time_selected = ddlTimeRequested.SelectedValue.ToString();
                DateTime dateTime = DateTime.ParseExact(time_selected, "h:mm tt", CultureInfo.InvariantCulture);
                string time = dateTime.ToString("hh:mm");

                string insert_app = "INSERT INTO appointment (doctorID, patientID, officeID, appointmentDate, appointmentTime) VALUES (@doctorID, @patientID,@officeID,@date,@time)";
                MySqlCommand cmd2 = new MySqlCommand(insert_app, connection);
                cmd2.Parameters.AddWithValue("@doctorID", doctorID);
                cmd2.Parameters.AddWithValue("@patientID", patientID);
                cmd2.Parameters.AddWithValue("@officeID", officeID);
                cmd2.Parameters.AddWithValue("@date", date_requested.Text);
                cmd2.Parameters.AddWithValue("@time", time);

                cmd2.ExecuteNonQuery();


                // insert emergency contact details
                
                string insert_EC = "INSERT INTO emergency_contact_patient(fullname, Relation, phone_num, email, patientID) values (@fname, @relation, @phone, @email, @patientID)";
                MySqlCommand cmd3 = new MySqlCommand(insert_EC, connection);
                cmd3.Parameters.AddWithValue("@fname", emergency_contact.Text);
                cmd3.Parameters.AddWithValue("@relation", ECRelation.Text);
                cmd3.Parameters.AddWithValue("@phone", ECphone.Text);
                cmd3.Parameters.AddWithValue("@email", ECemail.Text);
                cmd3.Parameters.AddWithValue("@patientID", patientID);

                cmd3.ExecuteNonQuery();

                connection.Close();

                //Redirect
                Response.Redirect("success.aspx?patientID=" + patientID);

            }
            catch (Exception ex)
            {
                //Response.Redirect("unsuccessful.aspx");
                Response.Write("Error: " + ex.Message + '\n');
            }

            connection.Close();
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string officeAddress = DropDownList1.SelectedValue;
            // Query the database to get the primary care physicians for the selected office
            string connString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
            string query = "SELECT DISTINCT CONCAT(doctor.fname, ' ', doctor.lname) AS fullname FROM doctor,office,schedule WHERE doctor.doctorID=schedule.doctor AND doctor.specialty = 'PCP' AND office.officeAddress = @OfficeAddress AND (Monday = officeID OR Tuesday = officeID OR Wednesday = officeID OR Thursday = officeID OR Friday = officeID)";
            MySqlConnection connection = new MySqlConnection(connString);
            MySqlCommand command = new MySqlCommand(query, connection);
            command.Parameters.AddWithValue("@officeAddress", officeAddress);
            connection.Open();
            MySqlDataReader reader = command.ExecuteReader();

            // Create a list to hold the primary care physician names for the selected office
            List<string> PCPs = new List<string>();
            PCPs.Add("");
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
                primary.SelectedIndex = 0;
            }
            else { primary.Items.Clear(); }
            reader.Close();
            connection.Close();
        }
    }
}
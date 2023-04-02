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
    public partial class NewAppointment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            date_requested.Attributes.Add("placeholder", "yyyy-mm-dd");
            date_requested.Attributes.Add("type", "date");
            date_requested.Attributes.Add("onkeydown", "return false");
            if (IsPostBack)
            {
                if (IsPostBack)
                {
                    string connString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
                    MySqlConnection connection = new MySqlConnection(connString);
                    string query = "SELECT * FROM appointment, doctor WHERE appointmentDate = @AppDate AND appointmentTime = @AppTime AND CONCAT(doctor.fname, ' ', doctor.lname) = @fullname AND appointment.doctorID = doctor.doctorID";

                    MySqlCommand command = new MySqlCommand(query, connection);

                    string AppDate = date_requested.Text;
                    string time_selected = ddlTimeRequested.SelectedValue.ToString();
                    string AppTime = time_selected;
                    string fullname = specialist.SelectedValue;
                    if (time_selected != "")
                    {
                        DateTime dateTime = DateTime.ParseExact(time_selected, "h:mm tt", CultureInfo.InvariantCulture);
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
                        if (fullname != "" && AppTime != "" && AppDate != "" && DropDownList1.SelectedValue != "" && date_requested.Text !="" && specdept.SelectedValue != "")
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
                }
            }
            if (!IsPostBack)
            {

                // Create a list to hold the time slots
                List<string> timeSlots = new List<string>();

                // Add the time slots to the list
                DateTime startTime = DateTime.Parse("8:00 AM");
                DateTime endTime = DateTime.Parse("6:00 PM");
                timeSlots.Add("");
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
        }

        protected void SUBMIT_Click(object sender, EventArgs e)
        {
            string connString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
            MySqlConnection connection = new MySqlConnection(connString);

            connection.Open();

            // Get doctorID for selceted specialist for patient
            string query = "SELECT doctorID FROM doctor WHERE CONCAT(fname, ' ', lname) = @spec";
            MySqlCommand cmd = new MySqlCommand(query, connection);
            cmd.Parameters.AddWithValue("@spec", specialist.SelectedValue.ToString());
            object result = cmd.ExecuteScalar();
            int doctorID = Convert.ToInt32(result);
            bool hasReferral = CheckBox5.Checked;

            //get patientID from url
            int patientID = Convert.ToInt32(Request.QueryString["patientID"]);

            // Get officeID
            string query_oid = "SELECT officeID FROM office WHERE officeAddress = @OfficeAddress";
            MySqlCommand cmd_oid = new MySqlCommand(query_oid, connection);
            cmd_oid.Parameters.AddWithValue("@OfficeAddress", DropDownList1.SelectedValue);
            Object reader = cmd_oid.ExecuteScalar();
            int officeID = Convert.ToInt32(reader);

            try
            {
                //insert appointment with specialist
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
            }
            catch (Exception ex)
            {
                Response.Redirect("unsuccessful.aspx?patientID=" + patientID);
            }
            connection.Close();
            Response.Redirect("NewAppSuccess.aspx?patientID=" + patientID);
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string officeAddress = DropDownList1.SelectedValue;
            string specialty = specdept.SelectedValue;
            // Query the database to get the physicians for the selected office
            string connString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
            string query = "SELECT DISTINCT CONCAT(doctor.fname, ' ', doctor.lname) AS fullname FROM doctor,office,schedule WHERE doctor.doctorID=schedule.doctor AND doctor.specialty = @spec AND office.officeAddress = @OfficeAddress AND (Monday = officeID OR Tuesday = officeID OR Wednesday = officeID OR Thursday = officeID OR Friday = officeID)";
            MySqlConnection connection = new MySqlConnection(connString);
            MySqlCommand command = new MySqlCommand(query, connection);
            command.Parameters.AddWithValue("@officeAddress", officeAddress);
            command.Parameters.AddWithValue("@spec", specialty);
            connection.Open();
            MySqlDataReader reader = command.ExecuteReader();

            // Create a list to hold the physician names for the selected office
            List<string> Specs = new List<string>();
            Specs.Add("");
            reader.Read();
            if (reader.HasRows)
            {
                Specs.Add(reader["fullname"].ToString());
                // Loop through the records and add the physician names to the list
                while (reader.Read())
                {
                    string pcp_name = reader["fullname"].ToString();
                    Specs.Add(pcp_name);
                }

                // Bind the specialist physician names to the dropdown list
                specialist.Items.Clear();
                specialist.DataSource = Specs;
                specialist.DataBind();
                specialist.SelectedIndex = 0;
            }
            else { specialist.Items.Clear(); }
            reader.Close();
            connection.Close();
        }

        protected void date_requested_TextChanged(object sender, EventArgs e)
        {

        }

        protected void specdept_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList1.SelectedIndex = 0;
            specialist.SelectedIndex = 0;
        }

        protected void Return_Click(object sender, EventArgs e)
        {
            int patientID = Convert.ToInt32(Request.QueryString["patientID"]);
            Response.Redirect("PatientPortal.aspx?patientID=" + patientID);
        }
    }
}
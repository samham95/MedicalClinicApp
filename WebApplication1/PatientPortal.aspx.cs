using System;
using System.Configuration;
using System.Data;
using MySql.Data.MySqlClient;
using System.Net;
using System.Net.Mail;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class WebForm7 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }

            int patientID = Convert.ToInt32(Request.QueryString["patientID"]);
            HyperLink1.NavigateUrl = "PatEdit.aspx?patientID=" + patientID.ToString();

            // Post Welcome Message for Specific Patient
            string connectionString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
            MySqlConnection connection = new MySqlConnection(connectionString);
            string query = "SELECT CONCAT(fname, ' ', lname) from patients WHERE patientID = @patientID";
            MySqlCommand cmd = new MySqlCommand(query, connection);
            cmd.Parameters.AddWithValue("patientID", patientID);
            connection.Open();
            object result = cmd.ExecuteScalar();
            string fullname = result.ToString();
            welcomeHeader.InnerText = "Welcome, " + fullname;
        }

        protected void BindData()
        {
            int patientID = Convert.ToInt32(Request.QueryString["patientID"]);
            DataTable dt = new DataTable();

            // Retrieve data from database into appointment grid
            string connectionString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
            string query = "SELECT CONCAT(doctor.fname, ' ', doctor.lname) as DoctorName, office.officeAddress as OfficeLocation, appointment.appointmentID as appointmentID, appointment.approval as Approval, appointmentTime as Time, appointmentDate as Date, PATIENT_CONFIRM as Confirm, doctor.specialty as SPEC FROM appointment, doctor, office WHERE appointment.patientID = @patientID AND appointment.doctorID = doctor.doctorID AND appointment.officeID = office.officeID";
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                using (MySqlCommand command = new MySqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@PatientID", patientID);
                    connection.Open();
                    using (MySqlDataAdapter adapter = new MySqlDataAdapter(command))
                    {
                        adapter.Fill(dt);
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                    connection.Close();
                }
            }
        }


        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ConfirmAppointment")
            {
                int appointmentID = Convert.ToInt32(GridView1.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text);

                // Get patient email
                string email_query = "SELECT email FROM patients, appointment WHERE appointment.appointmentID = @apid AND appointment.patientID = patients.patientID";
                string connString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
                MySqlConnection connect = new MySqlConnection(connString);
                connect.Open();
                MySqlCommand cmd = new MySqlCommand(email_query, connect);
                cmd.Parameters.AddWithValue("@apid", appointmentID);
                MySqlDataReader reader = cmd.ExecuteReader();
                reader.Read();
                if (reader.HasRows)
                {
                    string email = reader["email"].ToString();
                    reader.Close();
                    connect.Close();

                    // Update approval status in database
                    string query = "UPDATE appointment SET PATIENT_CONFIRM = @CONFIRM WHERE appointmentID = @ID";
                    using (MySqlConnection connection = new MySqlConnection(connString))
                    {
                        using (MySqlCommand command = new MySqlCommand(query, connection))
                        {
                            command.Parameters.AddWithValue("@CONFIRM", true);
                            command.Parameters.AddWithValue("@ID", appointmentID);
                            connection.Open();
                            int rowsAffected = command.ExecuteNonQuery();
                            connection.Close();

                            if (rowsAffected > 0)
                            {
                                // Send confirmation email to patient
                                MailMessage mail = new MailMessage();
                                mail.To.Add(email);
                                mail.Subject = "Appointment Confirmed";
                                mail.Body = "You have successfully confirmed your appointment. We look forward to seeing you!";
                                SmtpClient smtp = new SmtpClient();
                                smtp.Send(mail);

                                // Refresh data grid
                                BindData();
                            }
                        }
                    }
                }
                else
                {
                    Response.Write(appointmentID);
                }
            }
            else if (e.CommandName == "EditAppointment")
            {
                int appointmentID = Convert.ToInt32(GridView1.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text);
                Response.Redirect("PatientEditApp.aspx?appointmentID=" + appointmentID);
            }
        }
    }
}
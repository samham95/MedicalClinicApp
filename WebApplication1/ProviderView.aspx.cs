using System;
using System.Configuration;
using System.Data;
using MySql.Data.MySqlClient;
using System.Net;
using System.Net.Mail;
using System.Web.UI.WebControls;
using System.Windows.Forms;
using static System.Web.UI.ScriptManager;

namespace WebApplication1
{
    public partial class ProviderView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }

            // Get Doctor Name for Welcome Header
            int doctorID =Convert.ToInt32 (Request.QueryString["doctorID"]);
            string connectionString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
            MySqlConnection connection = new MySqlConnection(connectionString);
            string query = "SELECT CONCAT('Dr. ', fname, ' ', lname, ' - ', specialty) from doctor WHERE doctorID = @doctorID";
            MySqlCommand cmd = new MySqlCommand(query, connection);
            cmd.Parameters.AddWithValue("doctorID", doctorID);
            connection.Open();
            object result = cmd.ExecuteScalar();
            string fullname = result.ToString();
            welcomeHeader.InnerText = "Welcome, " + fullname;
            connection.Close();
        }

        protected void BindData()
        {
            int doctorID = Convert.ToInt32(Request.QueryString["doctorID"]);
            DataTable dt = new DataTable();

            // Retrieve data from database into upcoming appointment grid
            string connectionString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
            string query = "SELECT CONCAT(patients.fname, ' ', patients.lname) as PatientName, office.officeAddress as OfficeLocation, appointment.appointmentID as appointmentID, appointment.approval as Approval, appointmentTime as Time, appointmentDate as Date FROM appointment INNER JOIN patients ON appointment.PatientID = Patients.patientID INNER JOIN office ON Appointment.OfficeID = Office.officeID WHERE appointment.doctorID = @DoctorID AND appointmentDate >= current_date() AND archive = false ORDER BY appointmentDate DESC";
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                using (MySqlCommand command = new MySqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@DoctorID", doctorID);
                    connection.Open();
                    using (MySqlDataAdapter adapter = new MySqlDataAdapter(command))
                    {
                        adapter.Fill(dt);
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                }
                connection.Close();
            }


            // Retrive data from database into referral review
            string query2 = "SELECT appointment.appointmentID as appointmentID2, CONCAT(patients.fname, ' ', patients.lname) as PatientName2, spec.specialty as Specialist, appointment.Referral as Referral,CONCAT(spec.fname, ' ', spec.lname) as Doctor, appointmentDate as Date2 FROM appointment, patients, doctor as prim, doctor as spec  WHERE appointment.doctorID = spec.doctorID AND prim.doctorID = patients.doctorID AND appointment.patientID = patients.patientID AND prim.doctorID = @DoctorID AND prim.doctorID != spec.doctorID AND appointmentDate >= current_date() AND archive = false ORDER BY appointmentDate DESC";
            DataTable dt2 = new DataTable();
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                using (MySqlCommand command = new MySqlCommand(query2, connection))
                {
                    command.Parameters.AddWithValue("@DoctorID", doctorID);
                    connection.Open();
                    using (MySqlDataAdapter adapter = new MySqlDataAdapter(command))
                    {
                        adapter.Fill(dt2);
                        GridView2.DataSource = dt2;
                        GridView2.DataBind();
                    }
                }
                connection.Close();
            }

            // Retrieve data from database into past appointments 
            string query3 = "SELECT CONCAT(patients.fname, ' ', patients.lname) as PatientName, office.officeAddress as OfficeLocation, appointment.appointmentID as appointmentID, appointmentTime as Time, appointmentDate as Date FROM appointment INNER JOIN patients ON appointment.PatientID = Patients.patientID INNER JOIN office ON Appointment.OfficeID = Office.officeID WHERE appointment.doctorID = @DoctorID AND PATIENT_CONFIRM = true AND Approval = true AND appointmentDate < current_date() ORDER BY appointmentDate DESC";
            DataTable dt3 = new DataTable();

            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                using (MySqlCommand command = new MySqlCommand(query3, connection))
                {
                    command.Parameters.AddWithValue("@DoctorID", doctorID);
                    connection.Open();
                    using (MySqlDataAdapter adapter = new MySqlDataAdapter(command))
                    {
                        adapter.Fill(dt3);
                        GridView3.DataSource = dt3;
                        GridView3.DataBind();
                    }
                }
                connection.Close();
            }
        }


        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ApproveAppointment") {
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
                if (reader.HasRows) {
                 string email = reader["email"].ToString();
                 reader.Close();
                 connect.Close();

                // Update approval status in database
                string query = "UPDATE appointment SET Approval = @Approved WHERE appointmentID = @ID";
                using (MySqlConnection connection = new MySqlConnection(connString))
                {
                    using (MySqlCommand command = new MySqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@Approved", true);
                        command.Parameters.AddWithValue("@ID", appointmentID);
                        connection.Open();
                        int rowsAffected = command.ExecuteNonQuery();
                        connection.Close();

                            if (rowsAffected > 0)
                            {
                                // Send confirmation email to patient
                                MailMessage mail = new MailMessage();
                                mail.To.Add(email);
                                mail.Subject = "Appointment Approved";
                                mail.Body = "Your appointment has been approved. To avoid cancellation, please log on to your account to confirm your appointment at least 24 hours before its scheduled date. We look forward to seeing you!";
                                SmtpClient smtp = new SmtpClient();
                                smtp.Send(mail);

                                // Refresh data grid
                                BindData();

                            }
                        }
                    }
                }
            }
            else if (e.CommandName == "DenyAppointment")
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

                    // Update approval status in database
                    string query = "UPDATE appointment SET Approval = @Approved WHERE appointmentID = @ID";
                    using (MySqlConnection connection = new MySqlConnection(connString))
                    {
                        using (MySqlCommand command = new MySqlCommand(query, connection))
                        {
                            command.Parameters.AddWithValue("@Approved", false);
                            command.Parameters.AddWithValue("@ID", appointmentID);
                            connection.Open();
                            int rowsAffected = command.ExecuteNonQuery();
                            connection.Close();

                            if (rowsAffected > 0)
                            {
                                // Send confirmation email to patient
                                MailMessage mail = new MailMessage();
                                mail.To.Add(email);
                                mail.Subject = "Appointment Denied";
                                mail.Body = "Your appointment has been denied. Please reach out to us further for clarification and to reschedule.";
                                SmtpClient smtp = new SmtpClient();
                                smtp.Send(mail);
                                // Refresh data grid
                                BindData();
                            }
                        }
                    }
                }
                connect.Close();
            }
        }


        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {  
            if (e.CommandName == "ApproveAppointment2")
            {
                int appointmentID = Convert.ToInt32(GridView2.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text);

                // Get patient email
                string email_query = "SELECT patients.email FROM patients, appointment WHERE appointment.appointmentID = @apid AND appointment.patientID = patients.patientID";

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

                    // Update approval status in database
                    string query = "UPDATE patients, appointment SET appointment.referral = @Referral WHERE appointment.appointmentID = @ID AND patients.patientID = appointment.patientID";

                    using (MySqlConnection connection = new MySqlConnection(connString))
                    {
                        using (MySqlCommand command = new MySqlCommand(query, connection))
                        {
                            command.Parameters.AddWithValue("@Referral", true);
                            command.Parameters.AddWithValue("@ID", appointmentID);
                            connection.Open();
                            int rowsAffected = command.ExecuteNonQuery();
                            connection.Close();

                            if (rowsAffected > 0)
                            {
                                // Send confirmation email to patient
                                MailMessage mail = new MailMessage();
                                mail.To.Add(email);
                                mail.Subject = "Referral Approved";
                                mail.Body = "Your specialist appointment requiring referral has been approved. To avoid cancellation, please log on to your account to confirm at least 24 hours before your scheduled date. We look forward to seeing you!";
                                SmtpClient smtp = new SmtpClient();
                                smtp.Send(mail);

                                // Refresh data grid
                                BindData();
                            }
                        }
                    }
                }
                connect.Close();

            }
            else if (e.CommandName == "DenyAppointment2")
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
                    // Update referral status in database
                    using (MySqlConnection connection = new MySqlConnection(connString))
                    {
                        string query_ref = "UPDATE patients, appointment SET appointment.referral = false WHERE appointment.appointmentID = 30008 AND patients.patientID = appointment.patientID";

                        using (MySqlCommand command = new MySqlCommand(query_ref, connection))
                        {
                            command.Parameters.AddWithValue("@Referral", false);
                            command.Parameters.AddWithValue("@ID", appointmentID);
                            connection.Open();
                            int rowsAffected = command.ExecuteNonQuery();
                            connection.Close();

                            if (rowsAffected > 0)
                            {
                                // Send confirmation email to patient
                                MailMessage mail = new MailMessage();
                                mail.To.Add(email);
                                mail.Subject = "Referral Denied";
                                mail.Body = "Your referral has been denied. Please reach out to you primary care physician for further clarification and to reschedule.";
                                SmtpClient smtp = new SmtpClient();
                                smtp.Send(mail);

                                // Refresh data grid
                                BindData();
                            }
                        }
                    }
                }
            }
        }

        protected void GridView3_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int appointmentID = Convert.ToInt32(GridView1.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text);
            string query = "SELECT reportID FROM appointment WHERE appointmentID = @AID";
            string connString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
            MySqlConnection connect = new MySqlConnection(connString);
            connect.Open();
            MySqlCommand cmd = new MySqlCommand(query, connect);
            cmd.Parameters.AddWithValue("@AID", appointmentID);
            object result = cmd.ExecuteScalar();
            int ReportID = Convert.ToInt32(result);
            connect.Close();
            if (e.CommandName == "VIEW")
            {
                Response.Redirect("ReportView.aspx?ReportID=" + ReportID);
            }
        }
    }
}






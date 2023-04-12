using System;
using System.Configuration;
using System.Data;
using MySql.Data.MySqlClient;
using System.Net;
using System.Net.Mail;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Globalization;



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
            string query = "SELECT CONCAT(doctor.fname, ' ', doctor.lname) as DoctorName, office.officeAddress as OfficeLocation, appointment.appointmentID as appointmentID, appointment.approval as Approval, appointmentTime as Time, appointmentDate as Date, PATIENT_CONFIRM as Confirm, doctor.specialty as SPEC FROM appointment, doctor, office WHERE appointment.patientID = @patientID AND appointment.doctorID = doctor.doctorID AND appointment.officeID = office.officeID AND appointmentDate >= current_date() AND appointment.archive = false ORDER BY appointmentDate ASC";
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                using (MySqlCommand command = new MySqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@PatientID", patientID);
                    connection.Open();
                    using (MySqlDataAdapter adapter = new MySqlDataAdapter(command))
                    {
                        adapter.Fill(dt);

                        // Add a column to the data table for Time to Confirm
                        dt.Columns.Add("TimeToConfirm");
                        dt.Columns.Add("ConfirmText");

                        // Calculate Time to Confirm for each row
                        foreach (DataRow row in dt.Rows)
                        {
                            // Set the value for the Confirm field
                            bool? confirmValue = row.Field<bool?>("Confirm");
                            string confirmText;
                            if (confirmValue.HasValue)
                            {
                                confirmText = confirmValue.Value ? "Patient Confirmed" : "Not Confirmed";
                            }
                            else
                            {
                                confirmText = "Needs Approval";
                            }


                            // Add a new column to the DataRow with the Confirm field value
                            row["ConfirmText"] = confirmText;

                            // calculate time to confirm
                            string appDate = Convert.ToDateTime(row["Date"]).ToString("yyyy-MM-dd");
                            string appTime = Convert.ToString(row["Time"]);
                            DateTime appointmentDateTime;
                            DateTime.TryParseExact(appDate + " " + appTime, "yyyy-MM-dd h:mm:ss", CultureInfo.InvariantCulture, DateTimeStyles.None, out appointmentDateTime);

                            try
                            {
                                DateTime timeToConfirm = appointmentDateTime.AddHours(-24);
                                TimeSpan timeRemaining = timeToConfirm - DateTime.Now;
                                row["TimeToConfirm"] = String.Format("{0} days, {1} hours, {2} minutes", timeRemaining.Days, timeRemaining.Hours, timeRemaining.Minutes);
                            }
                            catch (Exception)
                            {
                                Response.Write(appDate.ToString() + " " + appTime + " ");
                            }
                        }
                        // Bind data
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                    connection.Close();
                }
            }

            DataTable dt2 = new DataTable();

            // Retrieve data from database into previous appointment grid
            string query2 = "SELECT CONCAT(doctor.fname, ' ', doctor.lname) as DoctorName, office.officeAddress as OfficeLocation, appointment.appointmentID as appointmentID, appointmentTime as Time, appointmentDate as Date, doctor.specialty as SPEC FROM appointment, doctor, office WHERE appointment.patientID = @PatientID AND appointment.doctorID = doctor.doctorID AND appointment.officeID = office.officeID AND PATIENT_CONFIRM = true AND Approval = true AND appointmentDate <= current_date() ORDER BY appointmentDate ASC";
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                using (MySqlCommand command = new MySqlCommand(query2, connection))
                {
                    command.Parameters.AddWithValue("@PatientID", patientID);
                    connection.Open();
                    using (MySqlDataAdapter adapter = new MySqlDataAdapter(command))
                    {
                        adapter.Fill(dt2);
                        GridView2.DataSource = dt2;
                        GridView2.DataBind();
                    }
                    connection.Close();
                }
            }
        }


        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int appointmentID = Convert.ToInt32(GridView1.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text);
            int patientID = Convert.ToInt32(Request.QueryString["patientID"]);

            if (e.CommandName == "ConfirmAppointment")
            {
                // Get patient email
                string email_query = "SELECT DISTINCT patients.email as email, appointmentDate as date, appointmentTime as time, CONCAT('Dr. ', doctor.fname, ' ', doctor.lname) as doctorName FROM patients, appointment, doctor WHERE appointment.patientID=patients.patientID AND appointment.doctorID = doctor.doctorID AND appointmentID = @APID";
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
                    string doctorName = reader["doctorName"].ToString();
                    string date = reader["date"].ToString();
                    string time = reader["time"].ToString();
                    reader.Close();
                    connect.Close();
                    date = DateTime.ParseExact(date, "M/d/yyyy h:mm:ss tt", CultureInfo.InvariantCulture).ToString("M/d/yyyy");


                    // Update approval status in database
                    string query = "UPDATE appointment SET PATIENT_CONFIRM = @CONFIRM WHERE appointmentID = @ID";
                    using (MySqlConnection connection = new MySqlConnection(connString))
                    {
                        connection.Open();
                        using (MySqlCommand command = new MySqlCommand(query, connection))
                        {
                            command.Parameters.AddWithValue("@CONFIRM", true);
                            command.Parameters.AddWithValue("@ID", appointmentID);
                            int rowsAffected = command.ExecuteNonQuery();
                            connection.Close();
                            // Refresh data grid
                            BindData();
                            string confirmed = GridView1.Rows[Convert.ToInt32(e.CommandArgument)].Cells[8].Text;
                            if (confirmed == "Patient Confirmed")
                            {
                                // Send confirmation email to patient
                                MailMessage mail = new MailMessage();
                                mail.To.Add(email);
                                mail.Subject = "Appointment Confirmed";
                                mail.Body = "You have successfully confirmed your appointment on " + date + " at " + time + " with " + doctorName + ". Please arrive to your appointment at least 15 minutes before the scheduled time";
                                SmtpClient smtp = new SmtpClient();
                                smtp.Send(mail);

                                // Refresh data grid
                                BindData();
                            }
                        }
                    }
                }

            }
            else if (e.CommandName == "EditAppointment")
            {
                Response.Redirect("PatEditApp.aspx?appointmentID=" + appointmentID +"&patientID=" + patientID);
            }
            else if (e.CommandName == "CancelAppointment")
            {
                // Get patient email
                string email_query = "SELECT DISTINCT patients.email as email, appointmentDate as date, appointmentTime as time, CONCAT('Dr. ', doctor.fname, ' ', doctor.lname) as doctorName FROM patients, appointment, doctor WHERE appointment.patientID=patients.patientID AND appointment.doctorID = doctor.doctorID AND appointmentID = @APID";
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
                    string doctorName = reader["doctorName"].ToString();
                    string date = reader["date"].ToString();
                    string time = reader["time"].ToString();
                    reader.Close();
                    connect.Close();
                    date = DateTime.ParseExact(date, "M/d/yyyy h:mm:ss tt", CultureInfo.InvariantCulture).ToString("M/d/yyyy");
                    time = DateTime.ParseExact(time, "h:mm:ss", CultureInfo.InvariantCulture).ToString("h:mm");
                    // Update approval status in database
                    string query = "UPDATE appointment SET Archive = @archive WHERE appointmentID = @ID";
                    using (MySqlConnection connection = new MySqlConnection(connString))
                    {
                        using (MySqlCommand command = new MySqlCommand(query, connection))
                        {
                            command.Parameters.AddWithValue("@archive", true);
                            command.Parameters.AddWithValue("@ID", appointmentID);
                            connection.Open();
                            int rowsAffected = command.ExecuteNonQuery();
                            connection.Close();

                            if (rowsAffected > 0)
                            {
                                // Send confirmation email to patient
                                MailMessage mail = new MailMessage();
                                mail.To.Add(email);
                                mail.Subject = "Appointment Cancelled";
                                mail.Body = "You have successfully confirmed your appointment on " + date + " at " + time + " with " + doctorName + ". Please schedule a new appointment if you wish to see us again.";
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
        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int patientID = Convert.ToInt32(Request.QueryString["patientID"]);
            int appointmentID = Convert.ToInt32(GridView2.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text);
            string query = "SELECT reportID FROM appointment WHERE appointmentID = @AID";
            string connString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
            MySqlConnection connect = new MySqlConnection(connString);
            connect.Open();
            MySqlCommand cmd = new MySqlCommand(query, connect);
            cmd.Parameters.AddWithValue("@AID", appointmentID);
            object result = cmd.ExecuteScalar();

                int ReportID = Convert.ToInt32(result);
                connect.Close();

                if (e.CommandName == "ViewReport")
                {
                    Response.Redirect("ReportView.aspx?ReportID=" + ReportID + "&patientID=" + patientID);
                }

        }


        protected void Button1_Click(object sender, EventArgs e)
        {
            int patientID = Convert.ToInt32(Request.QueryString["patientID"]);
            Response.Redirect("PatEdit.aspx?patientID=" + patientID);
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            int patientID = Convert.ToInt32(Request.QueryString["patientID"]);
            Response.Redirect("PCPfollowup.aspx?patientID=" +patientID);
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            int patientID = Convert.ToInt32(Request.QueryString["patientID"]);
            Response.Redirect("NewAppointment.aspx?patientID=" + patientID);

        }
        protected void Button4_Click(object sender, EventArgs e)
        {
            int patientID = Convert.ToInt32(Request.QueryString["patientID"]);
            Response.Redirect("PatBilling.aspx?patientID=" + patientID);
        }

    }
}
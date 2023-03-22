using System;
using System.Configuration;
using System.Data;
using MySql.Data.MySqlClient;
using System.Net;
using System.Net.Mail;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class WebForm6 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }
            int doctorID =Convert.ToInt32 (Request.QueryString["doctorID"]);
            string connectionString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb;Uid=dbadmin;Pwd=Medical123!;";
            MySqlConnection connection = new MySqlConnection(connectionString);
            string query = "SELECT CONCAT('Dr. ', fname, ' ', lname) from doctor WHERE doctorID = @doctorID";
            MySqlCommand cmd = new MySqlCommand(query, connection);
            cmd.Parameters.AddWithValue("doctorID", doctorID);
            connection.Open();
            object result = cmd.ExecuteScalar();
            string fullname = result.ToString();
            welcomeHeader.InnerText = "Welcome, " + fullname;
        }

        protected void BindData()
        {
            int doctorID = Convert.ToInt32(Request.QueryString["doctorID"]);
            DataTable dt = new DataTable();

            // Retrieve data from database into appointment grid
            string connectionString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb;Uid=dbadmin;Pwd=Medical123!;";
            string query = "SELECT CONCAT(patients.fname, ' ', patients.lname) as PatientName, office.officeAddress as OfficeLocation, appointment.appointmentID as appointmentID, appointment.approval as Approval, appointmentTime as Time FROM appointment INNER JOIN patients ON appointment.PatientID = Patients.patientID INNER JOIN office ON Appointment.OfficeID = Office.officeID WHERE appointment.doctorID = @DoctorID";
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
                    connection.Close();
                }
            }



            string query2 = "SELECT appointment.appointmentID as appointmentID2, CONCAT(patients.fname, ' ', patients.lname) as PatientName2, spec.specialty as Specialist, patients.Referral as Referral,CONCAT(spec.fname, ' ', spec.lname) as Doctor FROM appointment, patients, doctor as prim, doctor as spec  WHERE appointment.doctorID = spec.doctorID AND prim.doctorID = patients.doctorID AND appointment.patientID = patients.patientID AND prim.doctorID = @DoctorID AND prim.doctorID != spec.doctorID";
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
                    connection.Close();
                }
            }
        }


        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ApproveAppointment") {
                int appointmentID = Convert.ToInt32(GridView1.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text);

                // Get patient email
                string email_query = "SELECT email FROM patients, appointment WHERE appointment.appointmentID = @apid AND appointment.patientID = patients.patientID";
                string connString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb;Uid=dbadmin;Pwd=Medical123!;";
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
                                mail.Body = "Your appointment has been approved. We look forward to seeing you!";
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
        }


        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ApproveAppointment2")
            {
                int appointmentID = Convert.ToInt32(GridView2.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text);

                // Get patient email
                string email_query = "SELECT patients.email FROM patients, appointment WHERE appointment.appointmentID = @apid AND appointment.patientID = patients.patientID";

                string connString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb;Uid=dbadmin;Pwd=Medical123!;";
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
                    string query = "UPDATE patients, appointment SET referral = true WHERE appointment.appointmentID = @ID AND patients.patientID = appointment.patientID";

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
                                mail.Subject = "Referral Approved";
                                mail.Body = "Your specialist appointment requiring referral has been approved. We look forward to seeing you!";
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
        }

    }
}






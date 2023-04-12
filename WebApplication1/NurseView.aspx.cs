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
    public partial class NurseView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }

            // Get Doctor Name for Welcome Header
            int nurseID = Convert.ToInt32(Request.QueryString["nurseID"]);
            string connectionString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
            MySqlConnection connection = new MySqlConnection(connectionString);
            string query = "SELECT CONCAT('RN ', fname, ' ', lname) from nurse WHERE NID = @NID";
            MySqlCommand cmd = new MySqlCommand(query, connection);
            cmd.Parameters.AddWithValue("@NID", nurseID);
            connection.Open();
            object result = cmd.ExecuteScalar();
            string fullname = result.ToString();
            WelcomeHeader.InnerText = "Welcome, " + fullname;
            connection.Close();
        }

        protected void BindData()
        {
            int nurseID = Convert.ToInt32(Request.QueryString["nurseID"]);
            DataTable dt = new DataTable();

            // Retrieve data from database into upcoming appointment grid
            string connectionString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
            string query = "SELECT CONCAT(patients.fname, ' ', patients.lname) as PatientName, office.officeAddress as OfficeLocation, appointment.appointmentID as appointmentID, appointment.approval as Approval, appointmentTime as Time, appointmentDate as Date FROM appointment, patients, office, nurse where appointment.patientID = Patients.patientID AND Appointment.OfficeID = Office.officeID AND nurse.officeID = Office.officeID AND nurse.NID = @NID AND appointmentDate >= current_date() AND appointment.archive = false ORDER BY appointmentDate DESC";
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                using (MySqlCommand command = new MySqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@NID", nurseID); //????
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


            // Retrieve data from database into past appointments 
            string query3 = "SELECT CONCAT(patients.fname, ' ', patients.lname) as PatientName, office.officeAddress as OfficeLocation, appointment.appointmentID as appointmentID , appointmentTime as Time, appointmentDate as Date FROM appointment, patients, office, nurse WHERE NID = @NID AND appointment.PatientID = Patients.patientID AND Appointment.OfficeID = Office.officeID AND nurse.officeID = Office.officeID AND appointmentDate <= current_date() AND appointment.archive = True AND PATIENT_CONFIRM = true ORDER BY appointmentDate DESC";
            DataTable dt3 = new DataTable();

            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                using (MySqlCommand command = new MySqlCommand(query3, connection))
                {
                    command.Parameters.AddWithValue("@NID", nurseID);
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

        protected void GridView3_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int appointmentID = Convert.ToInt32(GridView3.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text);
            string query = "SELECT reportID FROM appointment WHERE appointmentID = @AID";
            string connString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
            MySqlConnection connect = new MySqlConnection(connString);
            connect.Open();
            MySqlCommand cmd = new MySqlCommand(query, connect);
            cmd.Parameters.AddWithValue("@AID", appointmentID);
            object result = cmd.ExecuteScalar();
            int ReportID = Convert.ToInt32(result);
            connect.Close();
            int nurseID = Convert.ToInt32(Request.QueryString["nurseID"]);

            if (e.CommandName == "VIEW")
            {
                Response.Redirect("ReportView.aspx?ReportID=" + ReportID+"&nurseID="+nurseID);
            }
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int nurseID = Convert.ToInt32(Request.QueryString["nurseID"]);
            int appointmentID = Convert.ToInt32(GridView1.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text);
            if (e.CommandName == "GENERATE")
            {
                Response.Redirect("nurseReport.aspx?appID=" + appointmentID + "&NID=" + nurseID);
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}



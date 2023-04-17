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
            string query2 = "SELECT officeAddress FROM office, nurse where nurse.NID = @NID AND nurse.officeID = office.officeID";
            MySqlCommand cmd = new MySqlCommand(query, connection);
            MySqlCommand cmd2 = new MySqlCommand(query2, connection);
            cmd2.Parameters.AddWithValue("@NID", nurseID);
            cmd.Parameters.AddWithValue("@NID", nurseID);
            connection.Open();
            object result = cmd.ExecuteScalar();
            string officeloc = cmd2.ExecuteScalar().ToString();
            string fullname = result.ToString();
            WelcomeHeader.InnerText = "Welcome, " + fullname;
            officeHeader.InnerText = "Office Location: " + officeloc;
            connection.Close();
            LinkButton1.Text = "Logged in as: " + fullname;

        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            int nurseID = Convert.ToInt32(Request.QueryString["nurseID"]);
            Response.Redirect("NurseView.aspx?nurseID=" + nurseID);

        }

        protected void BindData()
        {
            int nurseID = Convert.ToInt32(Request.QueryString["nurseID"]);
            DataTable dt = new DataTable();

            // Retrieve data from database into upcoming appointment grid
            string connectionString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
            string query = "SELECT CONCAT(patients.fname, ' ', patients.lname) as PatientName, doctor.Specialty as Specialty, office.officeAddress as OfficeLocation, appointment.appointmentID as appointmentID, appointment.approval as Approval, appointmentTime as Time, appointmentDate as Date, CONCAT('Dr. ', doctor.fname, ' ', doctor.lname) as docName FROM appointment, patients, office, nurse, doctor where appointment.patientID = Patients.patientID AND Appointment.OfficeID = Office.officeID AND nurse.officeID = Office.officeID AND nurse.NID = @NID AND appointment.doctorID = doctor.doctorID AND appointmentDate >= current_date() AND appointment.archive = false ORDER BY appointmentDate DESC";
            string nursequery = " SELECT CONCAT(nurse.fname, ' ', nurse.lname) as Nurse, nurse.NID as nurseID FROM nurse, appointment where nurse.NID = appointment.nurseID AND appointmentID = @appID";
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                using (MySqlCommand command = new MySqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@NID", nurseID); 
                    connection.Open();
                    using (MySqlDataAdapter adapter = new MySqlDataAdapter(command))
                    {
                        adapter.Fill(dt);
                        dt.Columns.Add("Nurse");
                        dt.Columns.Add("nurseID");

                        string nurseName;
                        string NID;

                        foreach (DataRow row in dt.Rows)
                        {
                            string appointmentID = row["appointmentID"].ToString();
                            MySqlCommand command2 = new MySqlCommand(nursequery, connection);
                            command2.Parameters.AddWithValue("@appID", appointmentID);
                            try
                            {
                                MySqlDataReader reader = command2.ExecuteReader();
                                reader.Read();
                                nurseName = reader["Nurse"].ToString();
                                NID = reader["nurseID"].ToString();
                                row["Nurse"] = nurseName;
                                row["nurseID"] = NID;
                                reader.Close();
                            }
                            catch (Exception)
                            {
                                row["Nurse"] = DBNull.Value;
                                row["nurseID"] = DBNull.Value;
                            }
                        }
                        

                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                }
                connection.Close();
            }


            // Retrieve data from database into past appointments 
            string query3 = "SELECT CONCAT(patients.fname, ' ', patients.lname) as PatientName, CONCAT('Dr. ', doctor.fname, ' ', doctor.lname) as docName, office.officeAddress as OfficeLocation, appointment.appointmentID as appointmentID, Specialty, appointmentTime as Time, appointmentDate as Date FROM appointment, patients, office, doctor, nurse WHERE NID = @NID AND appointment.PatientID = Patients.patientID AND Appointment.OfficeID = Office.officeID AND nurse.officeID = Office.officeID AND appointment.doctorID = doctor.doctorID AND appointmentDate <= current_date() AND appointment.archive = True AND PATIENT_CONFIRM = true ORDER BY appointmentDate DESC";
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

            MySqlConnection con = new MySqlConnection(connectionString);
            DataTable dt_test = new DataTable();
            string nurse_query = "SELECT CONCAT(nurse.fname, ' ', nurse.lname) FROM nurse WHERE NID=@nurseID";
            string officeID_query = "SELECT officeID from nurse WHERE NID = @NID";
            string test_query = "SELECT test.testID as TestID, evaluation.test as Test, test.test_date as Date, test.test_time as Time, test.nurseID as nurseID, CONCAT(patients.fname, ' ', patients.lname) as patname FROM patients, test, evaluation WHERE test.officeID = @officeID AND test.test_code = evaluation.code AND test.patientID = patients.patientID";
            MySqlCommand test_cmd = new MySqlCommand(test_query, con);
            MySqlCommand officeID_cmd = new MySqlCommand(officeID_query, con);
            officeID_cmd.Parameters.AddWithValue("@NID", nurseID);
            con.Open();
            string officeID = officeID_cmd.ExecuteScalar().ToString();

            test_cmd.Parameters.AddWithValue("@officeID", officeID);

            MySqlDataAdapter adp = new MySqlDataAdapter(test_cmd);

            adp.Fill(dt_test);

            // Add columns for Nurse and OfficeLocation to the DataTable
            dt_test.Columns.Add("Nurse");

            string nurse_name;

            // Set the Nurse and OfficeLocation values for each row
            foreach (DataRow row in dt_test.Rows)
            {
                MySqlCommand nurse_cmd = new MySqlCommand(nurse_query, con);

                string NID = row["nurseID"].ToString();


                nurse_cmd.Parameters.AddWithValue("@nurseID", NID);
                try
                {
                    nurse_name = nurse_cmd.ExecuteScalar().ToString();

                }
                catch (Exception)
                {
                    nurse_name = DBNull.Value.ToString();

                }

                row["Nurse"] = nurse_name;
            }

            GridView2.DataSource = dt_test;
            GridView2.DataBind();
            con.Close();

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
            int NID = Convert.ToInt32(GridView1.DataKeys[Convert.ToInt32(e.CommandArgument)].Values["nurseID"]);

            string connectionString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
            MySqlConnection connection = new MySqlConnection(connectionString);

            if (e.CommandName == "GENERATE" && NID == nurseID)
            {
                Response.Redirect("nurseReport.aspx?appID=" + appointmentID + "&NID=" + nurseID);
            }
            else if(e.CommandName == "assignApp")
            {
                string query = "UPDATE appointment SET nurseID = @nurseID WHERE appointmentID = @appID";
                MySqlCommand command = new MySqlCommand(query, connection);
                connection.Open();
                command.Parameters.AddWithValue("@nurseID", nurseID);
                command.Parameters.AddWithValue("@appID", appointmentID);
                command.ExecuteNonQuery();
                connection.Close();
                BindData();
            }
        }
        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int testID = Convert.ToInt32(GridView2.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text);
            int nurseID = Convert.ToInt32(Request.QueryString["nurseID"]);
            string query = "UPDATE test SET nurseID = @NID WHERE testID = @testID";
            string connectionString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
            MySqlConnection connection = new MySqlConnection(connectionString);
            MySqlCommand cmd = new MySqlCommand(query, connection);
            cmd.Parameters.AddWithValue("@NID", nurseID);
            cmd.Parameters.AddWithValue("@testID", testID);
            connection.Open();
            cmd.ExecuteNonQuery();
            connection.Close();
            BindData();
        }


        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            int nurseID = Convert.ToInt32(Request.QueryString["nurseID"]);
            Response.Redirect("NursePatientReports.aspx?nurseID=" + nurseID);
        }
    }
}



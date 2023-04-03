using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace WebApplication1
{
    public partial class nurseReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {                                                                           //TODO: match variable names in button redirect in nurseView.aspx.cs
            int appointmentID = Convert.ToInt32(Request.QueryString["appID"]);

            string connectionString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";

            string titleQuery = "SELECT CONCAT(fname,' ', lname, ' Appointment on ', AppointmentDate) FROM patients, appointment WHERE appointment.patientID = patients.patientID";
            string patientNameQuery = "SELECT CONCAT(fname, ' ', lname) FROM appointment, patients WHERE appointment.appointmentID = @appointmentID AND appointment.patientID = patients.patientID";
            string doctorNameQuery = "SELECT CONCAT('Dr. ', Fname, ' ', Lname, ' - ', Specialty) from doctor, appointment WHERE appointment.appointmentID = @appointmentID AND appointment.doctorID = doctor.doctorID ";

            MySqlConnection connection = new MySqlConnection(connectionString);

            MySqlCommand titleCommand = new MySqlCommand(titleQuery, connection);
            titleCommand.Parameters.AddWithValue("@appointmentID", appointmentID);

            MySqlCommand patientNameCmd = new MySqlCommand(patientNameQuery, connection);
            patientNameCmd.Parameters.AddWithValue("@appointmentID", appointmentID);

            MySqlCommand doctorNameCmd = new MySqlCommand(doctorNameQuery, connection);
            doctorNameCmd.Parameters.AddWithValue("@appointmentID", appointmentID);

            connection.Open();

            string headerStr = (string)titleCommand.ExecuteScalar();
            string patientName = (string)patientNameCmd.ExecuteScalar();
            string docName = (string)doctorNameCmd.ExecuteScalar();

            connection.Close();

            reportHeader.InnerText = "Report for " + headerStr;
            patientNameBox.Text = patientName;
            doctorNameBox.Text = docName;

        }

        protected void submitBttn_Click(object sender, EventArgs e)
        {

            int appointmentID = Convert.ToInt32(Request.QueryString["appID"]);
            string patientSymptoms = symptomsBox.Text;
            string patientDiagnosis = diagnosisBox.Text;
            string patientPrescription = prescriptionBox.Text;
            int appointmentTotal = int.Parse(apptTotalBox.Text);
            int insuranceCoverage = int.Parse(insuranceCovBox.Text);



            string connectionString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";

            string insertSymptoms = "INSERT INTO visit_details (symptoms) VALUES (@symptoms) WHERE visit_details.appointmentID = @appointmentID";
            string insertDiagnosis = "INSERT INTO visit_details (diagnosis) VALUES (@diagnosis) visit_details.appointmentID = @appointmentID";
            string insertPrescription = "INSERT INTO visit_details (prescription) VALUES (@prescription) visit_details.appointmentID = @appointmentID";

            string insertApptTotal = "";
            string insertInsCov = "";           //TODO: create insert strings;

            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                MySqlCommand symptomsCmd = new MySqlCommand(insertSymptoms, connection);
                symptomsCmd.Parameters.AddWithValue("@symptoms", patientSymptoms);
                symptomsCmd.Parameters.AddWithValue("@appointmentID", appointmentID);

                MySqlCommand diagnosisCmd = new MySqlCommand(insertDiagnosis, connection);
                diagnosisCmd.Parameters.AddWithValue("@diagnosis", patientDiagnosis);
                diagnosisCmd.Parameters.AddWithValue("@appointmentID", appointmentID);

                MySqlCommand prescriptionCmd = new MySqlCommand(insertPrescription, connection);
                prescriptionCmd.Parameters.AddWithValue("@prescription", patientPrescription);
                prescriptionCmd.Parameters.AddWithValue("@appointmentID", appointmentID);

                // TODO: create commands for appointment total and insurance coverage

                connection.Open();

                symptomsCmd.ExecuteNonQuery();
                diagnosisCmd.ExecuteNonQuery();
                prescriptionCmd.ExecuteNonQuery();
                //TODO: add appointment and insurance coverage;

                connection.Close();

            }
            Response.Redirect(Request.UrlReferrer.ToString());

        }

    }
}

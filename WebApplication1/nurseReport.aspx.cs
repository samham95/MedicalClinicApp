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

            string titleQuery = "SELECT CONCAT(fname,' ', lname, ' Appointment on ', AppointmentDate) FROM patients, appointment WHERE appointment.patientID = patients.patientID AND appointment.appointmentID = @appointmentID";
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
            int temperature = int.Parse(temperatureBox.Text);
            int pressure = int.Parse(pressureBox.Text);
            int heartRate = int.Parse(heartrateBox.Text);



            string connectionString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";

            string insertSymptoms = "INSERT INTO visit_details (symptoms) VALUES (@symptoms) WHERE visit_details.appointmentID = @appointmentID";
            string insertDiagnosis = "INSERT INTO visit_details (diagnosis) VALUES (@diagnosis) visit_details.appointmentID = @appointmentID";
            string insertPrescription = "INSERT INTO visit_details (prescription) VALUES (@prescription) visit_details.appointmentID = @appointmentID";

            string insertTemperature = "INSERT INTO visit_details (temperature) VALUES (@temperature) WHERE visit_details.appointmentID = @appointmentID";
            string insertPressure = "INSERT INTO visit_details (bloodPressure) VALUES (@pressure) WHERE visit_details.appointmentID = @appointmentID";
            string insertRate = "INSERT INTO visit_details (heartRate) VALUES (@heartRate) WHERE visit_details.appointmentID = @appointmentID";

            string insertApptTotal = "INSERT INTO invoice (total) VALUES (@apptTotal) WHERE invoice.reportID = visit_details.reportID  AND visit_details.appointmentID = @appointmentID";
            string insertInsCov = "INSERT INTO invoice (claim) VALUES (@insuranceCov) WHERE invoice.reportID = visit_details.reportID  AND visit_details.appointmentID = @appointmentID";           //TODO: create insert strings;

            string changeFurtherEval = "UPDATE visit_details SET (furtherEval) = 1 WHERE visit_details.appointmentID = @appointmentID";

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

                MySqlCommand tempCmd = new MySqlCommand(insertTemperature, connection);
                tempCmd.Parameters.AddWithValue("@temperature", temperature);
                tempCmd.Parameters.AddWithValue("@appointmentID", appointmentID);

                MySqlCommand pressureCmd = new MySqlCommand(insertPressure, connection);
                pressureCmd.Parameters.AddWithValue("@pressure", pressure);
                pressureCmd.Parameters.AddWithValue("@appointmentID", appointmentID);

                MySqlCommand rateCmd = new MySqlCommand(insertRate, connection);
                rateCmd.Parameters.AddWithValue("@heartRate", heartRate);
                rateCmd.Parameters.AddWithValue("@appointmentID", appointmentID);

                MySqlCommand totalcmd = new MySqlCommand(insertApptTotal, connection);
                totalcmd.Parameters.AddWithValue("@apptTotal", appointmentTotal);
                totalcmd.Parameters.AddWithValue("@appointmentID", appointmentID);

                MySqlCommand covCmd = new MySqlCommand(insertInsCov, connection);
                covCmd.Parameters.AddWithValue("@insuranceCov", insuranceCoverage);
                covCmd.Parameters.AddWithValue("@appointmentID", appointmentID);

                MySqlCommand checkBoxCmd = new MySqlCommand(changeFurtherEval, connection);
                checkBoxCmd.Parameters.AddWithValue("@appointmentID", appointmentID);
                connection.Open();

                symptomsCmd.ExecuteNonQuery();
                diagnosisCmd.ExecuteNonQuery();
                prescriptionCmd.ExecuteNonQuery();
                tempCmd.ExecuteNonQuery();
                pressureCmd.ExecuteNonQuery();
                rateCmd.ExecuteNonQuery();
                totalcmd.ExecuteNonQuery();
                covCmd.ExecuteNonQuery();
                if (evaluationCheckbox.Checked)
                {
                    checkBoxCmd.ExecuteNonQuery();
                }

                connection.Close();

            }
            Response.Redirect(Request.UrlReferrer.ToString());

        }

    }
}

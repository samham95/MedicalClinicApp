using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace WebApplication1
{
    public partial class ReportView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int reportID = Convert.ToInt32(Request.QueryString["ReportID"]);

            string connectionString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";

            string titleQuery = "SELECT CONCAT(fname,' ', lname, ' - Appointment on ', AppointmentDate) FROM patients, appointment WHERE appointment.ReportID = @reportID AND appointment.patientID = patients.patientID";
            string patientNameQuery = "SELECT CONCAT(fname, ' ', lname) FROM appointment, patients WHERE appointment.reportID = @reportID AND appointment.patientID = patients.patientID";
            string doctorNameQuery = "SELECT CONCAT('Dr. ', Fname, ' ', Lname, ' - ', Specialty) from doctor, appointment WHERE appointment.reportID = @reportID AND appointment.doctorID = doctor.doctorID ";
            
            string diagnosisQuery = "SELECT Diagnosis FROM visit_details WHERE visit_details.ReportID = @reportID" ;
            string tempQuery = "SELECT temperature FROM visit_details WHERE visit_details.ReportID = @reportID";
            string pressureQuery = "SELECT bloodPressure FROM visit_details WHERE visit_details.ReportID = @reportID";
            string rateQuery = "SELECT heartRate FROM visit_details WHERE visit_details.ReportID = @reportID";
            string symptomsQuery = "SELECT symptoms FROM visit_details WHERE visit_details.ReportID = @reportID";
            string prescriptionQuery = "SELECT prescription FROM visit_details WHERE visit_details.ReportID = @reportID";
           
            string totalQuery = "SELECT total FROM invoice WHERE invoice.ReportID = @reportID";
            string claimQuery = "SELECT claim FROM invoice WHERE invoice.ReportID = @reportID";
            string copayQuery = "SELECT paid_amount FROM invoice WHERE invoice.ReportID = @reportID";

            string furtherEvalQuery = "SELECT test FROM evaluation WHERE code = (SELECT furtherEval FROM visit_details WHERE visit_details.ReportID = @reportID)";

            MySqlConnection connection = new MySqlConnection(connectionString);

            MySqlCommand titleCommand = new MySqlCommand(titleQuery, connection);
            titleCommand.Parameters.AddWithValue("@reportID", reportID);

            MySqlCommand patientNameCmd = new MySqlCommand(patientNameQuery, connection);
            patientNameCmd.Parameters.AddWithValue("@reportID", reportID);

            MySqlCommand doctorNameCmd = new MySqlCommand(doctorNameQuery, connection);
            doctorNameCmd.Parameters.AddWithValue("@reportID", reportID);
            
            MySqlCommand diagnosiscmd = new MySqlCommand(diagnosisQuery, connection);
            diagnosiscmd.Parameters.AddWithValue("@reportID", reportID);

            MySqlCommand tempCmd = new MySqlCommand(tempQuery, connection);
            tempCmd.Parameters.AddWithValue("@reportID", reportID);

            MySqlCommand pressureCmd = new MySqlCommand(pressureQuery, connection);
            pressureCmd.Parameters.AddWithValue("@reportID", reportID);

            MySqlCommand rateCmd = new MySqlCommand(rateQuery, connection);
            rateCmd.Parameters.AddWithValue("@reportID", reportID);

            MySqlCommand symptCmd = new MySqlCommand(symptomsQuery, connection);
            symptCmd.Parameters.AddWithValue("@reportID", reportID);

            MySqlCommand prescrCmd = new MySqlCommand(prescriptionQuery, connection);
            prescrCmd.Parameters.AddWithValue("@reportID", reportID);

            MySqlCommand totalCmd = new MySqlCommand(totalQuery, connection);
            totalCmd.Parameters.AddWithValue("@reportID", reportID);

            MySqlCommand claimCmd = new MySqlCommand(claimQuery, connection);
            claimCmd.Parameters.AddWithValue("@reportID", reportID);

            MySqlCommand copayCmd = new MySqlCommand(copayQuery, connection);
            copayCmd.Parameters.AddWithValue("@reportID", reportID);


            MySqlCommand checkBoxCmd = new MySqlCommand(furtherEvalQuery, connection);
            checkBoxCmd.Parameters.AddWithValue("@reportID", reportID);

            connection.Open();

            string headerStr = (string)titleCommand.ExecuteScalar();
            string patientName = (string)patientNameCmd.ExecuteScalar();
            string docName = (string)doctorNameCmd.ExecuteScalar();
            
            string diagnosis = (string)diagnosiscmd.ExecuteScalar();
            int temperature = Convert.ToInt32(tempCmd.ExecuteScalar());
            string bloodPress = (string)pressureCmd.ExecuteScalar();
            int heartRate = Convert.ToInt32(rateCmd.ExecuteScalar());
            string symptoms = (string)symptCmd.ExecuteScalar();
            string prescription = (string)prescrCmd.ExecuteScalar();

            int total = Convert.ToInt32(totalCmd.ExecuteScalar());
            int coverage = Convert.ToInt32(claimCmd.ExecuteScalar());
            int copay = Convert.ToInt32(copayCmd.ExecuteScalar());


            string eval = (string)checkBoxCmd.ExecuteScalar();

            connection.Close();
            
            
            reportHeader.InnerText = "Report for " + headerStr;
            patientNameBox.Text = patientName;
            doctorNameBox.Text = docName;
            
            diagnosisBox.Text = diagnosis;
            temperatureBox.Text = temperature.ToString() + "\u00B0F";
            pressureBox.Text = bloodPress.ToString() + " mmHg";
            heartrateBox.Text = heartRate.ToString() + " bpm";
            symptomsBox.Text = symptoms;
            prescriptionBox.Text = prescription;

            apptTotalBox.Text = "$"+total.ToString();
            insuranceCovBox.Text ="$"+coverage.ToString();
            copayBox.Text = "$"+copay.ToString();

            evalBox.Text = eval;

        }

        protected void returnBttn_Click(object sender, EventArgs e)
        {

            int nurseID = Convert.ToInt32(Request.QueryString["nurseID"]);
            int patientID = Convert.ToInt32(Request.QueryString["patientID"]);
            int doctorID = Convert.ToInt32(Request.QueryString["doctorID"]);

            if (nurseID != 0)
                Response.Redirect("nurseView.aspx?nurseID=" + nurseID);
            else if (patientID != 0)
                Response.Redirect("PatientPortal.aspx?patientID=" + patientID);
            else if (doctorID != 0)
                Response.Redirect("ProviderView.aspx?doctorID=" + doctorID);

        }
    }

}
﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using MySql.Data.MySqlClient;


namespace WebApplication1
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Get the patient email address from the form submission
            string email = Request.QueryString["email"];

            // Get patientID for new patient
            string connString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb;Uid=dbadmin;Pwd=Medical123!;";
            MySqlConnection connection = new MySqlConnection(connString);
            connection.Open();
            string query = $"SELECT patientID FROM Patients WHERE email = '{email}'";
            MySqlCommand command = new MySqlCommand(query, connection);
            MySqlDataReader reader = command.ExecuteReader();
            reader.Read();
            string patientID = reader["patientID"].ToString();
            reader.Close();
            connection.Close();


            // Send an email to the patient
            MailMessage mail = new MailMessage();
            mail.To.Add(email);
            mail.Subject = "New Patient Form Submission Received";
            mail.Body = "Thank you for submitting your form. We have received your information and a doctor will approve or deny your appointment request shortly. Your new PatientID is " + patientID;
            SmtpClient smtp = new SmtpClient();
            smtp.Send(mail);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string connString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb;Uid=dbadmin;Pwd=Medical123!;";
            MySqlConnection conn = new MySqlConnection(connString);

            try
            {
                string sql = "INSERT INTO login (username, passwrd, patientID) VALUES (@username, @passwrd, @patientID)";
                MySqlCommand command = new MySqlCommand(sql, conn);


                command.Parameters.AddWithValue("@username", UserName.Text);
                command.Parameters.AddWithValue("@passwrd", Password.Text);
                command.Parameters.AddWithValue("@patientID", PatientID.Text);

                conn.Open();
                command.ExecuteNonQuery();
                conn.Close();
                Response.Redirect("WebForm1.aspx?patientID="+PatientID.Text);
            }
            catch (Exception ex)
            {
                //Response.Write("Error accepting your response. Please try again later.");
                Response.Write("Error: " + ex.ToString());
                //Response.Redirect("unsuccessful.aspx");
            }
        }
    }
}
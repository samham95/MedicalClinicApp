using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
namespace WebApplication1
{
    public partial class AdminScheduleReport : System.Web.UI.Page
    {
        private string adminID;
        protected void Page_Load(object sender, EventArgs e)
        {
            adminID = Request.QueryString["adminID"];
        }

        protected void ButtonExit_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminView.aspx?adminID=" + adminID);
        }
        protected void btnGenerateReport_Click(object sender, EventArgs e)
        {
            List<DataTable> dataTables = GetDataFromMySQL();
            MemoryStream pdfStream = GeneratePDF(dataTables);
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=Report.pdf");
            Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
            Response.BinaryWrite(pdfStream.ToArray());
            Response.End();
        }

        private List<DataTable> GetDataFromMySQL()
        {
            List<DataTable> dataTables = new List<DataTable>();
            // Replace with your MySQL credentials
            string connectionString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                connection.Open();
                string selectedValue = DropDownList3.SelectedValue;
                string query = "";
                if (selectedValue == "Doctor")
                {
                    query = "SELECT \r\n  d.DoctorID, d.Fname, d.Lname, d.Specialty, d.Phone_num,\r\n  SUBSTRING_INDEX(o1.officeAddress, ',', 1) AS Monday,\r\n  SUBSTRING_INDEX(o2.officeAddress, ',', 1) AS Tuesday,\r\n  SUBSTRING_INDEX(o3.officeAddress, ',', 1) AS Wednesday,\r\n  SUBSTRING_INDEX(o4.officeAddress, ',', 1) AS Thursday,\r\n  SUBSTRING_INDEX(o5.officeAddress, ',', 1) AS Friday\r\nFROM schedule s\r\nJOIN doctor d ON s.doctor = d.DoctorID\r\nLEFT JOIN office o1 ON s.Monday = o1.officeID\r\nLEFT JOIN office o2 ON s.Tuesday = o2.officeID\r\nLEFT JOIN office o3 ON s.Wednesday = o3.officeID\r\nLEFT JOIN office o4 ON s.Thursday = o4.officeID\r\nLEFT JOIN office o5 ON s.Friday = o5.officeID;";
                }
                else if (selectedValue == "Nurse")
                {
                    query = "SELECT\r\n    n.NID,\r\n    n.Fname,\r\n    n.Lname,\r\n    n.Work_email,\r\n    SUBSTRING_INDEX(o.officeAddress, ',', 1) AS office,\r\n    n.pay\r\nFROM\r\n    nurse AS n\r\nJOIN\r\n    office AS o ON n.officeID = o.officeID;\r\n";
                }
                else if (selectedValue == "Staff")
                {
                    query = "SELECT\r\n    s.StaffID,\r\n    s.FName,\r\n    s.LName,\r\n    s.Work_email,\r\n    SUBSTRING_INDEX(o.officeAddress, ',', 1) AS office,\r\n    s.Pay\r\nFROM\r\n    staff AS s\r\nJOIN\r\n    office AS o ON s.officeID = o.officeID;";
                }
                else if (selectedValue == "Patient")
                {
                    query = "SELECT\r\n    p.PatientID,\r\n    p.fName AS patient_first_name,\r\n    p.lName AS patient_last_name,\r\n    p.DOB,\r\n    p.Phone_num,\r\n    d.DoctorID,\r\n    CONCAT(d.Fname, ' ', d.Lname) AS doctor_full_name,\r\n    p.balance,\r\n    p.payment\r\nFROM\r\n    patients AS p\r\nJOIN\r\n    doctor AS d ON p.doctorID = d.DoctorID;";
                }
                else // Default to login table
                {
                    query = "SELECT \r\n  d.DoctorID, d.Fname, d.Lname, d.Specialty, d.Phone_num,\r\n  SUBSTRING_INDEX(o1.officeAddress, ',', 1) AS Monday,\r\n  SUBSTRING_INDEX(o2.officeAddress, ',', 1) AS Tuesday,\r\n  SUBSTRING_INDEX(o3.officeAddress, ',', 1) AS Wednesday,\r\n  SUBSTRING_INDEX(o4.officeAddress, ',', 1) AS Thursday,\r\n  SUBSTRING_INDEX(o5.officeAddress, ',', 1) AS Friday\r\nFROM schedule s\r\nJOIN doctor d ON s.doctor = d.DoctorID\r\nLEFT JOIN office o1 ON s.Monday = o1.officeID\r\nLEFT JOIN office o2 ON s.Tuesday = o2.officeID\r\nLEFT JOIN office o3 ON s.Wednesday = o3.officeID\r\nLEFT JOIN office o4 ON s.Thursday = o4.officeID\r\nLEFT JOIN office o5 ON s.Friday = o5.officeID;";
                }
                MySqlCommand command = new MySqlCommand(query, connection);
                MySqlDataAdapter adapter = new MySqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);
                dataTables.Add(dataTable);

                if (selectedValue == "Doctor")
                {
                    string officeQuery = "SELECT \r\n  office_address,\r\n  COUNT(CASE WHEN Monday = office_address THEN 1 END) AS Monday,\r\n  COUNT(CASE WHEN Tuesday = office_address THEN 1 END) AS Tuesday,\r\n  COUNT(CASE WHEN Wednesday = office_address THEN 1 END) AS Wednesday,\r\n  COUNT(CASE WHEN Thursday = office_address THEN 1 END) AS Thursday,\r\n  COUNT(CASE WHEN Friday = office_address THEN 1 END) AS Friday\r\nFROM (\r\n  SELECT\r\n    SUBSTRING_INDEX(o1.officeAddress, ',', 1) AS Monday,\r\n    SUBSTRING_INDEX(o2.officeAddress, ',', 1) AS Tuesday,\r\n    SUBSTRING_INDEX(o3.officeAddress, ',', 1) AS Wednesday,\r\n    SUBSTRING_INDEX(o4.officeAddress, ',', 1) AS Thursday,\r\n    SUBSTRING_INDEX(o5.officeAddress, ',', 1) AS Friday\r\n  FROM schedule s\r\n  JOIN doctor d ON s.doctor = d.DoctorID\r\n  LEFT JOIN office o1 ON s.Monday = o1.officeID\r\n  LEFT JOIN office o2 ON s.Tuesday = o2.officeID\r\n  LEFT JOIN office o3 ON s.Wednesday = o3.officeID\r\n  LEFT JOIN office o4 ON s.Thursday = o4.officeID\r\n  LEFT JOIN office o5 ON s.Friday = o5.officeID\r\n) AS doctor_schedule\r\nCROSS JOIN (SELECT '123 Main St.' AS office_address UNION SELECT '134 Baker St.') AS office_list\r\nGROUP BY office_address;";
                    // Create a new MySqlCommand object with the new query and the existing connection
                    MySqlCommand officeCommand = new MySqlCommand(officeQuery, connection);
                    // Create a new MySqlDataAdapter object with the new command
                    MySqlDataAdapter officeAdapter = new MySqlDataAdapter(officeCommand);
                    // Create a new DataTable object, fill it with the adapter, and add it to the dataTables list
                    DataTable officeDataTable = new DataTable();
                    officeAdapter.Fill(officeDataTable);
                    dataTables.Add(officeDataTable);
                }
                else if (selectedValue == "Nurse")
                {
                    string officeQuery = "SELECT\r\n    AVG(pay) AS average_pay,\r\n    MAX(pay) AS highest_pay,\r\n    MIN(pay) AS lowest_pay\r\nFROM\r\n    nurse;";
                    MySqlCommand officeCommand = new MySqlCommand(officeQuery, connection);
                    // Create a new MySqlDataAdapter object with the new command
                    MySqlDataAdapter officeAdapter = new MySqlDataAdapter(officeCommand);
                    // Create a new DataTable object, fill it with the adapter, and add it to the dataTables list
                    DataTable officeDataTable = new DataTable();
                    officeAdapter.Fill(officeDataTable);
                    dataTables.Add(officeDataTable);
                }
                else if (selectedValue == "Staff")
                {
                    string officeQuery = "SELECT\r\n    AVG(Pay) AS average_pay,\r\n    MAX(Pay) AS highest_pay,\r\n    MIN(Pay) AS lowest_pay\r\nFROM\r\n    staff\r\nWHERE\r\n    Pay IS NOT NULL;";
                    MySqlCommand officeCommand = new MySqlCommand(officeQuery, connection);
                    // Create a new MySqlDataAdapter object with the new command
                    MySqlDataAdapter officeAdapter = new MySqlDataAdapter(officeCommand);
                    // Create a new DataTable object, fill it with the adapter, and add it to the dataTables list
                    DataTable officeDataTable = new DataTable();
                    officeAdapter.Fill(officeDataTable);
                    dataTables.Add(officeDataTable);
                }
                else if (selectedValue == "Patient")
                {
                    string officeQuery = "SELECT\r\n    SUM(balance) AS payment_uncollected,\r\n    SUM(payment) AS payment_received,\r\n    COUNT(CASE WHEN balance = 0 THEN 1 ELSE NULL END) AS patients_paid_all,\r\n    COUNT(CASE WHEN balance <> 0 THEN 1 ELSE NULL END) AS patients_not_paid_all\r\nFROM\r\n    patients;";
                    MySqlCommand officeCommand = new MySqlCommand(officeQuery, connection);
                    // Create a new MySqlDataAdapter object with the new command
                    MySqlDataAdapter officeAdapter = new MySqlDataAdapter(officeCommand);
                    // Create a new DataTable object, fill it with the adapter, and add it to the dataTables list
                    DataTable officeDataTable = new DataTable();
                    officeAdapter.Fill(officeDataTable);
                    dataTables.Add(officeDataTable);
                }
                else // Default to login table
                {
                    string officeQuery = "SELECT \r\n  office_address,\r\n  COUNT(CASE WHEN Monday = office_address THEN 1 END) AS Monday,\r\n  COUNT(CASE WHEN Tuesday = office_address THEN 1 END) AS Tuesday,\r\n  COUNT(CASE WHEN Wednesday = office_address THEN 1 END) AS Wednesday,\r\n  COUNT(CASE WHEN Thursday = office_address THEN 1 END) AS Thursday,\r\n  COUNT(CASE WHEN Friday = office_address THEN 1 END) AS Friday\r\nFROM (\r\n  SELECT\r\n    SUBSTRING_INDEX(o1.officeAddress, ',', 1) AS Monday,\r\n    SUBSTRING_INDEX(o2.officeAddress, ',', 1) AS Tuesday,\r\n    SUBSTRING_INDEX(o3.officeAddress, ',', 1) AS Wednesday,\r\n    SUBSTRING_INDEX(o4.officeAddress, ',', 1) AS Thursday,\r\n    SUBSTRING_INDEX(o5.officeAddress, ',', 1) AS Friday\r\n  FROM schedule s\r\n  JOIN doctor d ON s.doctor = d.DoctorID\r\n  LEFT JOIN office o1 ON s.Monday = o1.officeID\r\n  LEFT JOIN office o2 ON s.Tuesday = o2.officeID\r\n  LEFT JOIN office o3 ON s.Wednesday = o3.officeID\r\n  LEFT JOIN office o4 ON s.Thursday = o4.officeID\r\n  LEFT JOIN office o5 ON s.Friday = o5.officeID\r\n) AS doctor_schedule\r\nCROSS JOIN (SELECT '123 Main St.' AS office_address UNION SELECT '134 Baker St.') AS office_list\r\nGROUP BY office_address;";
                    // Create a new MySqlCommand object with the new query and the existing connection
                    MySqlCommand officeCommand = new MySqlCommand(officeQuery, connection);
                    // Create a new MySqlDataAdapter object with the new command
                    MySqlDataAdapter officeAdapter = new MySqlDataAdapter(officeCommand);
                    // Create a new DataTable object, fill it with the adapter, and add it to the dataTables list
                    DataTable officeDataTable = new DataTable();
                    officeAdapter.Fill(officeDataTable);
                    dataTables.Add(officeDataTable);
                }

            }

            return dataTables;
        }

        private MemoryStream GeneratePDF(List<DataTable> dataTables)
        {
            MemoryStream pdfStream = new MemoryStream();
            Document pdfDoc = new Document(PageSize.A2, 10f, 10f, 10f, 0f);
            PdfWriter.GetInstance(pdfDoc, pdfStream);

            pdfDoc.Open();

            Font titleFont = FontFactory.GetFont("Arial", 18, Font.BOLD);
            string selectedValue = DropDownList3.SelectedValue;
            string title = "";
            if (selectedValue == "Doctor")
            {
                title = "Report of Doctor Scheduling";
            }
            else if (selectedValue == "Nurse")
            {
                title = "Report of Nurse Scheduling";
            }
            else if (selectedValue == "Staff")
            {
                title = "Report of Staff Scheduling";
            }
            else if (selectedValue == "Patient")
            {
                title = "Report of Patient Appointment Scheduling";
            }
            else // Default to doctor table
            {
                title = "Report of Doctor Scheduling";
            }
            Paragraph titleParagraph = new Paragraph(title, titleFont);
            titleParagraph.Alignment = Element.ALIGN_CENTER;
            titleParagraph.SpacingAfter = 10;
            pdfDoc.Add(titleParagraph);
            int tableIndex = 0;

            // Loop through each DataTable in the list
            foreach (DataTable dataTable in dataTables)
            {
                tableIndex++;
                // Create a new PdfPTable for each DataTable
                PdfPTable table = new PdfPTable(dataTable.Columns.Count);

                if (tableIndex == 2)
                {
                    Font subTitleFont = FontFactory.GetFont("Arial", 14, Font.BOLD);
                    Paragraph subTitleParagraph = new Paragraph("Number of Doctors Work in Certain Day", subTitleFont);
                    if (selectedValue == "Doctor")
                    {
                        subTitleParagraph = new Paragraph("Number of Doctors Work in Certain Day", subTitleFont);
                    }
                    else if (selectedValue == "Nurse")
                    {
                        subTitleParagraph = new Paragraph("Nurse Pay Summary", subTitleFont);
                    }
                    else if (selectedValue == "Staff")
                    {
                        subTitleParagraph = new Paragraph("Staff Pay Summary", subTitleFont);
                    }
                    else if (selectedValue == "Patient")
                    {
                        subTitleParagraph = new Paragraph("Patient Payment Summary", subTitleFont);
                    }
                    else // Default to doctor table
                    {
                        subTitleParagraph = new Paragraph("Number of Doctors Work in Certain Day", subTitleFont);
                    }

                    subTitleParagraph.Alignment = Element.ALIGN_CENTER;
                    subTitleParagraph.SpacingAfter = 10;
                    pdfDoc.Add(subTitleParagraph);
                }
                // Add header row
                foreach (DataColumn column in dataTable.Columns)
                {
                    PdfPCell cell = new PdfPCell(new Phrase(column.ColumnName));
                    cell.BackgroundColor = new BaseColor(240, 240, 240);
                    table.AddCell(cell);
                }

                // Add data rows
                foreach (DataRow row in dataTable.Rows)
                {
                    foreach (object cellData in row.ItemArray)
                    {
                        table.AddCell(cellData.ToString());
                    }
                }

                // Add the PdfPTable to the PDF document
                pdfDoc.Add(table);

                // Add some spacing between tables
                pdfDoc.Add(new Chunk("\n"));
            }

            pdfDoc.Close();

            return pdfStream;
        }

    }
}

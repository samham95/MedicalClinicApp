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
    public partial class AdminReportsaspx : System.Web.UI.Page
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
            DataTable dataTable = GetDataFromMySQL();
            MemoryStream pdfStream = GeneratePDF(dataTable);
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=Report.pdf");
            Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
            Response.BinaryWrite(pdfStream.ToArray());
            Response.End();
        }

        private DataTable GetDataFromMySQL()
        {
            // Replace with your MySQL credentials
            string connectionString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                connection.Open();
                string selectedValue = DropDownList3.SelectedValue;
                string query = "";
                if (selectedValue == "Doctor")
                {
                    query = "SELECT * FROM doctor";
                }
                else if (selectedValue == "Nurse")
                {
                    query = "SELECT * FROM nurse";
                }
                else if (selectedValue == "Staff")
                {
                    query = "SELECT * FROM staff";
                }
                else // Default to login table
                {
                    query = "SELECT * FROM login";
                }
                MySqlCommand command = new MySqlCommand(query, connection);
                MySqlDataAdapter adapter = new MySqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);
                return dataTable;
            }
        }

        private MemoryStream GeneratePDF(DataTable dataTable)
        {
            MemoryStream pdfStream = new MemoryStream();
            Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
            PdfWriter.GetInstance(pdfDoc, pdfStream);

            pdfDoc.Open();

            Font titleFont = FontFactory.GetFont("Arial", 18, Font.BOLD);
            string selectedValue = DropDownList3.SelectedValue;
            string title = "";
            if (selectedValue == "Doctor")
            {
                title = "Report of Doctor";
            }
            else if (selectedValue == "Nurse")
            {
                title = "Report of Nurse";
            }
            else if (selectedValue == "Staff")
            {
                title = "Report of Staff";
            }
            else // Default to doctor table
            {
                title = "Report of Doctor";
            }
            Paragraph titleParagraph = new Paragraph(title, titleFont);
            titleParagraph.Alignment = Element.ALIGN_CENTER;
            titleParagraph.SpacingAfter = 20;
            pdfDoc.Add(titleParagraph);

            PdfPTable table = new PdfPTable(dataTable.Columns.Count);

            foreach (DataColumn column in dataTable.Columns)
            {
                PdfPCell cell = new PdfPCell(new Phrase(column.ColumnName));
                cell.BackgroundColor = new BaseColor(240, 240, 240);
                table.AddCell(cell);
            }

            foreach (DataRow row in dataTable.Rows)
            {
                foreach (object cellData in row.ItemArray)
                {
                    table.AddCell(cellData.ToString());
                }
            }

            pdfDoc.Add(table);
            pdfDoc.Close();

            return pdfStream;
        }

    }
}
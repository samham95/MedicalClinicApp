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
    public partial class AdminInvoiceReport : System.Web.UI.Page
    {
        private string adminID;
        protected void Page_Load(object sender, EventArgs e)
        {
            adminID = Request.QueryString["adminID"];

            if (!IsPostBack)
            {
                // populate office locations
                string connString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
                string query = "SELECT officeAddress from office";
                MySqlConnection connection = new MySqlConnection(connString);
                MySqlCommand command = new MySqlCommand(query, connection);
                connection.Open();
                MySqlDataReader reader = command.ExecuteReader();
                List<string> officelocs = new List<string>();
                officelocs.Add("");
                while (reader.Read())
                {
                    officelocs.Add(reader["officeAddress"].ToString());
                }
                DropDownList1.DataSource = officelocs;
                DropDownList1.DataBind();
                reader.Close();
                connection.Close();
                DropDownList1.SelectedIndex = 0;
            }
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
                string selectedValue = DropDownList1.SelectedValue;
                string query = "";
                query = "Select I.total, I.claim, I.paid_amount From invoice as I, visit_details as V, appointment as A, office as O WHERE I.reportID = V.reportID and V.appointmentID = A.appointmentID and A.officeID = O.officeID and O.officeAddress = @officeAddress union SELECT SPACE(10) AS spaces, SPACE(10) AS spaces, SPACE(10) AS spaces union Select SUM(I.total), SUM(I.claim), SUM(I.paid_amount) From invoice as I, visit_details as V, appointment as A, office as O WHERE I.reportID = V.reportID and V.appointmentID = A.appointmentID and A.officeID = O.officeID and O.officeAddress = @officeAddress";

                MySqlCommand command = new MySqlCommand(query, connection);
                command.Parameters.AddWithValue("@officeAddress", selectedValue);

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
            string selectedValue = DropDownList1.SelectedValue;
            string title = "";
            title = "Financial Report of " + selectedValue;

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
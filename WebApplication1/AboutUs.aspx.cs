using System;
using System.Data;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace WebApplication1
{
    public partial class AboutUs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSpecialties();
            }
        }

        private void LoadSpecialties()
        {
            // Construct the connection string
            string connectionString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";

            // Construct the query
            string query = "SELECT DISTINCT specialty FROM doctor ORDER BY specialty";

            // Retrieve the specialties from the database
            DataTable specialtiesData = new DataTable();
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            using (MySqlCommand command = new MySqlCommand(query, connection))
            {
                MySqlDataAdapter adapter = new MySqlDataAdapter(command);
                adapter.Fill(specialtiesData);
            }

            // Generate the specialties list
            string specialtiesListHtml = "<ul>";
            foreach (DataRow row in specialtiesData.Rows)
            {
                specialtiesListHtml += "<li>" + row["specialty"].ToString() + "</li>";
            }
            specialtiesListHtml += "</ul>";

            // Add the specialties list to the page
            specialtiesList.Text = specialtiesListHtml;
        }
    }
}
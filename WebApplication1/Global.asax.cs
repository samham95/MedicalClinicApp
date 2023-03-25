using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace WebApplication1
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            // Start timer to execute appointment deletion
            string connectionString = "Server=medicaldatabase3380.mysql.database.azure.com;Database=medicalclinicdb2;Uid=dbadmin;Pwd=Medical123!;";
            AppointmentDataAccessLayer appointmentDataAccessLayer = new AppointmentDataAccessLayer(connectionString);
            int interval =  60*60*1000; // time in milliseconds
            System.Threading.Timer timer = new System.Threading.Timer((obj) => {appointmentDataAccessLayer.DeleteAppointments();}, null, 0, interval);
        }
    }

}

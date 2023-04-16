<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppointmentReport.aspx.cs" Inherits="WebApplication1.AppointmentReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Past Appointment Reports</title>
    <link href="AdminPages.css" rel="stylesheet" />
	<link href="navbar.css" rel="stylesheet" />
</head>
<body>
    <!-- Define the navigation bar at the top of the page -->
    <div class="navbar">
	  <div class="navbar-right">
		<a href="HomePage.aspx" class="nav-item">Home</a>
		<a href="AboutUs.aspx" class="nav-item">About Us</a>
		<a href="ContactUs.aspx" class="nav-item">Contact Us</a>
		<a href="PatientLogin.aspx" class="nav-item">Patient Login</a>
		<a href="ProviderLogin.aspx" class="nav-item">Provider Login</a>
	  </div>
	</div>
    <br />
    <br />
    <br />
    <form id="form1" runat="server">
        <div role="document">
            <h1>Appointment Report</h1>
            <p>Please choose where indicated</p>
            <div class="form-container">
                <div>
                    <br />
                    <label for="jobtype">Choose Office</label>
                    <asp:DropDownList ID="Office" runat="server">
                        <asp:ListItem>All Offices</asp:ListItem>
                        <asp:ListItem>123 Main St., Houston, TX, 77070</asp:ListItem>
                        <asp:ListItem>134 Baker St., Miami, FL, 34532</asp:ListItem>
                        <asp:ListItem>567 Pine Street, Houston, TX 77002</asp:ListItem>
                        <asp:ListItem>1234 Elm Avenue, Miami, FL 33129</asp:ListItem>
                    </asp:DropDownList>
                    <label for="start-date">Start Date:</label>
                    <input type="date" id="start-date" name="start-date">

                    <label for="end-date">End Date:</label>
                    <input type="date" id="end-date" name="end-date">
                    <br />
                    <br />
                </div>
                <div >
                    <asp:Button ID="btnGenerateReport" runat="server" Text="Generate" OnClick="btnGenerateReport_Click"/>
                </div>
            </div>
            <asp:Button ID="exit" runat="server" OnClick="ButtonExit_Click" Text="Return to Admin Page"/>
            </div>
    </form>
</body>
</html>

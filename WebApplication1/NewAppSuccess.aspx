<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewAppSuccess.aspx.cs" Inherits="WebApplication1.WebForm9" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SUCCESS</title>
    <link href="navbar.css" rel="stylesheet" />
    <link href="AdminPages.css" rel="stylesheet" />
</head>
<body>
        <!-- Define the navigation bar at the top of the page -->
    <div class="navbar">
	  <div class="navbar-right">
		<a href="#" class="nav-item">Home</a>
		<a href="#" class="nav-item">About Us</a>
		<a href="#" class="nav-item">Contact Us</a>
		<a href="PatientLogin.aspx" class="nav-item">Patient Login</a>
		<a href="ProviderLogin.aspx" class="nav-item">Provider Login</a>
	  </div>
    </div>
    <br />
    <br />
    <br />

        Response Saved Successfully! An email confirmation with your appointment request was sent. Your primary care provider will reach out to you shortly with confirmation of your appointment.<br />
    <br />
    <br />
    <form id="form1" runat="server">
        <div>
            <asp:HyperLink ID="HyperLink1" runat="server">Click Here to Return to Your Patient Portal</asp:HyperLink>
        </div>
    </form>
</body>
</html>

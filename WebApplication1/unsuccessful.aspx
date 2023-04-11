<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="unsuccessful.aspx.cs" Inherits="WebApplication1.WebForm4" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    	<link href="navbar.css" rel="stylesheet" />
        <link href="AdminPages.css" rel="stylesheet" />
</head>
<body>
        <div class="navbar">
	  <div class="navbar-right">
		<a href="HomePage.aspx" class="nav-item">Home</a>
		<a href="#" class="nav-item">About Us</a>
		<a href="#" class="nav-item">Contact Us</a>
		<a href="PatientLogin.aspx" class="nav-item">Patient Login</a>
		<a href="ProviderLogin.aspx" class="nav-item">Provider Login</a>
	  </div>
	</div>
       <h1>&nbsp;</h1>
        <h1>Response could not be saved successfully. Please try again. Follow the correct input format. <a href="NewPatient.aspx"> Click here to return to the form submission. </a></h1>

    <form id="form1" runat="server">
        <div>
        </div>
    </form>
</body>
</html>

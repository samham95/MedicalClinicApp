<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PatientLogin.aspx.cs" Inherits="WebApplication1.WebForm5" %>

<!-- Define the HTML document type -->
<!DOCTYPE html>

<!-- Define the HTML document -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Patient-Login</title>

    <link href="LoginStyle.css" rel="stylesheet" />
	<link href="navbar.css" rel="stylesheet" />
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
	<form id="form1" runat="server">
	<div class="login-container">
		<table class="login-table">
			<!-- Table Row for Sign In Title -->
			<tr>
				<td align="center" colspan="2" style="font-weight: bold;">Patient Login</td>
			</tr>
			<!-- Table Row for Username -->
			<tr>
				<td class="auto-style1">
					<div class="input-container">
						<asp:TextBox ID="UserName" runat="server" placeholder="Username"></asp:TextBox>
					</div>
				</td>
			</tr>
			<!-- Table Row for Password -->
			<tr>
				<td class="auto-style1">
					<div class="input-container">
						<asp:TextBox ID="Password" runat="server" TextMode="Password" placeholder="Password"></asp:TextBox>
					</div>
				</td>
			</tr>
			<!-- Table Row for Error Message -->
			<tr>
				<td class="error-message">
					<asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
				</td>
			</tr>

			<!-- Button for Submitting Form -->
			<tr>
				<div class="auto-style1">
					<td class="submit-button">
						<asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit"/>
					</td>
				</div>
			</tr>
			<!-- Link to Register -->
			<tr>
				<td class="auto-style1">
					<div style="padding: 10px">
						Are you a new patient? <a href="NewPatient.aspx">Register here.</a>
					</div>
				</td>
			</tr>
		</table>
	</div>
	</form>
</body>
</html>
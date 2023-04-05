﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DoctorLogin.aspx.cs" Inherits="WebApplication1.ProviderLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Doctor Login</title>
    <link href="LoginStyle.css" rel="stylesheet" />
	<link href="navbar.css" rel="stylesheet" />
</head>

<body>
    <!-- Define the navigation bar at the top of the page -->
	<div class="navbar">
        <a href="HomePage.aspx">Home</a>
        <a href="#">About Us</a>
        <a href="#">Contact Us</a>
        <a href="PatientLogin.aspx">Patient Login</a>
        <a href="ProviderLogin.aspx">Provider Login</a>
    </div>

    <br />
	<form id="form1" runat="server">
	<div class="login-container">
		<table class="login-table">
			<!-- Table Row for Sign In Title -->
			<tr>
				<td align="center" colspan="2" style="font-weight: bold;">Doctor Login</td>
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
		</table>
	</div>
	</form>
</body>
</html>
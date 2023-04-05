<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NurseLogin.aspx.cs" Inherits="WebApplication1.WebForm8" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Nurse Login</title>
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
<<<<<<< HEAD
	<form id="form1" runat="server">
	<div class="login-container">
		<table class="login-table">
			<!-- Table Row for Sign In Title -->
			<tr>
				<td align="center" colspan="2" style="font-weight: bold;">Nurse Login</td>
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
=======
    <h1>Nurse Login</h1>
    <p>
        Please sign in here. If you are a doctor, please instead use <a href="DoctorLogin.aspx">this login wizard.</a>
    </p>
    <br />
    <form id="form1" runat="server">
     
    <table>
        <tr>
            <td align="left-center" colspan="2" style =" border-left">Sign In with Your Username and Password</td>
        </tr>
        <tr>
            <td align="right" class="auto-style1">
                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>
                
            </td>
            <td class="auto-style2">
                <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="Username_valid" runat="server"
                    ControlToValidate="UserName"
                    ErrorMessage="Please enter a valid username." style="color:Red;">
                </asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
            </td>
            <td class="auto-style3">
                <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="password_valid" runat="server"
                    ControlToValidate="Password"
                    ErrorMessage="Please enter a valid password." style="color:Red;">
                </asp:RequiredFieldValidator>
            </td>
        </tr>
>>>>>>> 7d3053af6d7f8daf75c72a6e2f3d9e50217fe9b0

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
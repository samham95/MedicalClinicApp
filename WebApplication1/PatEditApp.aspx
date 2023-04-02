<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PatEditApp.aspx.cs" Inherits="WebApplication1.PatEditApp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<style>

            /* Styles for the navigation bar */
      .navbar {
        background-color: #333;
        overflow: hidden;
                height: 48px;
            }
      .navbar a {
        float: right;
        color: white;
        text-align: center;
        padding: 14px 16px;
        text-decoration: none;
        font-size: 17px;
      }
      .navbar a:hover {
        background-color: #ddd;
        color: black;
      }
      /* Styles for the form */
      .form-container {
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
        box-sizing: border-box;
      }
      .form-container label {
        display: block;
        margin-bottom: 10px;
        font-size: 16px;
        font-weight: bold;
      }
      .form-container input[type="text"],
      .form-container input[type="email"],
      .form-container input[type="date"] {
        width: 30%;
        padding: 10px;
        margin-bottom: 20px;
        box-sizing: border-box;
      }
      .form-container input[type="checkbox"] {
        margin-right: 10px;
      }
      .form-container input[type="submit"] {
        background-color: #333;
        color: white;
        border: none;
        padding: 10px 20px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
      }
      .form-container input[type="submit"]:hover {
        background-color: #555;
      }
      .required {
        color: red;
      }

    </style>
</head>
<body>
    <form runat = "server">
	<div class="navbar">
      <a href="#">About Us</a>
      <a href="#">Contact Us</a>
      <a href="PatientLogin.aspx">Patient Login</a>
      <a href="ProviderLogin.aspx">Provider Login</a>
      <a href="HomePage.aspx">Home</a>
    </div>
        <h1>Reschedule Your Appointment</h1>
        <br />
        <br />
   			<fieldset>
			<legend>Appointment Reschedule</legend>
            <div class="form-group">
				<label for="date-requested">Date Requested <span class="required">*</span></label>&nbsp;
                <asp:TextBox ID="date_requested" runat="server" TextMode="Date" DataFormatString="yyyy-MM-dd" AutoPostBack="True" ></asp:TextBox>
			    <span class="required"><asp:Literal ID="ErrorMessage_date2" runat="server" ></asp:Literal></span>
			</div>

			<div class="form-group">
				<label for="time-requested">
                <br />
                Time Requested <span class="required">*</span></label>&nbsp;
                <asp:DropDownList ID="ddlTimeRequested" runat="server" Width="140px" AutoPostBack="True"></asp:DropDownList>
			    <span class="required"><asp:Literal ID="ErrorMessage_date" runat="server" ></asp:Literal></span>
			    <br />
                <br />
			</div>
			<p><span class="required">*</span> Required information</p>
            <p>
                <asp:Button ID="SUBMIT" runat="server" Text="SUBMIT" OnClick="SUBMIT_Click" Width="112px" />
            </p>
                <p>
                    &nbsp;</p>
			</fieldset>
			<asp:Button ID="Return" runat="server" Text="Return to Patient Portal" Width="239px" OnClick="Return_Click" />
			</form>
</body>
</html>

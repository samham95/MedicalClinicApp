<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PCPfollowup.aspx.cs" Inherits="WebApplication1.PCPfollowup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PCP Follow-Up</title>
    	
	<link href="navbar.css" rel="stylesheet" />
    <link href="AdminPages.css" rel="stylesheet" />

</head>
<body>
    <form runat = "server">
    <div class="navbar">
	  <div class="navbar-right">
		<a href="HomePage.aspx" class="nav-item">Home</a>
		<a href="#" class="nav-item">About Us</a>
		<a href="#" class="nav-item">Contact Us</a>
		<a href="PatientLogin.aspx" class="nav-item">Patient Login</a>
		<a href="ProviderLogin.aspx" class="nav-item">Provider Login</a>
	  </div>
	</div>
        <h1 style ="font-size: 32px; width: 907px;" runat="server">
            &nbsp;</h1>
        <p runat="server">
            <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click"></asp:LinkButton>
        &nbsp;</p>
        <h1>Schedule a Follow-Up with Your Primary Physician</h1>
        <br />
        <br />
        <div class="form-container">
   			<fieldset>
			<legend>Schedule Appointment </legend>

            <br />
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
             <asp:Button ID="SUBMIT" runat="server" Text="SUBMIT" OnClick="SUBMIT_Click" />
			</fieldset>
        
            </div>
        <asp:Button ID="exit" runat="server" Text="Return to Patient Portal" OnClick="Return_Click" />
			
			</form>
</body>
</html>

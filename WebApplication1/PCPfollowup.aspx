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
      <a href="AboutUs.aspx">About Us</a>
      <a href="ContactUs.aspx">Contact Us</a>
      <a href="PatientLogin.aspx">Patient Login</a>
      <a href="ProviderLogin.aspx">Provider Login</a>
      <a href="HomePage.aspx">Home</a>
      <left><asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click"></asp:LinkButton></left>
    </div>
        <h1 style ="font-size: 32px; width: 907px;" runat="server">
            &nbsp;</h1>

        <h1 style="text-align:center">Schedule a Follow-Up with Your Primary Physician</h1>
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
            <div class ="form-group">
                Office Location
                <asp:TextBox ID="officeLocation" runat="server"></asp:TextBox>
            </div>
			<p><span class="required">*</span> Required information</p>
             <asp:Button ID="SUBMIT" runat="server" Text="SUBMIT" OnClick="SUBMIT_Click" />
			</fieldset>
        
            </div>
			
			</form>
</body>
</html>

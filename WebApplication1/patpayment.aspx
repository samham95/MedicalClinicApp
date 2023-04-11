<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="patpayment.aspx.cs" Inherits="WebApplication1.patpayment" %>

<!DOCTYPE html>
<html>
<head>
	<title>Payment Page</title>
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script> 
	<link href="navbar.css" rel="stylesheet" />
    <link href="AdminPages.css" rel="stylesheet" />

</head>
<body>
    <p>
        <br />
    </p>

		<form id="form2" runat="server">
                <div class="navbar">
                            <div class ="navbar-left"><asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click"></asp:LinkButton></div>

	  <div class="navbar-right">
		<a href="HomePage.aspx" class="nav-item">Home</a>
		<a href="AboutUs.aspx" class="nav-item">About Us</a>
		<a href="ContactUs.aspx" class="nav-item">Contact Us</a>
		<a href="PatientLogin.aspx" class="nav-item">Patient Login</a>
		<a href="ProviderLogin.aspx" class="nav-item">Provider Login</a>
	  </div>
	</div>
        <p  runat="server">
        &nbsp;</p>

<h1 style = "text-align: center">Make Your Payment Today</h1>
	<p style = "text-align: center">Please fill out where indicated</p>

	<div class="form-container" style="margin: auto;">
		<fieldset>
		<legend>Payment Details</legend>
			<div class="form-group">
				<label for="first-name">
                <br />
                Full Name <span class="required">*</span></label>&nbsp;
                <asp:TextBox ID="fname" runat="server" ReadOnly="true" ></asp:TextBox>
			</div>
            <div class="form-group">
                <label for="paymentamount">Payment Amount <span class="required">*</span></label>&nbsp;
                <asp:TextBox ID="paymentAmount" runat="server"></asp:TextBox>
                <span class="required"><asp:RegularExpressionValidator ID="paymentAmountValidator" runat="server" 
                    ControlToValidate="paymentAmount" ErrorMessage="Please enter a valid payment amount." 
                    ValidationExpression="^\d+(\.\d{1,2})?$" /></span>
            </div>
			<div class="form-group">
				<label for="cardno">Card Number <span class="required">*</span></label>&nbsp;
                <asp:TextBox ID="cardnum" runat="server" placeholder="4332 3243 3564 4351" MaxLength="12"></asp:TextBox>
                <span class="required"><asp:RegularExpressionValidator ID="cardValidator" runat="server" 
                ControlToValidate="cardnum" ErrorMessage="Please enter a valid card number." 
                    ValidationExpression="^\d{12}$" /></span>
			</div>
			<div class="form-group">
				<label for="expirationdate">Card Number <span class="required">*</span></label>&nbsp;
                <asp:TextBox ID="exp" runat="server" placeholder="12/2032" MaxLength="7"></asp:TextBox>
                <span class="required"><asp:RegularExpressionValidator ID="expvalid" runat="server" 
                ControlToValidate="exp" ErrorMessage="Please enter a valid card number." 
                    ValidationExpression="^(0[1-9]|1[0-2])\/(20[2-9]\d)$" /></span>
			</div>

			<div class="CCV"> 
				<label for="ccv"> CVV <span class="required">*</span></label>&nbsp;
                <asp:TextBox ID="ccv" runat="server" placeholder="123" MaxLength="4"></asp:TextBox>
                <span class="required"><asp:RegularExpressionValidator ID="ccvvalid" runat="server" 
                ControlToValidate="ccv" ErrorMessage="Please enter a valid CCV number." 
                    ValidationExpression="^\d{3,4}$"/></span>
                <br />
                <br />
			</div>
            <div class="form-group">
                <label for="zip">Billing Zip Code <span class="required">*</span></label>&nbsp;
                <asp:TextBox ID="billingzip" runat="server" placeholder="77379" MaxLength="5" />
                <span class="required"><asp:RegularExpressionValidator ID="zipvalid" runat="server" ControlToValidate="billingzip"
                    ValidationExpression="^\d{5}$" ErrorMessage="Please enter a valid zip code" /></span>
            </div>
			<p><span class="required">*</span> Required information</p>
            <p>
                <asp:Button ID="SUBMIT" runat="server" Text="SUBMIT" OnClick="SUBMIT_Click" />
            </p>
			</fieldset>
     </div>
    <asp:Button ID="exit" runat="server" Text="Return to Billing Portal" Width="239px" OnClick="Return_Click" style="margin-left: 0px" />
                <script>
                //Client-side jQuery to cancel form submission if required fields empty 
                $(function () {
                    // Attach event handler to form submit button click
                    $('#<%=SUBMIT.ClientID %>').on('click', function () {
                        // Check if required fields are filled out
                        if ($('#<%=paymentAmount.ClientID %>').val() === "" || $('#<%=ccv.ClientID %>').val() === "" || $('#<%=cardnum.ClientID %>').val() === ""
                            || $('#<%=exp.ClientID %>').val() === "" || $('#<%=billingzip.ClientID %>').val() === "") {
                            // Display dialog box
                            alert('Please fill out all required fields.');
                            return false; // Cancel form submission
                        }
                    });
                });
                </script>
         </form>

</body>
</html>


 <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewPatient.aspx.cs" Inherits="WebApplication1.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server" >
<title>NEW PATIENT FORM</title>
	<meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<style>


      

    </style>
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
    <h1 style = "text-align: center">&nbsp;</h1>
    <h1 style = "text-align: center">Schedule your appointment today</h1>
	<p style = "text-align: center">Please fill out where indicated</p>

	<div class="form-container">
		<form id="form2" runat="server">
		<fieldset>
		<legend>Contact Information</legend>
			<div class="form-group">
				<label for="first-name">
                <br />
                First Name <span class="required">*</span></label>&nbsp;
                <asp:TextBox ID="fname" runat="server" ></asp:TextBox>
			</div>

			<div class="form-group">
				<label for="middle-initial">Middle Initial</label>&nbsp;
                <asp:TextBox ID="mi" runat="server"></asp:TextBox>
			</div>

			<div class="form-group">
				<label for="last-name">Last Name <span class="required">*</span></label>&nbsp;
                <asp:TextBox ID="lname" runat="server"></asp:TextBox>
				</div>

			<div class="form-group">
				<label for="date-of-birth">Date of Birth <span class="required">*</span></label>&nbsp;
                <asp:TextBox ID="dob" runat="server" TextMode="Date" DataFormatString="{yyyy/MM/dd}"></asp:TextBox>
			</div>
            
            <div class="form-group">
                <label for="phone">Phone Number <span class="required">*</span></label>&nbsp;
                <asp:TextBox ID="phone_num" runat="server" placeholder="1234567890" MaxLength="10" />
                <span class="required"><asp:RegularExpressionValidator ID="phoneValidator" runat="server" ControlToValidate="phone_num"
                    ValidationExpression="^\d{10}$" ErrorMessage="Please enter a valid phone number" /></span>
            </div>



			<div class="form-group">
				<label for="email">Email <span class="required">*</span></label>&nbsp;
                <asp:TextBox ID="email" runat="server" placeholder="you@example.com"></asp:TextBox>
                <span class="required"><asp:RegularExpressionValidator ID="emailValidator" runat="server" 
                ControlToValidate="email" ErrorMessage="Please enter a valid email address." 
                    ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" /></span>
			</div>

			<div class="form-group"> 
				<label for="address"> Address <span class="required">*</span></label>&nbsp;
                <asp:TextBox ID="address" runat="server"></asp:TextBox>
                <br />
                <br />
			</div>

			<div class="form-group">
				<label for="Emergency-Contact">Emergency Contact <span class="required">*</span></label>&nbsp;
                <asp:TextBox ID="emergency_contact" runat="server"></asp:TextBox>
			</div>
			<div class="form-group">
				<label for="ECRelation">Emergency Contact Relation <span class="required">*</span></label>&nbsp;
                <asp:TextBox ID="ECRelation" runat="server"></asp:TextBox>
			</div>
            <div class="form-group">
                <label for="ECphone">Emergency Contact Phone Number <span class="required">*</span></label>&nbsp;
                <asp:TextBox ID="ECphone" runat="server" placeholder="1234567890" MaxLength="10" />
               <span class="required"> <asp:RegularExpressionValidator ID="ecphonevalidator" runat="server" ControlToValidate="phone_num"
                    ValidationExpression="^\d{10}$" ErrorMessage="Please enter a valid phone number" /></span>
            </div>

			<div class="form-group">
				<label for="ECemail">Emergency Contact Email <span class="required">*</span></label>&nbsp;
                <asp:TextBox ID="ECemail" runat="server" placeholder="you@example.com"></asp:TextBox>
                <span class="required"><asp:RegularExpressionValidator ID="ecemailvalidator" runat="server" 
                ControlToValidate="ECemail" ErrorMessage="Please enter a valid email address." 
                    ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" /></span>
			</div>
			</fieldset>
 
            <br />
            <br />
			<fieldset>
			<legend>Appointment Details</legend>

            <div class="form-group">
				<label for="officelabel">
                <br />
                Select a primary office location <span class="required">*</span></label>&nbsp;
                <asp:DropDownList ID="DropDownList1" runat="server" Width="140px" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True">
                </asp:DropDownList>
			    <br />
                <br />
			</div>

            <div class="form-group">
				<label for="Pcplabel">
                <br />
                Select a Primary Care Physician <span class="required">*</span></label>&nbsp;
                <asp:DropDownList ID="primary" runat="server" Width="140px" AutoPostBack="True" ></asp:DropDownList>
			    <br />
                <br />
			</div>

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


			<div class="form-group">
				<label for="pcp-or-specialist">Do you want to see a PCP or specialist?<span class="required">*</span></label>
                <asp:CheckBox ID="pcp" runat="server" />
                <label for="pcp-or-specialist">PCP
                </label>
                <asp:CheckBox ID="spec" runat="server" />
                <label for="pcp-or-specialist">Specialist<br />
                <br />
                </label>
                </div>

            <div class="form-group">
				<label for="referral">
                <br />
                If you&#39;re seeing a specialist, do you have a referral?</label>
                <asp:CheckBox ID="CheckBox5" runat="server" />
                <label for="referral">Yes</label>
                <asp:CheckBox ID="CheckBox6" runat="server" />
                <label for="referral">No<br />
                <br />
                </label>
			</div>

			<div class="form-group">
				<label for="insurance">Do you have insurance?<span class="required">*</span></label>
                <asp:CheckBox ID="ins" runat="server" />
                <label for="insurance">Yes
                </label>
                <asp:CheckBox ID="no_ins" runat="server" />
                <label for="insurance">No<br />
                </label>
			</div>

			<div class="form-group">
				<label for="insurance-name">Insurance Name</label>
				<input type="text" name="insurance-name" id="insurance-name"/>

				<label for="insurance-type">Insurance Type</label>
				<input type="text" name="insurance-type" id="insurance-type"/>
			</div>

			<p><span class="required">*</span> Required information</p>
            <p>
                <asp:Button ID="SUBMIT" runat="server" Text="SUBMIT" OnClick="SUBMIT_Click" />
            </p>
			</fieldset>
			&nbsp;</form>
	</div>
            <script>
            //Client-side jQuery to cancel form submission if required fields empty 
                $(function () {
                    // Attach event handler to form submit button click
                    $('#<%=SUBMIT.ClientID %>').on('click', function () {
                        // Check if required fields are filled out
                        if ($('#<%=fname.ClientID %>').val() === '' || $('#<%=lname.ClientID %>').val() === '' || $('#<%=email.ClientID %>').val() === ''
                            || $('#<%=phone_num.ClientID %>').val() === '' || $('#<%=address.ClientID %>').val() === '' || $('#<%=DropDownList1.ClientID %>').val() === ""
                            || $('#<%=ddlTimeRequested.ClientID %>').val() === "" || $('#<%=primary.ClientID %>').val() === "" || $('#<%=date_requested.ClientID %>').val() === ""){
                            // Display dialog box
                            alert('Please fill out all required fields.');
                            return false; // Cancel form submission
                        }
                    });
                });
            </script>
</body>
</html>

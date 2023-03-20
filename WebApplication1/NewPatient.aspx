<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewPatient.aspx.cs" Inherits="WebApplication1.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server" >
<title></title>
	<meta charset="utf-8"/>
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
	<div class="navbar">
      <a href="#">About Us</a>
      <a href="#">Contact Us</a>
      <a href="PatientLogin.aspx">Patient Login</a>
      <a href="#">Provider Login</a>
      <a href="WebForm1.aspx">Home</a>
    </div>
	
    <h1>Schedule your appointment today</h1>
	<p>Please fill out where indicated</p>

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
                <asp:RegularExpressionValidator ID="phoneValidator" runat="server" ControlToValidate="phone_num"
                    ValidationExpression="^\d{10}$" ErrorMessage="Please enter a valid phone number" />
            </div>



			<div class="form-group">
				<label for="email">Email <span class="required">*</span></label>&nbsp;
                <asp:TextBox ID="email" runat="server" placeholder="you@example.com"></asp:TextBox>
                <asp:RegularExpressionValidator ID="emailValidator" runat="server" 
                ControlToValidate="email" ErrorMessage="Please enter a valid email address." 
                    ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" />
			</div>

			<div class="form-group"> 
				<label for="address"> Address <span class="required">*</span></label>&nbsp;
                <asp:TextBox ID="address" runat="server"></asp:TextBox>
                <br />
                <br />
			</div>
			</fieldset>

			<fieldset>
			<legend>Appointment Details</legend>
			<div class="form-group">
				<label for="time-requested">
                <br />
                Time Requested <span class="required">*</span></label>&nbsp;
                <asp:DropDownList ID="ddlTimeRequested" runat="server" Width="140px"></asp:DropDownList>
			    <br />
                <br />
			</div>

			<div class="form-group">
				<label for="date-requested">Date Requested <span class="required">*</span></label>&nbsp;
                <asp:TextBox ID="date_requested" runat="server" TextMode="Date" DataFormatString="yyyy-MM-dd"></asp:TextBox>
			</div>

            <div class="form-group">
				<label for="Pcplabel">
                <br />
                Select a Primary Care Physician <span class="required">*</span></label>&nbsp;
                <asp:DropDownList ID="primary" runat="server" DataSourceID="SqlDataSource1" DataTextField="PCP" DataValueField="PCP" Width="140px"></asp:DropDownList>
			    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:medicalclinicdbConnectionString %>" ProviderName="<%$ ConnectionStrings:medicalclinicdbConnectionString.ProviderName %>" SelectCommand="SELECT CONCAT(fname, ' ', lname, ' ') as PCP FROM doctor;"></asp:SqlDataSource>
			    <br />
                <br />
			</div>

			<div class="form-group">
				<label for="pcp-or-specialist">Do you want to see a PCP or specialist?<span class="required">*</span></label>
                <asp:CheckBox ID="pcp" runat="server" />
                <label for="pcp-or-specialist">PCP<br />
                </label>
                &nbsp;<asp:CheckBox ID="spec" runat="server" />
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
			&nbsp;</div>

			<div class="form-group">
				<label for="insurance">Do you have insurance?<span class="required">*</span></label>
                <asp:CheckBox ID="ins" runat="server" />
                <label for="insurance">Yes<br />
                </label>
                &nbsp;<asp:CheckBox ID="no_ins" runat="server" />
                <label for="insurance">No<br />
                </label>
			&nbsp;</div>

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
                            || $('#<%=phone_num.ClientID %>').val() === '' || $('#<%=address.ClientID %>').val() === '' || ($('#<%=pcp.ClientID %>').val() === '') && $('#<%=spec.ClientID %>').val() === ''
                            || $('#<%=date_requested.ClientID %>').val() === '' || $('#<%=dob.ClientID %>').val() === '' || ($('#<%=ins.ClientID %>').val() === '') && $('#<%=no_ins.ClientID %>').val() === ''{
                            // Display dialog box
                            alert('Please fill out all required fields.');
                            return false; // Cancel form submission
                        }
                    });
                });
            </script>
</body>
</html>

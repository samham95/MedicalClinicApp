<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PatEdit.aspx.cs" Inherits="WebApplication1.PatAppEditaspx" %>

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
	<link href="navbar.css" rel="stylesheet" />

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

   <form id="form2" runat="server">
    <h1 style ="font-size: 32px; width: 907px;" runat="server">
        &nbsp;</h1>
       <p runat="server">
            <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click"></asp:LinkButton>
        </p>
	<div class="form-container">

    <h1 style = "text-align: center">Edit your Personal Information</h1>
            <p style = "text-align: center">Please fill out where indicated</p>


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
                <asp:RegularExpressionValidator ID="ecphonevalidator" runat="server" ControlToValidate="phone_num"
                    ValidationExpression="^\d{10}$" ErrorMessage="Please enter a valid phone number" />
            </div>

			<div class="form-group">
				<label for="ECemail">Emergency Contact Email <span class="required">*</span></label>&nbsp;
                <asp:TextBox ID="ECemail" runat="server" placeholder="you@example.com"></asp:TextBox>
                <asp:RegularExpressionValidator ID="ecemailvalidator" runat="server" 
                ControlToValidate="ECemail" ErrorMessage="Please enter a valid email address." 
                    ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" />
			</div>
			</fieldset>

            <p>
                <asp:Button ID="SUBMIT" runat="server" Text="SUBMIT" OnClick="SUBMIT_Click" />
            </p>

            <script>
                //Client-side jQuery to cancel form submission if required fields empty 
                $(function () {
                    // Attach event handler to form submit button click
                    $('#<%=SUBMIT.ClientID %>').on('click', function () {
                        // Check if required fields are filled out
                        if ($('#<%=fname.ClientID %>').val() === '' || $('#<%=lname.ClientID %>').val() === '' || $('#<%=email.ClientID %>').val() === ''
                            || $('#<%=phone_num.ClientID %>').val() === '' || $('#<%=address.ClientID %>').val() === '') {
                            // Display dialog box
                            alert('Please fill out all required fields.');
                            return false; // Cancel form submission
                        }
                    });
                });
            </script>
            </div>
   </form>
 
</body>
</html>

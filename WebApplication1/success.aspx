<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="success.aspx.cs" Inherits="WebApplication1.WebForm3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SUCCESS</title>
    <style>     

        .required {
        color: red;
         }

        .auto-style1 {
            width: 737px;
        }

    </style>
	<link href="navbar.css" rel="stylesheet" />
    <link href="AdminPages.css" rel="stylesheet" />

</head>
<body style="Bold">
    <div class="navbar">
	  <div class="navbar-right">
		<a href="HomePage.aspx" class="nav-item">Home</a>
		<a href="#" class="nav-item">About Us</a>
		<a href="#" class="nav-item">Contact Us</a>
		<a href="PatientLogin.aspx" class="nav-item">Patient Login</a>
		<a href="ProviderLogin.aspx" class="nav-item">Provider Login</a>
	  </div>
	</div>
    <br />
    <br />
    <p>Response Saved Successfully! An email confirmation was sent with your new patientID code. Use that to complete the account set up below. We will reach out to you shortly with confirmation of your appointment.
</p>
    <br />
    <br />
    <a href="WebForm1.aspx"> Click here to return home </a>
    <br />
    <br />
    <form id="form1" runat="server">
    <div class="form-container">
        <fieldset>
            <legend>Sign Up for Your New Account</legend>
        <div>
            <p>
                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:<span class="required">*</span></asp:Label>
                
            <p>
            <p>
                <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="Username_valid" runat="server"
                    ControlToValidate="UserName"
                    ErrorMessage="Please enter a valid username." style="color:Red;">
                </asp:RequiredFieldValidator>
            </p>
        </div>
        <div>
            <p>
                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:<span class="required">*</span></asp:Label>
            </p>
            <p>
                <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="password_valid" runat="server"
                    ControlToValidate="Password"
                    ErrorMessage="Please enter a valid password." style="color:Red;">
                </asp:RequiredFieldValidator>
            </p>
        </div>
        <div>
            <p>
                <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">Confirm Password:<span class="required">*</span></asp:Label>
            </p>
            <div>
                <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="cpv" runat="server"
                    ControlToValidate="ConfirmPassword"
                    ErrorMessage="Please enter a valid password." style="color:Red;">
                </asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidator1" runat="server" 
                    ControlToCompare="Password" 
                    ControlToValidate="ConfirmPassword" 
                    ErrorMessage="Passwords do not match." 
                    style="color:Red;" Font-Bold="True"></asp:CompareValidator>
            </div>
        </div>
        <div>
            <p>
                <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">E-mail:<span class="required">*</span></asp:Label>
                
            </p>
            <div>
                <asp:TextBox ID="Email" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="emailvalid" runat="server"
                    ControlToValidate="Email"
                    ErrorMessage="Please enter a valid email." style="color:Red;">
                </asp:RequiredFieldValidator>
            </div>
        </div>
        <div>
            <p>
                <asp:Label ID="PatientLabel" runat="server" AssociatedControlID="PatientID">PatientID:<span class="required">*</span></asp:Label>
            
            </p>
            <p>
                <asp:TextBox ID="PatientID" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="patientvalid" runat="server"
                    ControlToValidate="PatientID"
                    ErrorMessage="Please enter a valid patientID." style="color:Red;">
                </asp:RequiredFieldValidator>

            </p>
        </div>
        <div>
            <p align="left" colspan="2" style="color:Red;">
                <asp:Literal ID="ErrorMessage" runat="server" Text="Passwords must match"></asp:Literal>
            </p>
        </div>
        <asp:Button ID="SUBMIT" runat="server" OnClick="Button1_Click" Text="Submit" />
    </fieldset>
    </div>
    </form>
</body>
</html>



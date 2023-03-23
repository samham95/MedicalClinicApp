<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="success.aspx.cs" Inherits="WebApplication1.WebForm3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SUCCESS</title>
    <style>     
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
        .required {
        color: red;
         }

        .auto-style1 {
            width: 737px;
        }

    </style>
</head>
<body style="Bold">
    	<div class="navbar">
      <a href="#">About Us</a>
      <a href="#">Contact Us</a>
      <a href="PatientLogin.aspx">Patient Login</a>
      <a href="ProviderLogin.aspx">Provider Login</a>
      <a href="HomePage.aspx">Home</a>
    </div>
    <br />

    Response Saved Successfully! An email confirmation was sent with your new patientID code. Use that to complete the account set up below. We will reach out to you shortly with confirmation of your appointment.
    <br />
    <br />
    <a href="WebForm1.aspx"> Click here to return home </a>
    <br />
    <br />
    <form id="form1" runat="server">
     
    <table>
        <tr>
            <td align="left" colspan="2">Sign Up for Your New Account</td>
        </tr>
        <tr>
            <td align="right">
                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:<span class="required">*</span></asp:Label>
                
            </td>
            <td class="auto-style1">
                <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="Username_valid" runat="server"
                    ControlToValidate="UserName"
                    ErrorMessage="Please enter a valid username." style="color:Red;">
                </asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:<span class="required">*</span></asp:Label>
            </td>
            <td class="auto-style1">
                <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="password_valid" runat="server"
                    ControlToValidate="Password"
                    ErrorMessage="Please enter a valid password." style="color:Red;">
                </asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">Confirm Password:<span class="required">*</span></asp:Label>
            </td>
            <td class="auto-style1">
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
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">E-mail:<span class="required">*</span></asp:Label>
                
            </td>
            <td class="auto-style1">
                <asp:TextBox ID="Email" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="emailvalid" runat="server"
                    ControlToValidate="Email"
                    ErrorMessage="Please enter a valid email." style="color:Red;">
                </asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Label ID="PatientLabel" runat="server" AssociatedControlID="PatientID">PatientID:<span class="required">*</span></asp:Label>
            
            </td>
            <td class="auto-style1">
                <asp:TextBox ID="PatientID" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="patientvalid" runat="server"
                    ControlToValidate="PatientID"
                    ErrorMessage="Please enter a valid patientID." style="color:Red;">
                </asp:RequiredFieldValidator>

            </td>
        </tr>
        
        <tr>
            <td align="center" colspan="2">
            </td>
        </tr>
        <tr>
            <td align="left" colspan="2" style="color:Red;">
                <asp:Literal ID="ErrorMessage" runat="server" Text="Passwords must match"></asp:Literal>
            </td>
        </tr>
    </table>

        <div style="margin-left: 240px">
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" />
        </div>

    </form>
        </body>
</html>



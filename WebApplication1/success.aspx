<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="success.aspx.cs" Inherits="WebApplication1.WebForm3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SUCCESS</title>
</head>
<body style="Bold">
    Response Saved Successfully! An email confirmation was sent with your new patientID code. Use that to complete the account set up below. We will reach out to you shortly with confirmation of your appointment.
    <br />
    <br />
    <a href="WebForm1.aspx"> Click here to return home </a>
    <br />
    <br />
    <form id="form1" runat="server">
     
    <table>
        <tr>
            <td align="center" colspan="2">Sign Up for Your New Account</td>
        </tr>
        <tr>
            <td align="right">
                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>
                
            </td>
            <td>
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
            <td>
                <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="password_valid" runat="server"
                    ControlToValidate="Password"
                    ErrorMessage="Please enter a valid password." style="color:Red;">
                </asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">Confirm Password:</asp:Label>
            </td>
            <td>
                <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="cpv" runat="server"
                    ControlToValidate="ConfirmPassword"
                    ErrorMessage="Please enter a valid password." style="color:Red;">
                </asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">E-mail:</asp:Label>
                
            </td>
            <td>
                <asp:TextBox ID="Email" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="emailvalid" runat="server"
                    ControlToValidate="Email"
                    ErrorMessage="Please enter a valid email." style="color:Red;">
                </asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Label ID="PatientLabel" runat="server" AssociatedControlID="PatientID">PatientID:</asp:Label>
            
            </td>
            <td>
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
            <td align="center" colspan="2" style="color:Red;">
                <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
            </td>
        </tr>
    </table>

        <div style="margin-left: 240px">
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" />
        </div>

    </form>
        </body>
</html>



<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PatientLogin.aspx.cs" Inherits="WebApplication1.WebForm5" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Patient-Login</title>
    <style type="text/css">
        .auto-style1 {
            height: 39px;
        }
        .auto-style2 {
            height: 39px;
            width: 576px;
        }
        .auto-style3 {
            width: 576px;
        }
        .header h1 {
            text-transform: uppercase;
            font-family: times;
          }
    </style>
</head>
<body style="Bold">
<h1>Please sign in here. If you are a new patient, please fill out the <a href="NewPatient.aspx">new patient form here.</a>
</h1>
    <br />
    <form id="form1" runat="server">
     
    <table>
        <tr>
            <td align="left-center" colspan="2" style =" border-left">Sign In with Your Username and Password</td>
        </tr>
        <tr>
            <td align="right" class="auto-style1">
                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>
                
            </td>
            <td class="auto-style2">
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
            <td class="auto-style3">
                <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="password_valid" runat="server"
                    ControlToValidate="Password"
                    ErrorMessage="Please enter a valid password." style="color:Red;">
                </asp:RequiredFieldValidator>
            </td>
        </tr>

        <tr>
            <td align="left-center" colspan="2" style="color:Red;">
                <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
            </td>
        </tr>
    </table>

        <div style="margin-left: 140px; width: 105px;">
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" style="margin-left: 0px" />
        </div>

    </form>
</body>
</html>


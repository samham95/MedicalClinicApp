<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewAppSuccess.aspx.cs" Inherits="WebApplication1.WebForm9" %>

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

        Response Saved Successfully! An email confirmation with your appointment request was sent. Your primary care provider will reach out to you shortly if you require a referral.<br />
    <br />
    <form id="form1" runat="server">
        <div>
            <asp:HyperLink ID="HyperLink1" runat="server">Click Here to Return to Your Patient Portal</asp:HyperLink>
        </div>
    </form>
</body>
</html>

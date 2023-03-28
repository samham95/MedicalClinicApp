<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewOffice.aspx.cs" Inherits="WebApplication1.NewOffice" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

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
    </style>

    <title>Add Office</title>
</head>
<body>
    <div class="navbar">
        <a href="#">About Us</a>
        <a href="#">Contact Us</a>
        <a href="PatientLogin.aspx">Patient Login</a>
        <a href="ProviderLogin.aspx">Provider Login</a>
        <a href="HomePage.aspx">Home</a>
    </div>
        <br />
        <h1 id="WelcomeHeader" runat="server"> </h1>
        <br />
        <br />

        <form id="form1" runat="server">
            <div>
                <h1>Add New Office</h1>
                <p>Please fill out where indicated</p>
                <div class="form-container">
                    <fieldset>
                        <div class="form-group">
                            <label for="address"> Address <span class="required">*</span></label>&nbsp;
                            <asp:TextBox ID="address" runat="server"></asp:TextBox>
                        </div>
                        <p><span class="required">*</span> Required information</p>
                        <p><asp:Button ID="Button1" runat="server" Text="SUBMIT" OnClick="SUBMIT_Click_AddOff" /></p>
                    </fieldset>
                    &nbsp;
                </div>
                <div>
                    <asp:Button ID="clear" runat="server" OnClick="ButtonClear_Click" Text="Clear Entries" style="margin-left: 0px" />
                </div>
                <div>
                    <asp:Button ID="exit" runat="server" OnClick="ButtonExit_Click" Text="Exit" style="margin-left: 0px" />
                </div>
                <script>
                    //Client-side jQuery to cancel form submission if required fields empty
                    $(function () {
                        // Attach event handler to form submit button click
                        $('#<%=Button1.ClientID %>').on('click', function () {
                            // Check if required fields are filled out
                            if ($('#<%=address.ClientID %>').val() === '') {
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
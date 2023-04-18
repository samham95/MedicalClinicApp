<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminScheduleReport.aspx.cs" Inherits="WebApplication1.AdminScheduleReport" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="Content/navbar.css" rel="stylesheet" type="text/css" />
    <link href="Content/AdminPages.css" rel="stylesheet" type="text/css" />
    <title>Admin Reports</title>
</head>
<body>
    <!-- Define the navigation bar at the top of the page -->
    <div class="navbar">
      <a href="AboutUs.aspx">About Us</a>
      <a href="ContactUs.aspx">Contact Us</a>
      <a href="PatientLogin.aspx">Patient Login</a>
      <a href="ProviderLogin.aspx">Provider Login</a>
      <a href="HomePage.aspx">Home</a>
    </div>
    <br />
    <br />
    <br />
    <form id="form1" runat="server">
        <div role="document">
            <h1>Personel Reports</h1>
            <p1 style="font-size:24px">Generate Report about Personel Group</p1>
            <p>Please choose where indicated</p>
            <div class="form-container">
                <div>
                    <div>
                        <br />
                        <label for="jobtype">
                            Choose Report Type:
                        </label>&nbsp;

                        <div class="form-group">
                            <label for="officelabel">
                                <br />
                                Select a group <span class="required">*</span>
                            </label>&nbsp;
                            <asp:DropDownList ID="DropDownList3" runat="server" Width="140px" AutoPostBack="True">
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem>Doctor</asp:ListItem>
                                <asp:ListItem>Nurse</asp:ListItem>
                                <asp:ListItem>Staff</asp:ListItem>
                                <asp:ListItem>Patient</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div>
                        <asp:Button ID="btnGenerateReport" runat="server" Text="Generate" OnClick="btnGenerateReport_Click" />
                    </div>
                </div>
            </div>
            <asp:Button ID="exit" runat="server" OnClick="ButtonExit_Click" Text="Return to Admin Page" />
        </div>
        <asp:HyperLink ID="btnDownloadPDF" runat="server" Text="Download PDF" Visible="false" />

        <asp:Literal ID="TableLiteral" runat="server"></asp:Literal>

        <!-- Adding scripts to use bootstrap -->
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
                integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
                crossorigin="anonymous">
        </script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
                integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
                crossorigin="anonymous">
        </script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
                integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
                crossorigin="anonymous">
        </script>


    </form>
    <div class="footer">
  <section class="contact">
    <p>Email: info@coogmedicalgroup.com | Phone: (713)867-5309</p>
    <p>Coog Clinic © Group 13 - 2023. All rights reserved.</p>
    <p><a href="AdminLogin.aspx">Admin Login</a></p>
  </section>
</div>
</body>
</html>
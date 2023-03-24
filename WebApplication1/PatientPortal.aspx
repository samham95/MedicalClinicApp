<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PatientPortal.aspx.cs" Inherits="WebApplication1.WebForm7" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Patient Portal</title>
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
      }</style>
</head>
<body style:"Bold">
    <div class="navbar">
      <a href="#">About Us</a>
      <a href="#">Contact Us</a>
      <a href="PatientLogin.aspx">Patient Login</a>
      <a href="ProviderLogin.aspx">Provider Login</a>
      <a href="HomePage.aspx">Home</a>
    </div>
    <br />
   <h1 id="welcomeHeader" runat="server"> </h1>
    <br />
    <p><asp:HyperLink ID="HyperLink1" runat="server">Please click here to edit your personal information</asp:HyperLink></p>

    <form id="form1" runat="server">
    <br />
    <br />

        <div>
            <h1>Upcoming Appointments</h1>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="AppointmentID"
                OnRowCommand="GridView1_RowCommand" CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="appointmentID" HeaderText="AppointmentID" />
                    <asp:BoundField DataField="DoctorName" HeaderText="Doctor" />
                    <asp:BoundField DataField="Spec" HeaderText="PCP or Specialist" />
                    <asp:BoundField DataField="OfficeLocation" HeaderText="Office Location" />
                    <asp:BoundField DataField="Approval" HeaderText="Approval Status" />
                    <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:d}"/>
                    <asp:BoundField DataField="Time" HeaderText="Time" />
                    <asp:BoundField DataField="Confirm" HeaderText="Confirmed" />
                    <asp:ButtonField Text="EDIT" CommandName="EditAppointment" HeaderText="EDIT" />
                    <asp:ButtonField Text="CONFIRM" CommandName="ConfirmAppointment" HeaderText="Confirmation" />
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
        </div>
        <br />
        <br />
        <div>
            <h1>Previous Appointments</h1>
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="AppointmentID"
                OnRowCommand="GridView2_RowCommand" CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="appointmentID" HeaderText="AppointmentID" />
                    <asp:BoundField DataField="DoctorName" HeaderText="Doctor" />
                    <asp:BoundField DataField="Spec" HeaderText="PCP or Specialist" />
                    <asp:BoundField DataField="OfficeLocation" HeaderText="Office Location" />
                    <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:d}"/>
                    <asp:BoundField DataField="Time" HeaderText="Time" />
                    <asp:ButtonField Text="VIEW" CommandName="ViewReport" HeaderText="REPORT" />
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
        </div>


    </form>
</body>
</html>

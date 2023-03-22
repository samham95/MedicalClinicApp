<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProviderView.aspx.cs" Inherits="WebApplication1.WebForm6" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Provider View</title>
</head>
<body>
   <h1 id="welcomeHeader" runat="server"> </h1>
    <br />
    <br />

    <form id="form1" runat="server">
        <div>
            <h1>Upcoming Appointments</h1>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="AppointmentID"
                OnRowCommand="GridView1_RowCommand">
                <Columns>
                    <asp:BoundField DataField="appointmentID" HeaderText="AppointmentID" />
                    <asp:BoundField DataField="PatientName" HeaderText="Patient Name" />
                    <asp:BoundField DataField="OfficeLocation" HeaderText="Office Location" />
                    <asp:BoundField DataField="Approval" HeaderText="Approval Status" />
                    <asp:BoundField DataField="Time" HeaderText="Date/Time" />
                    <asp:ButtonField Text="Approve" CommandName="ApproveAppointment" HeaderText="Approval" />
                </Columns>
            </asp:GridView>
        </div>
        <div>
            <h1>Referral Review</h1>
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="AppointmentID2"
                OnRowCommand="GridView2_RowCommand">
                <Columns>
                    <asp:BoundField DataField="appointmentID2" HeaderText="AppointmentID" />
                    <asp:BoundField DataField="PatientName2" HeaderText="Patient Name" />
                    <asp:BoundField DataField="Specialist" HeaderText="Specialty" />
                    <asp:BoundField DataField="Referral" HeaderText="Referral Status" />
                    <asp:BoundField DataField="Doctor" HeaderText="Doctor" />
                    <asp:ButtonField Text="Approve" CommandName="ApproveAppointment2" HeaderText="Approval" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>

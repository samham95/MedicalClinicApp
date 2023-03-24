<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProviderView.aspx.cs" Inherits="WebApplication1.WebForm6" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">

    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <style>   
        .approve-button {
          background-color: green;
          color: white;
          padding: 10px 20px;
          border: none;
          border-radius: 5px;
          cursor: pointer;
        }
        .deny-button {
          background-color: red;
          color: white;
          padding: 10px 20px;
          border: none;
          border-radius: 5px;
          cursor: pointer;
        }
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
      .green-button {
        background-color: lightgreen;
       }
      .red-button{
          background-color: indianred;
      }



    </style>

    <title>Provider View</title>
</head>
<body style: "Bold">
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
    <br />

    <form id="form1" runat="server">
        <div>
            <h1>Upcoming Appointments</h1>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="AppointmentID"
                OnRowCommand="GridView1_RowCommand" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <Columns>
                    <asp:BoundField DataField="appointmentID" HeaderText="AppointmentID" />
                    <asp:BoundField DataField="PatientName" HeaderText="Patient Name" />
                    <asp:BoundField DataField="OfficeLocation" HeaderText="Office Location" />
                    <asp:BoundField DataField="Approval" HeaderText="Approval Status" />
                    <asp:BoundField DataField="Time" HeaderText="Time" />
                    <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:d}"/>
                    <asp:ButtonField ButtonType="button" Text="APPROVE" CommandName="ApproveAppointment" HeaderText="Approval" ControlStyle-BackColor="cyan">
<ControlStyle BackColor="Green"></ControlStyle>
                    </asp:ButtonField>
                    <asp:ButtonField ButtonType="button" Text="DENY" CommandName="DenyAppointment" HeaderText="Denial" ControlStyle-BackColor="Red" >


<ControlStyle BackColor="Red"></ControlStyle>
                    </asp:ButtonField>


                </Columns>
                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <sortedascendingcellstyle backcolor="#F1F1F1" />
                <sortedascendingheaderstyle backcolor="#808080" />
                <sorteddescendingcellstyle backcolor="#CAC9C9" />
                <sorteddescendingheaderstyle backcolor="#383838" />
            </asp:GridView>
        </div>

        <div>
            <h1>Referral Review</h1>
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="AppointmentID2"
                OnRowCommand="GridView2_RowCommand" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <Columns>
                    <asp:BoundField DataField="appointmentID2" HeaderText="AppointmentID" />
                    <asp:BoundField DataField="PatientName2" HeaderText="Patient Name" />
                    <asp:BoundField DataField="Specialist" HeaderText="Specialty" />
                    <asp:BoundField DataField="Referral" HeaderText="Referral Status" />
                    <asp:BoundField DataField="Date2" HeaderText="Date" DataFormatString="{0:d}"/>
                    <asp:BoundField DataField="Doctor" HeaderText="Doctor" />
                    <asp:ButtonField ButtonType="button" Text="APPROVE" CommandName="ApproveAppointment2" HeaderText="Approval" ControlStyle-BackColor="Green">
<ControlStyle BackColor="Green"></ControlStyle>
                    </asp:ButtonField>
                    <asp:ButtonField ButtonType="button" Text="DENY" CommandName="DenyAppointment2" HeaderText="Denial" ControlStyle-BackColor="Red" >
<ControlStyle BackColor="Red"></ControlStyle>
                    </asp:ButtonField>
                </Columns>
                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <sortedascendingcellstyle backcolor="#F1F1F1" />
                <sortedascendingheaderstyle backcolor="#808080" />
                <sorteddescendingcellstyle backcolor="#CAC9C9" />
                <sorteddescendingheaderstyle backcolor="#383838" />
            </asp:GridView>
        </div>
         <div>
            <h1>Previous Appointments</h1>
            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataKeyNames="AppointmentID"
                OnRowCommand="GridView3_RowCommand" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <Columns>
                    <asp:BoundField DataField="appointmentID" HeaderText="AppointmentID" />
                    <asp:BoundField DataField="PatientName" HeaderText="Patient Name" />
                    <asp:BoundField DataField="OfficeLocation" HeaderText="Office Location" />
                    <asp:BoundField DataField="Time" HeaderText="Time" />
                    <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:d}"/>
                    <asp:ButtonField ButtonType="button" Text="VIEW" CommandName="AppReport" HeaderText="REPORT" ControlStyle-BackColor="blue">
<ControlStyle BackColor="cyan"></ControlStyle>
                    </asp:ButtonField>



                </Columns>
                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <sortedascendingcellstyle backcolor="#F1F1F1" />
                <sortedascendingheaderstyle backcolor="#808080" />
                <sorteddescendingcellstyle backcolor="#CAC9C9" />
                <sorteddescendingheaderstyle backcolor="#383838" />
            </asp:GridView>
        </div>

        <script>
            $(document).ready(function () {
                // Attach click event handler to the approve and deny buttons
                $("input[type='button'][value='APPROVE'], input[type='button'][value='DENY']").click(function (e) {
                    // Prevent the button from performing its default action
                    e.preventDefault();
                    // Open the dialog box
                    var message = "ARE YOU SURE YOU WANT TO " + $(this).val() + " THIS APPOINTMENT? PRESS OK TO EMAIL THE PATIENT";
                    if (confirm(message)) {
                        // If the user confirms, submit the form
                        $(this).closest("form").submit();
                    }
                });
            });
        </script>

    </form>
</body>
</html>

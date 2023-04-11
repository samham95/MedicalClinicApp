<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="nurseReport.aspx.cs" Inherits="WebApplication1.nurseReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Patient Form</title>
    <link href="LoginStyle.css" rel="stylesheet" />
	<link href="navbar.css" rel="stylesheet" />

    <style type="text/css">
        #patientName {
            width: 521px;
        }
    </style>
</head>
<body>
    <!-- Define the navigation bar at the top of the page -->
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
    <br />
    <form id="patientForm" runat="server">
        <div style="font-weight: bold">
            <!--<h1>Report for spiderman on 3/28/23</h1> --> <!-- placeholder header -->
               <p> <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click"></asp:LinkButton>
</p>
    <br />

            <h1 id="reportHeader" runat="server"> </h1>
            <hr style="color: #000000" />
            <label for="patientName" style="font-weight: bold">
            <br />
            Patient Name:</label> <br />
            <asp:TextBox ID="patientNameBox" runat="server" BackColor="#CCCCCC" BorderColor="Black" BorderStyle="Solid" BorderWidth="2px" MaxLength="100"  ReadOnly="True" Width="362px"></asp:TextBox>

            <label for= "patientAge">
            <br />
            </label>
            <label for="patientGender">
            <br />
            Doctor Name:</label><br />

            <asp:TextBox ID="doctorNameBox" runat="server" BackColor="#CCCCCC" BorderColor="Black" BorderWidth="2px" MaxLength="10"  ReadOnly="True" Width="370px"></asp:TextBox>
            <br />

            <label for="patientCondition">
            <br />
            Patient Condition/Diagnosis: 
             <br />
            </label>
            <asp:TextBox ID="diagnosisBox" runat="server" BackColor="#CCCCCC" BorderWidth="2px" Height="72px" MaxLength="200" TextMode="MultiLine" Width="428px"></asp:TextBox>
            
            <label for="patientSymptoms">
            <br />
            <br />
            Temperature:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Blood Pressure:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Heart Rate:
            <br />

             <div style="display:inline">
                  <asp:TextBox ID="temperatureBox" runat="server" Width="86px" style="margin-right: 40px" BackColor="#CCCCCC" BorderColor="Black" BorderWidth="2px"></asp:TextBox>
                 <asp:TextBox ID="pressureBox" runat="server" Width="86px" style="margin-right: 40px" BackColor="#CCCCCC" BorderColor="Black" BorderWidth="2px"></asp:TextBox>
                 <asp:TextBox ID="heartrateBox" runat="server" Width="86px" BackColor="#CCCCCC" BorderColor="Black" BorderWidth="2px"></asp:TextBox>
             </div>
            
            <br />
            <br />
            Patient Symptoms:</label><br />
            <asp:TextBox ID="symptomsBox" runat="server" BackColor="#CCCCCC" BorderWidth="2px" Height="57px" MaxLength="200" TextMode="MultiLine" Width="420px"></asp:TextBox>
&nbsp;<br />
            Patient Prescription:<br />
            <asp:TextBox ID="prescriptionBox" runat="server" BackColor="#CCCCCC" BorderWidth="2px" Height="57px" MaxLength="200" TextMode="MultiLine" Width="420px"></asp:TextBox>
            <br />
            <br />
            &nbsp;<asp:CheckBox ID="evaluationCheckbox" runat="server" BackColor="#CCCCCC" BorderColor="Black" BorderStyle="Solid" BorderWidth="2px" Text="Requires Further Evaluation/Tests" />
            <br />
            <br />
            Follow-up evaluation:<br />
&nbsp;<asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="test" DataValueField="code" BackColor="#CCCCCC"></asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:medicalclinicdbConnectionString %>" ProviderName="<%$ ConnectionStrings:medicalclinicdbConnectionString.ProviderName %>" SelectCommand="SELECT * FROM evaluation;"></asp:SqlDataSource>
            <br />
            <br />

            Appointment Total:
            <br />
            <asp:TextBox ID="apptTotalBox" runat="server" BackColor="#CCCCCC" BorderWidth="2px" Height="19px" Width="70px" Wrap="False"></asp:TextBox>
            <br />
            <br />
            Insurance Coverage:<br />
            <asp:TextBox ID="insuranceCovBox" runat="server" BackColor="#CCCCCC" BorderWidth="2px" Height="16px" Width="79px"></asp:TextBox>
            <br />
                        <br />
            Co-Payment:<br />
            <asp:TextBox ID="copayBox" runat="server" BackColor="#CCCCCC" BorderWidth="2px" Height="16px" Width="79px"></asp:TextBox>
            <br />
            &nbsp;</div>
        <p>
            <asp:Button ID="submitBttn" runat="server" BackColor="#003300" BorderColor="#009933" BorderWidth="2px" Font-Bold="True" ForeColor="White" Height="37px" OnClick="submitBttn_Click" Text="Submit Report" Width="251px" />
        </p>
    </form>
</body>
</html>
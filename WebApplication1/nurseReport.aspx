﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="nurseReport.aspx.cs" Inherits="WebApplication1.nurseReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Patient Form</title>
    <style type="text/css">
        #patientName {
            width: 521px;
        }
    </style>
</head>
<body>
    <form id="patientForm" runat="server">
        <div style="font-weight: bold">
            <!--<h1>Report for spiderman on 3/28/23</h1> --> <!-- placeholder header -->
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
            Patient Condition/Diagnosis: <br />

            <label for="patientSymptoms">
            <asp:TextBox ID="diagnosisBox" runat="server" BackColor="#CCCCCC" BorderWidth="2px" Height="72px" MaxLength="200" TextMode="MultiLine" Width="428px"></asp:TextBox>
            <br />
            <br />
            Patient Symptoms:</label><br />

            <asp:TextBox ID="symptomsBox" runat="server" BackColor="#CCCCCC" BorderWidth="2px" Height="57px" MaxLength="200" TextMode="MultiLine" Width="420px"></asp:TextBox>
&nbsp;<br />
            Patient Prescription:<br />
            <asp:TextBox ID="prescriptionBox" runat="server" BackColor="#CCCCCC" BorderWidth="2px" Height="57px" MaxLength="200" TextMode="MultiLine" Width="420px"></asp:TextBox>
            <br />
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

            &nbsp;</div>
        <p>
            <asp:Button ID="submitBttn" runat="server" BackColor="#003300" BorderColor="#009933" BorderWidth="2px" Font-Bold="True" ForeColor="White" Height="37px" OnClick="submitBttn_Click" Text="Submit Report" Width="251px" />
        </p>
    </form>
</body>
</html>

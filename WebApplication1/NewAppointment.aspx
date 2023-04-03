<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewAppointment.aspx.cs" Inherits="WebApplication1.NewAppointment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
      /* Styles for the form */
      .form-container {
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
        box-sizing: border-box;
      }
      .form-container label {
        display: block;
        margin-bottom: 10px;
        font-size: 16px;
        font-weight: bold;
      }
      .form-container input[type="text"],
      .form-container input[type="email"],
      .form-container input[type="date"] {
        width: 30%;
        padding: 10px;
        margin-bottom: 20px;
        box-sizing: border-box;
      }
      .form-container input[type="checkbox"] {
        margin-right: 10px;
      }
      .form-container input[type="submit"] {
        background-color: #333;
        color: white;
        border: none;
        padding: 10px 20px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
      }
      .form-container input[type="submit"]:hover {
        background-color: #555;
      }
      .required {
        color: red;
      }
      </style>
    <title>NEW APPOINTMENT</title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script> 

</head>
<body>
    <div class="navbar">
      <a href="#">About Us</a>
      <a href="#">Contact Us</a>
      <a href="PatientLogin.aspx">Patient Login</a>
      <a href="ProviderLogin.aspx">Provider Login</a>
      <a href="HomePage.aspx">Home</a>
    </div>
		<div class="form-container">
           <form id="form1" runat="server">

			<fieldset>
			<legend>Appointment Details</legend>

            <div class="form-group">
				<label for="SpecDept">
                <br />
                Select a Specialty <span class="required">*</span></label>&nbsp;
                <asp:DropDownList ID="specdept" runat="server" Width="140px" AutoPostBack="True" OnSelectedIndexChanged="specdept_SelectedIndexChanged" >
                    <asp:ListItem Selected="True"></asp:ListItem>
                    <asp:ListItem>Oncology</asp:ListItem>
                    <asp:ListItem>Dermatology</asp:ListItem>
                    <asp:ListItem>Cardiology</asp:ListItem>
                    <asp:ListItem>Neurology</asp:ListItem>
                    <asp:ListItem>Nephrology</asp:ListItem>
                    <asp:ListItem>Internal Medicine</asp:ListItem>
                </asp:DropDownList>
			    <br />
                <br />
			</div>

            <div class="form-group">
				<label for="officelabel">
                <br />
                Select a office location <span class="required">*</span></label>&nbsp;
                <asp:DropDownList ID="DropDownList1" runat="server" Width="140px" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True">
                </asp:DropDownList>
			    <br />
                <br />
			</div>

            <div class="form-group">
				<label for="Speclabel">
                <br />
                Select a Specialist Physician <span class="required">*</span></label>&nbsp;
                <asp:DropDownList ID="specialist" runat="server" Width="140px" AutoPostBack="True" ></asp:DropDownList>
			    <br />
                <br />
			</div>

			<div class="form-group">
				<label for="date-requested">Date Requested <span class="required">*</span></label>&nbsp;
                <asp:TextBox ID="date_requested" runat="server" TextMode="Date" DataFormatString="yyyy-MM-dd" AutoPostBack="True"></asp:TextBox>
			
			   <span class="required"> <asp:Literal ID="ErrorMessage_date2" EnableViewState="False"  runat="server"></asp:Literal></span>
			
			</div>

			<div class="form-group">
				<label for="time-requested">
                <br />
                Time Requested <span class="required">*</span></label>&nbsp;
                <asp:DropDownList ID="ddlTimeRequested" runat="server" Width="140px" OnTextChanged="date_requested_TextChanged" AutoPostBack="True"></asp:DropDownList>
			   <span class="required"> <asp:Literal ID="ErrorMessage_date" EnableViewState="False"  runat="server"></asp:Literal></span>
			    <br />
                <br />
			</div>



           <div class="form-group">
				<label for="referral">
                <br />
                Do you have a referral?<span class="required">*</span></label>
                <asp:CheckBox ID="CheckBox5" runat="server" />
                <label for="referral">Yes</label>
                <asp:CheckBox ID="CheckBox6" runat="server" />
                <label for="referral">No<br />
                <br />
                </label>
			&nbsp;</div>

			<div class="form-group">
				<label for="insurance">Do you have insurance?<span class="required">*</span></label>
                <asp:CheckBox ID="ins" runat="server" />
                <label for="insurance">Yes<br />
                </label>
                &nbsp;<asp:CheckBox ID="no_ins" runat="server" />
                <label for="insurance">No<br />
                </label>
			&nbsp;</div>

			<div class="form-group">
				<label for="insurance-name">Insurance Name</label>
				<input type="text" name="insurance-name" id="insurance-name"/>

				<label for="insurance-type">Insurance Type</label>
				<input type="text" name="insurance-type" id="insurance-type"/>
			</div>

			<p><span class="required">*</span> Required information</p>
            <p>
                <asp:Button ID="SUBMIT" runat="server" Text="SUBMIT" OnClick="SUBMIT_Click" />
            </p>
                <p>
                    &nbsp;</p>
	</fieldset>
               <asp:Button ID="Return" runat="server" Text="Return to Patient Portal" Width="239px" OnClick="Return_Click" style="margin-left: 0px" />
    </form>
     </div>

            <script>
                //Client-side jQuery to cancel form submission if required fields empty 
                $(function () {
                    // Attach event handler to form submit button click
                    $('#<%=SUBMIT.ClientID %>').on('click', function () {
                        // Check if required fields are filled out
                        if ($('#<%=specdept.ClientID %>').val() === "" || $('#<%=DropDownList1.ClientID %>').val() === "" || $('#<%=ddlTimeRequested.ClientID %>').val() === ""
                            || $('#<%=specialist.ClientID %>').val() === "" || $('#<%=date_requested.ClientID %>').val() === "") {
                            // Display dialog box
                            alert('Please fill out all required fields.');
                            return false; // Cancel form submission
                        }
                    });
                });
            </script>

</body>
</html>

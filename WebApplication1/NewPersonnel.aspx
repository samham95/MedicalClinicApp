<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewPersonnel.aspx.cs" Inherits="WebApplication1.NewPersonnel" %>
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

    <title>Add Personnel</title>
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
            <h1>Add new Personnel</h1>
            <p>Please fill out where indicated</p>
            <div class="form-group">
                <br />
                <label>Select a personnel type <span class="required">*</span></label>&nbsp;
                <label for="jobtype">Choose Personnel Type:</label>&nbsp;

                <asp:DropDownList ID="DropDownList1" runat="server">
                    <asp:ListItem>Doctor</asp:ListItem>
                    <asp:ListItem>Nurse</asp:ListItem>
                    <asp:ListItem>Staff</asp:ListItem>
                </asp:DropDownList>
                <br />
                <br />
            </div>
            <div class="form-container">
                <fieldset>
                    <legend>Contact Information</legend>

                    <div class="form-group">
                        <label for="first-name">First Name <span class="required">*</span></label>&nbsp;
                        <asp:TextBox ID="fname" runat="server"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label for="middle-initial">Middle Initial</label>&nbsp;
                        <asp:TextBox ID="mi" runat="server"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label for="last-name">Last Name <span class="required">*</span></label>&nbsp;
                        <asp:TextBox ID="lname" runat="server"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label for="date-of-birth">Date of Birth <span class="required">*</span></label>&nbsp;
                        <asp:TextBox ID="dob" runat="server" TextMode="Date" DataFormatString="{yyyy/MM/dd}"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label for="phone">Phone Number <span class="required">*</span></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:TextBox ID="phone_num" runat="server" placeholder="1234567890" MaxLength="10" />
                        <asp:RegularExpressionValidator ID="phoneValidator" runat="server" ControlToValidate="phone_num" ValidationExpression="^\d{10}$" ErrorMessage="Please enter a valid phone number" />
                    </div>

                    <div class="form-group">
                        <label for="email">Email <span class="required">*</span></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:TextBox ID="email" runat="server" placeholder="you@example.com"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="emailValidator" runat="server"
                                                        ControlToValidate="email" ErrorMessage="Please enter a valid email address."
                                                        ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" />
                    </div>

                    <div class="form-group">
                        <label for="specialty">If adding a doctor, enter a specialty</label>&nbsp;
                        <asp:TextBox ID="specialty" runat="server"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label for="role">If adding staff, enter a role</label>&nbsp;
                        <asp:TextBox ID="role" runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="office">If adding staff or nurse, enter a Office ID</label>&nbsp;
                        <asp:TextBox ID="office" runat="server"></asp:TextBox>
                    </div>
                    <p><span class="required">*</span> Required information</p>
                    <p><asp:Button ID="SUBMIT" runat="server" Text="SUBMIT" OnClick="SUBMIT_Click_addPer" /></p>
                </fieldset>
                &nbsp;
            </div>
            <div>
                <asp:Button ID="clear" runat="server" OnClick="ButtonClear_Click" Text="Clear Entries" style="margin-left: 0px" />
            </div>
            <div>
                <asp:Button ID="exit" runat="server" OnClick="ButtonExit_Click" Text="Return to Admin Page" style="margin-left: 0px" />
            </div>
            <script>
                //Client-side jQuery to cancel form submission if required fields empty
                $(function () {
                    // Attach event handler to form submit button click
                    $('#<%=SUBMIT.ClientID %>').on('click', function () {
                        // Check if required fields are filled out
                        if ($('#<%=fname.ClientID %>').val() === '' || $('#<%=lname.ClientID %>').val() === '' || $('#<%=email.ClientID %>').val() === ''
                            || $('#<%=phone_num.ClientID %>').val() === '') {
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
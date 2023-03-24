<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminView.aspx.cs" Inherits="WebApplication1.AdminView" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin View</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <style>
        /* Styles for the navigation bar */
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
</head>
<body>
    
    <form id="form1" runat="server">
    <h1 id="welcomeHeader" runat="server"> </h1>
    <br />
    <br />
   

    <div style="text-align: center; margin-bottom:2cm; margin-top:1px">
        <!-- Button to launch a modal -->
        <button type="button"
                class="btn btn-primary"
                data-toggle="modal"
                data-target="#personnelModal">
            Add New Personnel
        </button>
        <!-- Button to launch a modal -->
        <button type="button"
                class="btn btn-primary"
                data-toggle="modal"
                data-target="#officeModal">
            Add New Office
        </button>
        <!-- Button to launch a modal -->
        <button type="button"
                class="btn btn-primary"
                data-toggle="modal"
                data-target="#delperModal">
            Remove Personnel
        </button>
        <!-- Button to launch a modal -->
        <button type="button"
                class="btn btn-primary"
                data-toggle="modal"
                data-target="#delOffModal">
            Remove Office
        </button>
        <!-- Modal Personnel-->
        <div class="modal fade"
             id="personnelModal"
             tabindex="-1"
             role="dialog"
             aria-labelledby="exampleModalLabel"
             aria-hidden="true">

            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-body">
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

                        <div class="modal-footer">
                            <button type="button"
                                    class="btn btn-secondary"
                                    data-dismiss="modal">
                                Close
                            </button>
                        </div>
                        <!-- END MODAL: NEW PERSONNEL--->
                    </div>
                </div>
            </div>

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
        </div>
        <!-- Modal Office-->
        <div class="modal fade"
             id="officeModal"
             tabindex="-1"
             role="dialog"
             aria-labelledby="exampleModalLabel"
             aria-hidden="true">

            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-body">
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
                        <script>
                            //Client-side jQuery to cancel form submission if required fields empty
                            $(function () {
                                // Attach event handler to form submit button click
                                $('#<%=SUBMIT.ClientID %>').on('click', function () {
                                    // Check if required fields are filled out
                                    if ($('#<%=address.ClientID %>').val() === '') {
                                        // Display dialog box
                                        alert('Please fill out all required fields.');
                                        return false; // Cancel form submission
                                    }
                                });
                            });
                        </script>

                        <div class="modal-footer">
                            <button type="button"
                                    class="btn btn-secondary"
                                    data-dismiss="modal">
                                Close
                            </button>
                        </div>
                        <!-- END MODAL: NEW OFFICE--->
                    </div>
                </div>
            </div>

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
        </div>
        <!-- Modal Remove Personnel-->
        <div class="modal fade"
             id="deloffModal"
             tabindex="-1"
             role="dialog"
             aria-labelledby="exampleModalLabel"
             aria-hidden="true">

            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-body">
                        <h1>Remove Personnel</h1>
                        <p>Please fill out where indicated</p>
                        <div class="form-group">
                            <br />
                            <label>Select a personnel type <span class="required">*</span></label>&nbsp;
                            <label for="jobtype">Choose Personnel Type:</label>&nbsp;
                            <asp:DropDownList ID="DropDownList2" runat="server" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged">
                                <asp:ListItem>Doctor</asp:ListItem>
                                <asp:ListItem>Nurse</asp:ListItem>
                                <asp:ListItem>Staff</asp:ListItem>
                            </asp:DropDownList>
                            <br />
                            <br />
                        </div>
                        <div class="form-container">
                                <fieldset>
                                    <div class="form-group">
                                        <label for="perID"> Personnel ID <span class="required">*</span></label>&nbsp;
                                        <asp:TextBox ID="perID" runat="server"></asp:TextBox>
                                    </div>
                                    <p><span class="required">*</span> Required information</p>
                                    <p><asp:Button ID="Button2" runat="server" Text="SUBMIT" OnClick="SUBMIT_Click_RemPer" /></p>
                                </fieldset>
                                &nbsp;
                        </div>
                        <script>
                            //Client-side jQuery to cancel form submission if required fields empty
                            $(function () {
                                // Attach event handler to form submit button click
                                $('#<%=SUBMIT.ClientID %>').on('click', function () {
                                    // Check if required fields are filled out
                                    if ($('#<%=perID.ClientID %>').val() === '') {
                                        // Display dialog box
                                        alert('Please fill out all required fields.');
                                        return false; // Cancel form submission
                                    }
                                });
                            });
                        </script>

                        <div class="modal-footer">
                            <button type="button"
                                    class="btn btn-secondary"
                                    data-dismiss="modal">
                                Close
                            </button>
                        </div>
                        <!-- END MODAL: NEW OFFICE--->
                    </div>
                </div>
            </div>

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
        </div>
        <!-- Modal Remove Office-->
        <div class="modal fade"
             id="delperModal"
             tabindex="-1"
             role="dialog"
             aria-labelledby="exampleModalLabel"
             aria-hidden="true">

            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-body">
                        <h1>Remove Office</h1>
                        <p>Please fill out where indicated</p>
                        <div class="form-container">
                                <fieldset>
                                    <div class="form-group">
                                        <label for="id"> ID <span class="required">*</span></label>&nbsp;
                                        <asp:TextBox ID="id" runat="server"></asp:TextBox>
                                    </div>
                                    <p><span class="required">*</span> Required information</p>
                                    <p><asp:Button ID="Button3" runat="server" Text="SUBMIT" OnClick="SUBMIT_Click_RemOff" /></p>
                                </fieldset>
                                &nbsp;
                        </div>
                        <script>
                            //Client-side jQuery to cancel form submission if required fields empty
                            $(function () {
                                // Attach event handler to form submit button click
                                $('#<%=SUBMIT.ClientID %>').on('click', function () {
                                    // Check if required fields are filled out
                                    if ($('#<%=id.ClientID %>').val() === '') {
                                        // Display dialog box
                                        alert('Please fill out all required fields.');
                                        return false; // Cancel form submission
                                    }
                                });
                            });
                        </script>

                        <div class="modal-footer">
                            <button type="button"
                                    class="btn btn-secondary"
                                    data-dismiss="modal">
                                Close
                            </button>
                        </div>
                        <!-- END MODAL: NEW OFFICE--->
                    </div>
                </div>
            </div>

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
        </div>
    </div>
    </form>

</body>
</html>
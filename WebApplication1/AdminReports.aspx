<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminReportsaspx.aspx.cs" Inherits="WebApplication1.AdminReportsaspx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
               <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-body">
                            <h1 style="margin-left: 0px">Generate Report</h1>
                            <p>
&nbsp;Please choose where indicated</p>
                            <div class="form-group">
                                <br />
                                <label for="jobtype">
                                Choose Report Type:</label>&nbsp;
                                <asp:DropDownList ID="DropDownList3" runat="server">
                                    <asp:ListItem>Doctor</asp:ListItem>
                                    <asp:ListItem>Nurse</asp:ListItem>
                                    <asp:ListItem>Staff</asp:ListItem>
                                </asp:DropDownList>
                                <br />
                                <br />
                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="btnGenerateReport" runat="server" Text="Generate" CssClass="btn btn-secondary" OnClick="btnGenerateReport_Click" />
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
    </form>
</body>
</html>

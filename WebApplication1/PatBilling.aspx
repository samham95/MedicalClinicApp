<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PatBilling.aspx.cs" Inherits="WebApplication1.PatBilling" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
        .bill-summary {
          font-size: 24px;
          font-weight: bold;
          margin-bottom: 10px;
        }
        .bill-title {
          font-size: 32px;
          font-weight: bold;
          margin-bottom: 10px;
        }

        .bill-item {
          margin-bottom: 20px;
        }
        .bill-total{
          font-size: 28px;
        }



    </style>
</head>
<body>
    <div class="navbar">
      <a href="#">About Us</a>
      <a href="#">Contact Us</a>
      <a href="PatientLogin.aspx">Patient Login</a>
      <a href="ProviderLogin.aspx">Provider Login</a>
      <a href="HomePage.aspx">Home</a>
    </div>
    <form id="form1" runat="server">
        <h1 style ="font-size: 32px; width: 907px;" runat="server">
            <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click"></asp:LinkButton>
        &nbsp;</h1>
    <asp:Panel ID="pnlBillSummary" runat="server" CssClass="bill-summary">
        <div>
            <span class="bill-title">Current Bill&nbsp; |&nbsp; Due on <asp:Label ID="lblDueDate" runat="server"></asp:Label>
            <br />
            </span>
        </div>
        <div>
            <span class="bill-item">Total past due:</span> <asp:Label ID="lblPastDue" runat="server" Text="$0.00"></asp:Label>
            <br />
        </div>
        <div>
            <span class="bill-item">Bill amount:</span> <asp:Label ID="lblBillAmount" runat="server" Text="$0.00"></asp:Label>
            <br />
        </div>
        <div>
            <span class="bill-item">Insurance Adjustments:</span> <asp:Label ID="lblInsuranceAdjustments" runat="server" Text="-$0.00"></asp:Label>
            <br />
        </div>
        <div>
            <span class="bill-item">Co-Pays:</span> <asp:Label ID="lblpayments" runat="server" Text="-$0.00"></asp:Label>
            <br />
        </div>
        <div>
            <span class="bill-item">Payments:</span> <asp:Label ID="lblmanpay" runat="server" Text="-$0.00"></asp:Label>
            <br />
        </div>
        <div>
            <span class="bill-total" style ="color:darkred">Total due:</span> <asp:Label ID="lblTotalDue" runat="server" Text="$0.00" style= "background-color: darkgray"></asp:Label>
            <br />
            <br />
        </div>
        <div>
            <asp:Button ID="btnPayNow" runat="server" Text="Pay now" CssClass="pay-now-btn" OnClick="btnPayNow_Click" Width="133px" />
            <asp:Button ID="btnPrintSummary" runat="server" Text="Print Bill Summary" CssClass="print-btn" OnClick="btnPrintSummary_Click" Width="168px" />
            <br />
            <br />
        </div>
    </asp:Panel>

        <h1>Invoice Summary</h1>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="Black" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
        <Columns>
            <asp:BoundField DataField="invoiceID" HeaderText="Invoice ID" />
            <asp:BoundField DataField="total" HeaderText="Total" DataFormatString="{0:c}" />
            <asp:BoundField DataField="claim" HeaderText="Claim Amount" DataFormatString="{0:c}" />
            <asp:BoundField DataField="paid_amount" HeaderText="Paid Amount" DataFormatString="{0:c}" />
            <asp:BoundField DataField="due_date" HeaderText="Due Date" DataFormatString="{0:d}" />
            <asp:BoundField DataField="reportID" HeaderText="Report ID" Visible="false" />
            <asp:ButtonField ButtonType ="button" HeaderText="Report" Text="VIEW" CommandName="viewReport" />
        </Columns>
        <FooterStyle BackColor="#CCCCCC" />
        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
        <RowStyle BackColor="White" />
        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="#808080" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#383838" />
    </asp:GridView>


    </form>
</body>
</html>

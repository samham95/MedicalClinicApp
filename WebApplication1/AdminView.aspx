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
                <asp:Button ID="AddPer" runat="server" OnClick="ButtonAP_Click" Text="Add new Personnel" style="margin-left: 0px" />

                <asp:Button ID="AddOff" runat="server" OnClick="ButtonAO_Click" Text="Add new Office" style="margin-left: 0px" />

                <asp:Button ID="RemOff" runat="server" OnClick="ButtonRO_Click" Text="Remove Office" style="margin-left: 0px" />

                <asp:Button ID="RemPer" runat="server" OnClick="ButtonRP_Click" Text="Remove Personnel" style="margin-left: 0px" />
        </div>
    </form>

</body>
</html>
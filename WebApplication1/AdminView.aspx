<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminView.aspx.cs" Inherits="WebApplication1.AdminView" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="navbar.css" rel="stylesheet" />
    <title>Admin View</title>
    <style>
        body{
            background-image: url(https://img.freepik.com/free-photo/blur-hospital-clinic-interior_74190-5207.jpg?w=996&t=st=1680656377~exp=1680656977~hmac=2cb637b5fedbcdd2c55e716be17f7dad5159d4ded0c4bca6e93c034b8fd1864b);
            background-repeat: no-repeat;
            background-size: cover;
        }
        h1 {
          font-family: 'Open Sans', sans-serif;
          font-weight: bold;
          margin-top: 40px;
          margin-left: 20px;
        }
        a img {
            width: 100px;
            height: 100px;
        }
        .personnel-box a {
          display: block;
        }

        .office-box a {
          display: block;
        }

        .image-box {
          display: inline-block;
          text-align: center;
          margin: 0 10px;
          border: 1px solid #ccc;
          padding: 10px;
          border-radius: 10px;
          background-color: #fff;
          width: 150px; /* set the width of the box */
          height: 150px; /* set the height of the box */
        }

        .image-text {
          font-family: 'Open Sans', sans-serif;
          margin-top: 10px;
          font-weight: bold;
        }
    </style>
    </head>
<body>

    <!-- Define the navigation bar at the top of the page -->
	<div class="navbar">
        <a href="HomePage.aspx">Home</a>
        <a href="#">About Us</a>
        <a href="#">Contact Us</a>
        <a href="PatientLogin.aspx">Patient Login</a>
        <a href="ProviderLogin.aspx">Provider Login</a>
    </div>

    <br />

    <form id="form1" runat="server">
        <h1 id="welcomeHeader" runat="server"> </h1>
        <br />
        <br />
        <div class="personnel-container">
            <div class="personnel-box" style="text-align: center; margin-bottom:2cm; margin-top:1px">
                <div style="display: inline-block;">
                    <div class="image-box">
                        <a href="#" onclick="addPersonnel()"><img src="https://cdn.icon-icons.com/icons2/1572/PNG/512/3592854-add-user-business-man-employee-general-human-member-office_107767.png" alt="Add Personnel"></a>
                        <div class="image-text">Add Personnel</div>
                    </div>
                    <div class="image-box">
                        <a href="#" onclick="removePersonnel()"><img src="https://cdn.icon-icons.com/icons2/1572/PNG/512/3592826-employee-human-member-office-remove-remove-user-user_107791.png" alt="Remove Personnel"></a>
                        <div class="image-text">Remove Personnel</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="office-container">
            <div class="office-box" style="text-align: center; margin-bottom:2cm; margin-top:1px">
                <div style="display: inline-block;">
                    <div class="image-box">
                        <a href="#" onclick="addOffice()"><img src="https://cdn-icons-png.flaticon.com/512/15/15735.png?w=740&t=st=1680571821~exp=1680572421~hmac=d4771d192ae9b4f18c929417ca097612ef912ad30f2fb9be3307b82fe6a636b0" alt="Add Office"></a>
                        <div class="image-text">Add Office</div>
                    </div>
                    <div class="image-box">
                        <a href="#" onclick="removeOffice()"><img src="https://cdn-icons-png.flaticon.com/512/15/15762.png?w=740&t=st=1680571689~exp=1680572289~hmac=b8c84a454135ecb86dec775625e8e383e30e91314cccf9814d2687b27cfc7821" alt="Remove Office"></a>
                        <div class="image-text">Remove Office</div>
                    </div>
                </div>
            </div>
        </div>
    </form>

</body>
</html>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="WebApplication1.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

  <meta charset="utf-8">
  <title>DR. UMA'S HEALTH CLINIC</title>
  <style>
      html, body {
          margin: 0;
          padding: 0;
      }

      body {
          background-color: white;
          font-family: 'Roboto', sans-serif;
          font-weight: 100;
          color: white;
          letter-spacing: .5px
      }

      .container {
          margin: 0 auto;
          max-width: 1000px;
          padding: 0 0px;
          text-align: center;
      }


      .header .container {
          position: relative;
          top: 80px;
      }

<<<<<<< HEAD
      .text{
          background-image: url("https://c0.wallpaperflare.com/preview/4/544/846/medical-local-doctor-medicine.jpg");
          background-size: cover;
=======
      .header {
          position: relative;
>>>>>>> 7d3053af6d7f8daf75c72a6e2f3d9e50217fe9b0
          height: 100vh;
          text-align: center;
          color: black;
          font-family: monospace;
          font-size: 40px;
          font-family: fantasy;
<<<<<<< HEAD

        }
          .header {
          background-image: url("https://c0.wallpaperflare.com/preview/4/544/846/medical-local-doctor-medicine.jpg");
          background-size: cover;
          height: 100vh;
          text-align: center;
          color: black;
          font-family: monospace;
          font-size: 40px;
          font-family: fantasy;

        }


        .header img {
          width: 100%;
          height: 100%;
          object-fit: cover;
           filter: blur(8px);
           -webkit-filter: blur(8px);
        }

=======
        }

      .header::before {
          content: "";
          background-image: url("https://c0.wallpaperflare.com/preview/4/544/846/medical-local-doctor-medicine.jpg");
          background-size: cover;
          width: 100%;
          height: 100%;
          position: absolute;
          left: 0px;
          filter: blur(8px);
          -webkit-filter: blur(8px);
      }
>>>>>>> 7d3053af6d7f8daf75c72a6e2f3d9e50217fe9b0


        .header img {
          width: 100%;
          height: 100%;
          object-fit: cover;
        }


      .header h1 {
          text-transform: uppercase;
          font-family: times;
       }

      .btn {
          color: white;
          background: #117bff;
          padding: 10px 40px;
          text-decoration: none;
          transition: background .5s;
          font-size: 25px;
          font-family: serif;
      }

              /* Navigation styles */
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
            .navbar left {
        float: left;
        color: white;
        text-align: left;
        padding: 14px 16px;
        text-decoration: none;
        font-size: 17px;
      }
      .navbar a:hover {
        background-color: #ddd;
        color: black;
      }

      .btn:hover {
          background: black;
          cursor: pointer;
          transition: background .5s;
      }

      .nav ul li:hover {
          background: #000;
          cursor: pointer;
          transition: background .5s;
      }


      .contact {
  color: black;
}

    .location-box {
      background-color: lightcyan;
      color: black;
      padding: 1rem;
      width: 350px;
      position: absolute;
      bottom: 10%;
      right: 10%;
      border-radius: 15px;
      box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
    }

    </style>
</head>


<body>
  <form id="form1" runat="server">
      	<div class="navbar">
      <a href="#">About Us</a>
      <a href="#">Contact Us</a>
      <a href="PatientLogin.aspx">Patient Login</a>
      <a href="ProviderLogin.aspx">Provider Login</a>
      <a href="HomePage.aspx">Home</a>
      <left>Dr. Uma Medical Clinic</left>
    </div>
<<<<<<< HEAD
  <div class="text">
=======
  <div class="header">
>>>>>>> 7d3053af6d7f8daf75c72a6e2f3d9e50217fe9b0
    <div class="container">
      <h1>Dr.Uma Clinic </h1>
      <p>Your Health Journey Start Here!<p>
      <a class="btn" href="NewPatient.aspx">Click Here to Schedule Your Appointment Today</a>
    </div>
  </div>


<div class="main">
 
</div>
<div class="footer">
  <section class="contact">
    <p>Email: info@umamedicalgroup.com | Phone: (713)867-5309</p>
    <p>Â© 2023 Group 13. All rights reserved.</p>
    <p><a href="AdminLogin.aspx">Admin Login</a></p>
  </section>
</div>
      <div class="location-box">
  <h3>Our Office Location</h3>
  <p>Office 1: 123 Main Street, TX77070, USA</p>
  <p>Office 2: 1 34 Baker Street, Miami, FL34532, USA</p>
</div>
      


</form>
</body>


</html>
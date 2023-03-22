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
          background-color: black;
          font-family: 'Roboto', sans-serif;
          font-weight: 100;
          color: white;
          letter-spacing: .5px
      }

      .container {
          margin: 0 auto;
          max-width: 940px;
          padding: 0 10px;
          text-align: center;
      }


      .header .container {
          position: relative;
          top: 80px;
      }

      .header {
          background: url("https://www.elitelearning.com/wp-content/uploads/2021/04/blog_image_benefits-of-laughter@2x.jpg") no-repeat center center;
          background-size: contain;
          height: 800px;
          text-align: center;
          color: black;
          font-family: monospace;
          font-size: 40px;
          font-family: fantasy;
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

      .nav {
          background: #000;
          height: 80px;
          width: 100%;
      }

          .nav ul {
              height: 80px;
              list-style: none;
              margin: 0 auto;
              padding: 0;
          }

              .nav ul li {
                  color: white;
                  display: inline-block;
                  height: 80px;
                  line-height: 80px;
                  list-style: none;
                  padding: 0 10px;
                  transition: background .5s;
                  font-size: 25px;
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
    </style>
</head>


<body>
  <form id="form1" runat="server">
  <div class="header">
    <div class="container">
      <h1>Dr. Uma's Medical Clinic </h1>
      <p>Your health matters!<p>
      <a class="btn" href="NewPatient.aspx">New patients click here to schedule your appointment today</a>
    </div>
  </div>

<div class="nav">
  <div class="container">
    <ul>
    <li><a class="link" href="#">Home</a></li>
    <li><a class="link" href="ProviderLogin.aspx">Provider Login</a></li>
    <li><a class="link" href="PatientLogin.aspx">Patient Login</a></li>
    <li><a class="link" href="#">Contact Us</a></li>
    <li><a class="link" href="#">About Us</a></li>
   </ul>
  </div>
</div>
<div class="main">
  <div class="container">
    <img src="https://www.usbets.com/wp-content/uploads/2021/04/texas-california-florida-new-york-signs.jpg.webp" alt="tower" height="300" width="450">
    <h2>Here at your convenience</h2>
    <p>With offices in Texas, California, Florida, and New York, we are wherever you need us to be!</p>
   </div>
</div>

<br>
<br>
<br>

<div class="footer">
  <section class="contact">
    <p>Email: info@umamedicalgroup.com | Phone: (713)867-5309</p>
  </section>
</div>

</form>
</body>


</html>


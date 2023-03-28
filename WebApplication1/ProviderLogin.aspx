<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProviderLogin.aspx.cs" Inherits="WebApplication1.ProviderLoginLanding" %>

<!DOCTYPE html>
<html>
<head>
	<title>ProviderLogin</title>
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
        header {
            background-color: white;
            color: black;
            padding: 0px;
            text-align: center;
            font-size: 50px;
            font-weight: bold;
        }
        .container {
            margin-top: 50px;
            text-align: center;
        }

        .squares-container {
            display: flex;
            justify-content: center;
        }

        .square {
            position: relative;
            width: 478px;
            height: 257px;
            margin: 20px;
            overflow: hidden;
            top: 1px;
            left: 20px;
        }

        .square img {
            width: 100%;
            height: 101%;
            object-fit: cover;
            transition: transform 0.5s ease;
            margin-left: 0px;
            margin-right: 13px;
            margin-top: 1px;
        }

        .square:hover img {
            transform: scale(1.1);
        }
        
        .overlay {
            position: absolute;
            top: 50%;
            left: 56%;
            transform: translate(-50%, -50%);
            background-color: rgba(0, 0, 0, 0.5);
            color: white;
            font-size: 24px;
            padding: 20px;
            text-align: center;
            transition: opacity 0.5s ease;
            opacity: 0;
            height: 225px;
            width: 572px;
        }

        .square:hover .overlay {
            opacity: 1;
        }

	</style>

</head>

    <body style="height: 726px; width: 1265px; margin-left: 0px">
        <div class="navbar">
          <a href="#">About Us</a>
          <a href="#">Contact Us</a>
          <a href="PatientLogin.aspx">Patient Login</a>
          <a href="ProviderLogin.aspx">Provider Login</a>
          <a href="HomePage.aspx">Home</a>
        </div>
	    <div class="container">
		    <header style="margin-left: 0px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Provider Portal Login</header>
            <p style="margin-left: 0px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="PatientLogin.aspx">Use this link if you are a patient</a></p>
		<div class="squares-container">
			<a href="NurseLogin.aspx">
				<div class="square">
					        <img src="https://imageio.forbes.com/specials-images/imageserve/619ea056b05de2285c025b70/Any-updates-on-this-patient-/960x0.jpg?format=jpg&width=960" alt="Nurse">
            		<div class="overlay">
						<h2 style="height: 199px; width: 527px">NURSE LOGIN</h2>
					</div>
				</div>
			</a>
            <a href="DoctorLogin.aspx">
				<div class="square">
					        <img src="https://health.gov/sites/default/files/styles/topic_card_image/public/2020-01/regular-checkups_banner.jpg?itok=2HIjcA3h" alt="Doctor">
					<div class="overlay">
						<h2 style="height: 203px; width: 521px">DOCTOR LOGIN</h2>
					</div>
				</div>
			</a>
		</div>
	</div>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProviderLogin.aspx.cs" Inherits="WebApplication1.ProviderLoginLanding" %>

<!DOCTYPE html>
<html>
<head>
	<title>ProviderLogin</title>
    <link href="LoginStyle.css" rel="stylesheet"/>
    <link href="navbar.css" rel="stylesheet"/>
	<style>
        header {
            color: black;
            text-align: center;
            font-size: 50px;
            font-weight: bold;
            margin-bottom: 50px;
        }
        h2 {
        }
        .container {
            font-family: 'Open Sans', sans-serif;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0 auto;
            margin-top: -50px;
        }
        .squares-container {
            display: flex;
            justify-content: center;
            align-items: center;
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
            left: 50%;
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
<body>
    <!-- Define the navigation bar at the top of the page -->
	<div class="navbar">
        <a href="HomePage.aspx">Home</a>
        <a href="#">About Us</a>
        <a href="#">Contact Us</a>
        <a href="PatientLogin.aspx">Patient Login</a>
        <a href="ProviderLogin.aspx">Provider Login</a>
    </div>

    <div class="container">
        <header>Provider Login</header>
        <div class="squares-container">
		    <a href="NurseLogin.aspx">
			    <div class="square">
				    <img src="https://imageio.forbes.com/specials-images/imageserve/619ea056b05de2285c025b70/Any-updates-on-this-patient-/960x0.jpg?format=jpg&width=960" alt="Nurse">
            	    <div class="overlay">
					    <h2>NURSE LOGIN</h2>
				    </div>
			    </div>
		    </a>
            <a href="DoctorLogin.aspx">
			    <div class="square">
		            <img src="https://health.gov/sites/default/files/styles/topic_card_image/public/2020-01/regular-checkups_banner.jpg?itok=2HIjcA3h" alt="Doctor">
			        <div class="overlay">
				        <h2>DOCTOR LOGIN</h2>
				    </div>
			    </div>
		    </a>
		</div>
	</div>
</body>
</html>
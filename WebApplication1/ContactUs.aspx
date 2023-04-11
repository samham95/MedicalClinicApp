<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContactUs.aspx.cs" Inherits="WebApplication1.ContactUs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>Contact Us</title>

    <style type="text/css">
		.container {
			display: flex;
			align-items: center;
			justify-content: center;
			text-align: center;
		}
		h1 {
			font-size: 2rem;
			margin-bottom: 1rem;
		}

		p {
			font-size: 1.2rem;
			margin-bottom: 1rem;
		}

		.contact-info {
			max-width: 800px;
			margin: 0 auto;
			text-align: center;
		}

      .location {
  margin-bottom: 20px;
}
      ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
}

	  
    </style>
    		<link href="navbar.css" rel="stylesheet" />
    <link href="AdminPages.css" rel="stylesheet" />
</head>
<body >
    <div class="navbar">
	  <div class="navbar-right">
		<a href="HomePage.aspx" class="nav-item">Home</a>
		<a href="#" class="nav-item">About Us</a>
		<a href="#" class="nav-item">Contact Us</a>
		<a href="PatientLogin.aspx" class="nav-item">Patient Login</a>
		<a href="ProviderLogin.aspx" class="nav-item">Provider Login</a>
	  </div>
	</div>
    <div class="container">
  <div class="contact-info">
    <h1>&nbsp;</h1>
      <h1>Contact Us</h1>
    <p>&nbsp;</p>
      <p>Please select a state below for contact information:</p>
    <select id="state-dropdown" onchange="showLocation()">
      <option value="">Select a state</option>
      <option value="TX">Texas</option>
      <option value="FL">Florida</option>
      <option value="NY">New York</option>
      <option value="CA">California</option>
    </select>
    <div id="location-info"></div>
    <p>If you are experiencing a medical emergency, please call 911 or go to the nearest emergency room.</p>
  </div>
</div>

<script>
    function showLocation() {
        var dropdown = document.getElementById("state-dropdown");
        var state = dropdown.options[dropdown.selectedIndex].value;
        var locationInfo = document.getElementById("location-info");

        if (state === "") {
            locationInfo.innerHTML = "";
            return;
        }

        // Add contact information for each location here
        if (state === "TX") {
            locationInfo.innerHTML = "<p><strong>Locations in Texas:</strong></p><ul><li><strong>123 Main St.</strong><br>Houston, TX 77070<br><em>Billing email:</em> houstonbilling@example.com<br><em>Phone number:</em> (123) 456-7890</li><li><strong>456 Pine Lane</strong><br>Houston, TX 77002<br><em>Billing email:</em> houstonbilling@example.com<br><em>Phone number:</em> (555) 555-5555</li><li><strong>789 Oak Avenue</strong><br>Austin, TX 78701<br><em>Billing email:</em> austinbilling@example.com<br><em>Phone number:</em> (111) 222-3333</li><li><strong>234 Maple Boulevard</strong><br>Dallas, TX 75201<br><em>Billing email:</em> dallasbilling@example.com<br><em>Phone number:</em> (444) 555-6666</li></ul>";
        } else if (state === "FL") {
            locationInfo.innerHTML = "<p><strong>Locations in Florida:</strong></p><ul><li><strong>134 Baker St.</strong><br>Miami, FL 34532<br><em>Billing email:</em> miamibilling@example.com<br><em>Phone number:</em> (987) 654-3210</li><li><strong>456 Maple Drive</strong><br>Miami, FL 33129<br><em>Billing email:</em> miamibilling@example.com<br><em>Phone number:</em> (777) 888-9999</li><li><strong>789 Walnut Road</strong><br>Orlando, FL 32801<br><em>Billing email:</em> orlandobilling@example.com<br><em>Phone number:</em> (222) 333-4444</li><li><strong>234 Birch Street</strong><br>Tampa, FL 33602<br><em>Billing email:</em> tampabilling@example.com<br><em>Phone number:</em> (555) 444-3333</li></ul>";
        } else if (state === "NY") {
            locationInfo.innerHTML = "<p><strong>Locations in New York:</strong></p><ul><li><strong>1234 Elm Avenue, Brooklyn, NY 11201</strong><br><em>Billing Email:</em> nybilling@example.com<br><em>Phone number:</em> (555) 123-4567</li><li><strong>987 Oak Lane, Queens, NY 11354</strong><br><em>Billing Email:</em> brooklynbilling@example.com<br><em>Phone number:</em> (555) 234-5678</li><li><strong>567 Pine Street, Manhattan, NY 10010</strong><br><em>Billing Email:</em> queensbilling@example.com<br><em>Phone number:</em> (555) 345-6789</li></ul>";
        } else if (state === "CA") {
            locationInfo.innerHTML = "<p><strong>Locations in California:</strong></p><ul><li><strong>456 Elm Street</strong><br>Los Angeles, CA 90012<br><em>Billing email:</em> labilling@example.com<br><em>Phone number:</em> (555) 456-7890</li><li><strong>789 Chestnut Lane</strong><br>San Francisco, CA 94102<br><em>Billing email:</em> sfbilling@example.com<br><em>Phone number:</em> (555) 567-8901</li><li><strong>234 Cedar Road</strong><br>San Diego, CA 92101<br><em>Billing email:</em> sandiegobilling@example.com<br><em>Phone number:</em> (555) 678-9012</li></ul>";
        }
    }
</script>


</body>
</html>


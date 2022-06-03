<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

	<title>OutOfMemory</title>

	<!-- Google font -->
	<link href="https://fonts.googleapis.com/css?family=Raleway:400,700" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Passion+One:900" rel="stylesheet">

	<!-- Custom stlylesheet -->
	<link type="text/css" rel="stylesheet" href="style.css" />



</head>

<body>

	<div id="notfound">
		<div class="notfound">
			<h2>Oops..</h2>
			<p>Si e' verificato il seguente errore: <br><font style="color: red"><%= request.getParameter("messaggio") %></font></p>
			<a href="index.jsp">home page</a>
		</div>
	</div>

</body>

</html>

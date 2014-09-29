<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>NumeroUno Business Consultants</title>
<style type="text/css">
body {
	font-family: calibri;
	background: url(images/blue_abstract_background.jpg) no-repeat fixed;
	background-size: cover;
}
input {
	border-radius: 5px;
	padding: 5px;
	border: none;
}
.container {
	width: 300px;
	margin: 100px auto;
	padding: 10px;
	border: 1px solid #fff;
	border-radius: 10px;
}

.btn {
	background: #9f3f3f;
	background-image: linear-gradient(to bottom, #9f3f3f, #4d1212);
	background-attachment: local;
	border-radius: 28px;
	color: #ffffff;
	font-size: 15px;
	padding: 8px 20px 8px 20px;
	text-decoration: none;
	border: none;
	cursor: pointer;
}

.btn:hover {
	background: #3cb0fd;
	background-image: linear-gradient(to bottom, #4d1212, #9f3f3f);
	text-decoration: none;
}
</style>
</head>

<body>
	<div class="container">
		<form method="post" action="ProcessLogin.jsp" name="loginForm">
			<table>
				<tr>
					<td align="center"><img src="images/logo.png" alt="logo" /></td>
				</tr>
				<tr>
					<td><input type="text" name="userName" size="35" placeholder="Username" required="required" /></td>
				</tr>
				<tr>
					<td><input type="password" name="userPassword" size="35" placeholder="Password" required="required"/></td>
				</tr>
				<tr>
					<td><br /></td>
				</tr>
				<tr>
					<td align="center"><input type="submit" value="Login" class="btn" /></td>
				</tr>
			</table>
		</form>
	</div>
</body>

</html>
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
	text-align: center;
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
<script type="text/javascript">
function gotoLogin() {
	window.location.href = "index.jsp";
}
</script>
</head>

<body>
<%
	session.removeAttribute("username");
	session.removeAttribute("usertype");
%>
	<div class="container">
		<h1>You have signed out.</h1><br/>
		<input type="button" value="Click Here to Login" class="btn"  onclick="gotoLogin();"/>
	</div>
</body>

</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*, java.io.*"
	import="org.apache.poi.ss.usermodel.DataFormatter"
	import="org.apache.poi.xssf.usermodel.XSSFCell"
	import="org.apache.poi.xssf.usermodel.XSSFRow"
	import="org.apache.poi.xssf.usermodel.XSSFSheet"
	import="org.apache.poi.xssf.usermodel.XSSFWorkbook"
%>
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
	padding: 20px;
	border: 1px solid #fff;
	border-radius: 10px;
	text-align: center;
}

.btn {
	background: #9f3f3f;
	background-image: linear-gradient(to bottom, #9f3f3f, #4d1212);
	background-attachment: local;
	border-radius: 5px;
	color: #ffffff;
	font-size: 15px;
	padding: 8px 20px 8px 20px;
	text-decoration: none;
	border: none;
	cursor: pointer;
	margin-top: 20px;
}

.btn:hover {
	background: #3cb0fd;
	background-image: linear-gradient(to bottom, #4d1212, #9f3f3f);
	text-decoration: none;
}
.pad {
	margin-top: 10px;
	border: none;
	border-radius: 5px;
	padding: 5px;
	width: 100%;
}
</style>
</head>

<body>
	<div class="container">
		<form method="post" action="result1.jsp" name="loginForm">
			<h1 style="margin: 0 0 10px 0; font-weight: bold; color: white;">Sheet Uploaded</h1>
			<select name="sheets" class="pad">
				<option>Select Sheet</option>
			<%
				String globalpath = "c:\\data\\data.xlsx";
			
				int dsrid = Integer.parseInt(request.getParameter("dsrid"));
				Collection<Part> parts = request.getParts();
			
				if (parts.isEmpty()) {
				} else {
					Iterator<Part> p = parts.iterator();
			
					while (p.hasNext()) {
						Part part = p.next();
						part.write(globalpath);
					}
				}
			
				try {
					//
					// Create a FileInputStream that will be use to read the
					// excel file.
					//
					FileInputStream fis = new FileInputStream(globalpath);
					//
					// Create an excel workbook from the file system.
					//
					XSSFWorkbook workbook = new XSSFWorkbook(fis);
			
					int sheets = workbook.getNumberOfSheets();
			
					for (int i = 0; i < sheets; i++) {
			%>
					<option value="<%= workbook.getSheetName(i)%>"><%= workbook.getSheetName(i)%></option>
			<%
				}
				
					workbook.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			%>
			</select>
			<input type="hidden" name="dsrid" value="<%=dsrid%>" />
			<input type="submit" value="Import Now" class="btn" />
		</form>
	</div>
</body>

</html>
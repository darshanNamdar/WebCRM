<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*, java.io.*, java.sql.*"
	import="org.apache.poi.ss.usermodel.DataFormatter"
	import="org.apache.poi.xssf.usermodel.XSSFCell"
	import="org.apache.poi.xssf.usermodel.XSSFRow"
	import="org.apache.poi.xssf.usermodel.XSSFSheet"
	import="org.apache.poi.xssf.usermodel.XSSFWorkbook"
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
.btn {
	background: #9f3f3f;
	background-image: linear-gradient(to bottom, #9f3f3f, #4d1212);
	background-attachment: local;
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

select {
	border-radius: 5px;
	padding: 5px;
}
</style>
</head>
<body>
<%!
	String url = "jdbc:mysql://localhost:3306/"; /*Database URL with PORT*/
	String dbName = "CRM"; /*Database name*/
	String userName = "root"; /*Database Username*/
	String pwd = "numerouno"; /*Database Password*/

	Connection connect;
	PreparedStatement preStatement;
	Statement statement, statement1;
	ResultSet rs;
%>
<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
		connect = DriverManager.getConnection(url + dbName, userName, pwd);
		statement = connect.createStatement();
	} catch (SQLException sqle) {
		sqle.printStackTrace();
	}

	int userid = (int)session.getAttribute("userid");
%>
<center>
<h4>Select Sheet to Upload</h4>
<form action="result1.jsp" method="post">
<select name="sheets">
<option>-Select-</option>
<%
	String globalpath = "c:\\data\\data.xlsx";

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
<select name="domains">
<option>-Select-</option>
<%
	String query = "select Dsr_Name from UserDsr where User_ID="+ userid;
	rs = statement.executeQuery(query);

	while (rs.next()) {
		String dsrname = rs.getString(1);
%>
		<option value="<%= dsrname%>"><%= dsrname%></option>
<%
	}
%>
</select>
<input type="submit" value="Upload Excel" class="btn">
</form>
</center>
</body>
</html>
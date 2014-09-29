<%@ page
	language="java"
	contentType="text/html; charset=ISO-8859-1"
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
body {
	font-family: arial;
}
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
</style>
</head>
<body>
<%
	//
	// An excel file name. You can create a file name with a full
	// path information.
	//
	String globalpath = "c:\\data\\data.xlsx";

	String sheetname = request.getParameter("sheets");
	int dsrid = Integer.parseInt(request.getParameter("dsrid"));
	String username = (String) session.getAttribute("username");
%>
	<jsp:useBean id="job" class="classes.ExcelRead3" scope="application"></jsp:useBean>
<%
	job.setUsername(username);
	job.setSheetName(sheetname);
	job.setDsrId(dsrid);
	job.initializeConnection();
%>
<%
		//
		// Create an ArrayList to store the data read from excel sheet.
		//
		List<List<String>> sheetData = new ArrayList<List<String>>();

		DataFormatter formatter = new DataFormatter();
		FileInputStream fis = null;

		try {
			//
			// Create a FileInputStream that will be use to read the
			// excel file.
			//
			fis = new FileInputStream(globalpath);
			//
			// Create an excel workbook from the file system.
			//
			XSSFWorkbook workbook = new XSSFWorkbook(fis);
			workbook.close();
			//
			// Get the first sheet on the workbook.
			//
			XSSFSheet sheet = workbook.getSheet(sheetname);
			//
			// When we have a sheet object in hand we can iterator on
			// each sheet's rows and on each row's cells. We store the
			// data read on an ArrayList so that we can printed the
			// content of the excel to the console.
			//
			Iterator<?> rows = sheet.rowIterator();
			if (rows.hasNext()) {
				while (rows.hasNext()) {
					XSSFRow row = (XSSFRow) rows.next();

					List<String> v = new ArrayList<String>();

					for (int i = 0; i < 12; i++) {
						XSSFCell cell = row.getCell(i, XSSFRow.RETURN_NULL_AND_BLANK);

						if (cell == null || cell.equals("")) {
							v.add("");
						} else {
							String format = formatter.formatCellValue(cell);
							v.add(format);
						}
					}

					sheetData.add(v);
				}
			} else {
				System.out.println("Sheet has no data");
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (fis != null) {
				fis.close();
			}
		}
%>
<%
	job.processData(sheetData);
%>
<center>
<h3>Sheet Uploaded Successfully</h3><br/>
<a href="profile.jsp" class="btn">Please Click Here</a>
</center>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*" import="java.sql.*"%>
<%!
	String url = "jdbc:mysql://localhost:3306/"; /*Database URL with PORT*/
	String dbName = "CRM"; /*Database name*/
	String userName = "root"; /*Database Username*/
	String pwd = "numerouno"; /*Database Password*/

	Connection connect;
	PreparedStatement preStatement;
	Statement statement, statement1;
	ResultSet rs, rs1;

	String username;
	int userid;

	int cust_id = 0;
%>
<%
	/*
	 * Preventing User to come back after logout.
	 */
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);

	username = (String) session.getAttribute("username");
	userid = (int) session.getAttribute("userid");

	//if the username is not present just redirect to login page.
	if (username == null) {
		response.sendRedirect("index.jsp");
	}

	//initialize the database connection only after validating user. 
	try {
		Class.forName("com.mysql.jdbc.Driver");
		connect = DriverManager.getConnection(url + dbName, userName, pwd);
		statement = connect.createStatement();
		statement1 = connect.createStatement();
	} catch (SQLException sqle) {
		sqle.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>

<head>
<title>Full page demo | table fixed header</title>
<link rel="stylesheet" type="text/css" href="jquery-ui/css/redmond/jquery-ui-1.8.4.custom.css" />
<link rel="stylesheet" type="text/css" href="jquery-ui/css/ui-lightness/jquery-ui-1.8.4.custom.css" />
<link rel="stylesheet" type="text/css" href="jquery-ui/css/smoothness/jquery-ui-1.8.4.custom.css" />
<link rel="stylesheet" type="text/css" href="jquery-ui/css/redmond/jquery-ui-1.8.4.custom.css" id="link" />
<link rel="stylesheet" type="text/css" href="css/base.css" />

<script src="//code.jquery.com/jquery-1.9.0.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.js"></script>
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jqueryui/1.8.4/jquery-ui.min.js"></script>
<script type="text/javascript" src="highlighter/codehighlighter.js"></script>
<script type="text/javascript" src="highlighter/javascript.js"></script>
<script type="text/javascript" src="javascript/jquery.fixheadertable.min.js"></script>

<script type="text/javascript" src="js/jquery.ui.core.min.js"></script>
<script type="text/javascript" src="js/jquery.ui.widget.min.js"></script>
<script type="text/javascript" src="js/jquery.ui.mouse.min.js"></script>
<script type="text/javascript" src="js/jquery.ui.sortable.min.js"></script>
<script type="text/javascript" src="js/jquery.ui.tabs.min.js"></script>
<script type="text/javascript" src="js/jquery.ui.button.js"></script>
<style type="text/css">
body {
	background: url(images/blue_abstract_background.jpg) no-repeat fixed;
	background-size: cover;
	font-family: Verdana, Arial, Geneva, Helvetica, sans-serif;
	font-size: 12px;
	margin: 0;
	padding: 0;
}
.topPanel {
	height: 30px;
	padding: 10px 60px 0 60px;
	text-align: right;
	color: white;
}
a {
	color: #ffffff;
	text-decoration: none;
}
a:hover {
	color: #ffffff;
	text-decoration: underline;
}
</style>
	<style type="text/css">
		.javascript .comment {
			color: green;
		}
		.javascript .string {
			color: maroon;
		}
		.javascript .keywords {
			font-weight: bold;
		}
		.javascript .global {
			color: blue;
			font-weight: bolder;
		}
		.javascript .brackets {
			color: Gray;
		}
		.javascript .thing {
			font-size: 10px;
		}
		span.text {
			font-weight: normal;
			font-style: italic;
			margin-left: 10px;
		}
		div.title {
			font-size: 18px;
			padding: 15px 0;
			font-weight: bold;
		}
		div.title span {
			font-weight: normal;
		}
		div.themes {
			overflow: hidden;
			width: 150px;
			position: fixed;
			top: 180px;
			left: 10px;
		}
		div.themes button {
			width: 120px;
			margin-bottom: 5px;
		}
		div.themes a {
			display: block;
			font-size: 1.1em;
			margin-bottom: 5px;
			text-decoration: none;
			padding: 3px;
			width: 120px;
		}
		div.themes a:focus {
			outline: none;
		}
		div.themes a.top {
			color: black;
		}
		div.themes a.top:hover {
			text-decoration: underline;
		}
	</style>
	<style type="text/css">
		.ui-tabs {
			padding: 4px 4px 4px 4px;
		}
		.ui-tabs .ui-tabs-nav {
			font-family: Arial;
			font-size: 13px;
			padding: 4px 4px 0px 4px;
		}
		.ui-tabs .ui-tabs-nav li {
			font-weight: normal;
			font-style: normal;
			margin: 0px 2px -1px 0px;
		}
		.ui-tabs .ui-tabs-nav li a {
			padding: 8px 10px 8px 10px;
		}
		#topPanel {
			height: 30px;
			padding: 10px 60px 0 60px;
			text-align: right;
			color: white;
		}
	</style>
<script type="text/javascript">
	$(document).ready(function () {
		var jQueryTabs1Opts = {
			event: 'click',
			deselectable: 'false'
		};
		$("#jQueryTabs1").tabs(jQueryTabs1Opts);
	});
	
	$(function () {
		$("input:button, input:submit, input:file", ".options").button();
	});
	
	function searchTable(inputVal, tableObject) {
		var table = $(tableObject);
		table.find('tr').each(function(index, row) {
			var allCells = $(row).find('td');
			if (allCells.length > 0) {
				var found = false;
				allCells.each(function(index, td) {
					var regExp = new RegExp(inputVal, 'i');
					if (regExp.test($(td).text())) {
						found = true;
						return false;
					}
				});
				if (found == true)
					$(row).show();
				else
					$(row).hide();
			}
		});
	}

	$(document).ready(function() {
		$('.resultset').fixheadertable({
			colratio : [ 50, 80, 250, 200, 250, 350, 250, 200, 200 ],
			height : 420,
			width : 0,
			zebra : false,
			resizeCol : true,
			sortable : true,
			sortedColId : 1,
			sortType : [ 'string', 'integer', 'string', 'string', 'string', 'string', 'string', 'string', 'string' ],
		});
	});

	$(document).ready(function() {
	<%
		String jquery = "select Dsr_Name from UserDsr where User_ID="+ userid;
		rs = statement.executeQuery(jquery);

		while (rs.next()) {
			String tabname = rs.getString(1);
	%>
		$('#search<%=rs.getRow()%>').keyup(function() {
			searchTable($(this).val(), "#<%=rs.getRow()%>");
		});
		
	<%
		}
	%>
	});
	
	$(function() {
		$('.display').on('click', function() {
			var cal = $('input[name=rowId]:checked').val();
			window.location.href = "completedetails.jsp?rowId=" + cal;
		});
	});
</script>
</head>

<body>
	<div class="topPanel ui-widget-header">
		<div class="topLeftPanel" style="float: left;">
			<label>Welcome, <%=username%></label>
		</div>
		<div class="topRightPanel" style="float: right;">
			<a href="logout.jsp">Sign-Out</a>
		</div>
	</div>

	<div id="jQueryTabs1" style="clear: both; width: 90%; margin: 20px auto;">
		<ul>
		<%
			String query = "select Dsr_Name from UserDsr where User_ID="+ userid;
			rs = statement.executeQuery(query);

			while (rs.next()) {
				String tabname = rs.getString(1);
		%>
				<li><a href="#tab<%= rs.getRow()%>"><span><%=tabname%></span></a></li>
		<%
			}
		%>
		</ul>
		<%
				String q = "select DSR_ID, Dsr_Name from UserDsr where User_ID="+ userid;
				rs = statement.executeQuery(q);

				while (rs.next()) {
					int dsrid = rs.getInt(1);
					String dsrname = rs.getString(2);
		%>
			<div style="height: 500px; overflow: auto; font-size: 13px;" id="tab<%= rs.getRow()%>">
		
			<div class="options" style="text-align: center; padding-bottom: 10px;">
				<input type="button" value="Details" class="display" style="float: left;">
				<input type="text" id="search<%= rs.getRow()%>" placeholder="Search Table..." style="padding: 5px; border-radius: 5px; border: 1px solid #f2f;">
				<form action="Copy of index.jsp" method="post" enctype="multipart/form-data" style="float: right;">
					<input type="hidden" name="dsrid" value="<%=dsrid%>" />
					<input type="file" name="file" size="50" />
					<input type="submit" value="Upload Excel" />
				</form>
			</div>
			<table class="resultset" id="<%= rs.getRow()%>">
				<thead>
					<tr>
						<th align="center"></th>
						<th>Sr. No</th>
						<th>Company Name</th>
						<th>Contact Person</th>
						<th>Contact No</th>
						<th>Address</th>
						<th>Email-ID</th>
						<th>Website</th>
						<th>Present Status</th>
					</tr>
				</thead>
				<tbody>
					<%
						String query1 = "select * from Dsrdata where DSR_ID=" + dsrid;
						rs1 = statement1.executeQuery(query1);

						while (rs1.next()) {
							int id = rs1.getInt(2);
							String cname = rs1.getString(3);
							String cperson = rs1.getString(4);
							String ccontact = rs1.getString(5);
							String caddress = rs1.getString(6);
							String cemailid = rs1.getString(7);
							String cwebsite = rs1.getString(8);
							String cstatus = rs1.getString(9);
					%>
						<tr class="rowdata">
							<td><input type="radio" name="rowId" value="<%=id%>" /></td>
							<td><%=rs1.getRow()%></td>
							<td><%=cname%></td>
							<td><%=cperson%></td>
							<td><%=ccontact%></td>
							<td><%=caddress%></td>
							<td><%=cemailid%></td>
							<td><%=cwebsite%></td>
							<td><%=cstatus%></td>
						</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
		<%
			}
		%>
	</div>
</body>

</html>

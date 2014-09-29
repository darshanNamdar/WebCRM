<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*" import="java.sql.*"%>
<!DOCTYPE HTML>
<html>

<head>
<title>NumeroUno CRM</title>
<link rel="stylesheet" type="text/css" href="css/tablesort.css">
<link rel="stylesheet" type="text/css" href="css/styles.css">
<link rel="stylesheet" type="text/css" href="//code.jquery.com/ui/1.11.1/themes/redmond/jquery-ui.css">
<script type="text/javascript" src="//code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
<script type="text/javascript" src="js/tablesort.js"></script>
<script type="text/javascript">
	function loadOldComments() {
		var custid = $('input[name=custid]').val();
		var username = $('input[name=username]').val();
		var comment = $('input[name=comment]').val();
		var conversation = $('#conversation option:selected').val();
		var remarks = $('#remarks option:selected').val();
		var newdate = $('input[name=newdate]').val();

		$.post('InsertComment.do', {
			custid : custid,
			username: username,
			conversation: conversation,
			comment: comment,
			remarks: remarks,
			newdate: newdate
		}, function(responseText) {
			$('.tb').html(responseText);
			location.reload();
		});
	}
	
	$(function() {
		var jQueryDatePicker1Opts = {
			dateFormat : 'dd-mm-y',
			changeMonth : false,
			changeYear : false,
			showButtonPanel : false,
			showAnim : 'show',
			minDate: 0
		};
		$("#jQueryDatePicker1").datepicker(jQueryDatePicker1Opts);
	});

	$(function () {
		$('table.table-sort').tablesort();
	});

	$(function() {
		$('#addcomment').on('click', loadOldComments);
	});
	</script>
<style type="text/css">
body {
	background: url(images/blue_abstract_background.jpg) no-repeat fixed;
	background-size: cover;
	margin: 0;
	padding: 0;
}
#dlgbox {
	border-radius: 10px;
	background-color: #7c7d7e;
	width: 90%;
	margin: 20px auto;
}

#dlg-header {
	/*			background-color: #6d84b4;*/
	color: white;
	font-size: 20px;
	padding: 10px;
}

.pad {
	border: none;
	border-radius: 5px;
	padding: 5px;
}

.btn {
	background: #9f3f3f;
	background-image: -webkit-linear-gradient(bottom, rgb(202, 0, 89),
		rgb(243, 0, 107));
	background-attachment: local;
	font-size: 13px;
	padding: 6px 10px 6px 10px;
	text-decoration: none;
	border: none;
	cursor: pointer;
	color: white;
}

.btn:hover {
	background: #3cb0fd;
	background-image: -webkit-linear-gradient(bottom, rgb(243, 0, 107), rgb(202, 0, 89));
	text-decoration: none;
}

.newCommentSection {
	text-align: center;
	padding-bottom: 10px;
	padding-top: 10px;
}

#dlg-footer {
	padding: 10px;
	text-align: center;
	background: white;
}
</style>
</head>

<body>
<%!
	Connection connect;
	PreparedStatement preStatement = null;
	Statement statement = null;
	ResultSet rs = null;
	
	String url = "jdbc:mysql://localhost:3306/"; /*Database URL with PORT*/
	String dbName = "CRM"; /*Database name*/
	String userName = "root"; /*Database Username*/
	String pwd = "numerouno"; /*Database Password*/
	
	int cust_id = 0;
	String next_calling_date = "";
%>
<%
	String username = (String) session.getAttribute("username");

	try {
		Class.forName("com.mysql.jdbc.Driver");
		connect = DriverManager.getConnection(url + dbName, userName, pwd);
		statement = connect.createStatement();
		System.out.println("Database Connection Established");
	} catch (SQLException sqle) {
		sqle.printStackTrace();
	}
%>
	<div id="dlgbox">
		<div id="dlg-header" class="ui-widget-header">Complete Details</div>
		<div id="dlg-body">
		<%
			String retrievecomments = (String) request.getParameter("rowId");

			if (retrievecomments == null || retrievecomments.equals("")) {
				retrievecomments = "";
			} else {
				int comp_id = Integer.parseInt(retrievecomments);

				String url = "jdbc:mysql://localhost:3306/";	/*Database URL with PORT*/
				String dbName = "CRM";							/*Database name*/
				String userName = "root";						/*Database Username*/
				String pwd = "numerouno";						/*Database Password*/

				try {
					String query = "select * from Dsrdata where Company_ID="+ comp_id;
					String query2 = "select Next_calling_date from Conversation_Record where Customer_id="+comp_id;
					
					/*Get the Next calling date of customer*/
					rs = statement.executeQuery(query2);
					
					while(rs.next()) {
						next_calling_date = rs.getString(1);
					}
					
					/*Fetch complete information about customer*/
					rs = statement.executeQuery(query);

					while (rs.next()) {
						cust_id = rs.getInt(2);
						String comp_name = rs.getString(3);
						String comp_person = rs.getString(4);
						String comp_cont = rs.getString(5);
						String comp_addr = rs.getString(6);
						String comp_email = rs.getString(7);
						String comp_web = rs.getString(8);
						String comp_status = rs.getString(9);
		%>
			<table>
				<tr><td><b>Company Name:</b></td>
					<td><%= comp_name%></td>
					<td><b>Present Status:</b></td>
					<td><%= comp_status%></td>
				</tr>
				<tr>
					<td><b>Contact Person:</b></td>
					<td><%= comp_person%></td>
					<td><b>Next Calling Date:</b></td>
					<td><%= next_calling_date%></td>
				</tr>

				<tr>
					<td><b>Contact:</b></td>
					<td><%= comp_cont%></td>
					<td><input type="hidden" name="custid" value="<%= cust_id%>"></td>
					<td><input type="hidden" name="username" value="<%= username%>"></td>
				</tr>
				<tr>
					<td><b>Address:</b></td>
					<td><%= comp_addr%></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td><b>Email-ID:</b></td>
					<td><%= comp_email%></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td><b>Website:</b></td>
					<td><%= comp_web%></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
		<%
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
		%>
			<table class="table-sort table-sort-search">
				<thead>
					<tr>
						<th>Sr. No</th>
						<th class="table-sort">Type</th>
						<th>Old Comments</th>
						<th class="table-sort">Remarks</th>
						<th class="table-sort">Updated By</th>
						<th class="table-sort">Updated On</th>
						<th class="table-sort">Next Calling Date</th>
					</tr>
				</thead>
				<tbody class="tb">
				<%
					if (comp_id == 0) {}
					else {
						String query2 = "select * from Conversation_Record where Customer_id="+ comp_id;
						try {
							rs = statement.executeQuery(query2);

							while (rs.next()) {
								int cust_id = rs.getInt(1);
								String conv_type = rs.getString(3);
								String conv_comment = rs.getString(4);
								String conv_remark = rs.getString(5);
								String conv_user = rs.getString(6);
								String conv_date = rs.getString(7);
								String next_call_date = rs.getString(8);
				%>
					<tr>
						<td><%=rs.getRow()%></td>
						<td><%=conv_type%></td>
						<td><%=conv_comment%></td>
						<td><%=conv_remark%></td>
						<td><%=conv_user%></td>
						<td><%=conv_date%></td>
						<td><%=next_call_date%></td>
					</tr>
				<%
							}
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
				%>
				</tbody>
			</table>
			<div class="newCommentSection ui-widget-header" style="text-align: center;padding-bottom: 10px;">
				<input type="text" size="95" name="comment" class="pad"
					placeholder="New Comment" /> <select
					id="conversation" class="pad" name="conversation">
					<option value="">Call Type</option>
					<option value="Meeting">Meeting</option>
					<option value="Calling">Calling</option>
				</select>
				<select id="remarks" class="pad" name="remarks">
					<option value="">Select Remark</option>
					<option value="1st Meeting Fix">1st Meeting Fix</option>
					<option value="2nd Meeting Fix">2nd Meeting Fix</option>
					<option value="Follow Up">Follow Up</option>
					<option value="No doesn't exists">No doesn't exists</option>
					<option value="Not Interested">Not Interested</option>
					<option value="1st Meeting Done">1st Meeting Done</option>
					<option value="2nd Meeting Done">2nd Meeting Done</option>
					<option value="Closed">Closed</option>
				</select>
				<input type="text" name="newdate" class="pad"
					id="jQueryDatePicker1" placeholder="Next Calling Date"
					style="width: 148px;" />
				<input type="button" class="btn" id="addcomment" value="Add Comment" />
			</div>
			<div id="dlg-footer"><a class="btn" href="profile.jsp">Done</a></div>
		</div>
	</div>


</body>

</html>

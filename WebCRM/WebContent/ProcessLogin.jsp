<%@page language="java" import="java.sql.*"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		String username = request.getParameter("userName");
		String password = request.getParameter("userPassword");

		out.println(username);
		out.println(password);

		try {
			String url = "jdbc:mysql://localhost:3306/"; /*Database URL with PORT*/
			String dbName = "CRM"; /*Database name*/
			String dbUsername = "root"; /*Database Username*/
			String dbPassword = "numerouno"; /*Database Password*/

			Connection connect;
			Statement statement;
			ResultSet rs;

			Class.forName("com.mysql.jdbc.Driver");
			connect = DriverManager.getConnection(url + dbName, dbUsername,dbPassword);
			statement = connect.createStatement();

			rs = statement.executeQuery("select * from NumeroUsers where Username='"+ username+ "' and UserPassword='"+ password+ "'");

			if (rs.next()) {
				int queryUserID = rs.getInt(1);
				String queryUsertype = rs.getString(2);
				String queryUsername = rs.getString(3);
				String queryPassword = rs.getString(4);
				
				if (queryUsername.equals(username) && queryPassword.equals(password)) {
					
					session.setAttribute("userid", queryUserID);
					session.setAttribute("username", username);
					session.setAttribute("usertype", queryUsertype);

					response.sendRedirect("profile.jsp");
				}
			} else {
				response.sendRedirect("index.jsp");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	%>
</body>
</html>
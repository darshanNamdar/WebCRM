package classes;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/InsertComment.do")
public class InsertComment extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/plain");
		
		PrintWriter pw = response.getWriter();
		
		String username = (String) request.getParameter("username");

		Connection connect = null;
		PreparedStatement preStatement = null;
		Statement statement = null;
		ResultSet rs = null;
		
		String url = "jdbc:mysql://localhost:3306/"; /*Database URL with PORT*/
		String dbName = "CRM"; /*Database name*/
		String userName = "root"; /*Database Username*/
		String pwd = "numerouno"; /*Database Password*/
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connect = DriverManager.getConnection(url + dbName, userName, pwd);
			statement = connect.createStatement();
			System.out.println("Database Connection Established");
		} catch (SQLException | ClassNotFoundException sqle) {
			sqle.printStackTrace();
		}
		
		String insertcomment = (String) request.getParameter("custid");

		if (insertcomment == null) {
			insertcomment = "";
		} else {
			int custid = Integer.parseInt(insertcomment);

			if (custid == 0) {
			} else {
				String type = request.getParameter("conversation");
				String comment = request.getParameter("comment");
				String remark = request.getParameter("remarks");
				String nextdate = request.getParameter("newdate");

				java.util.Date currentdate = Calendar.getInstance().getTime();
				java.text.SimpleDateFormat formateddate = new java.text.SimpleDateFormat("dd-MM-yy");

				String newdate = formateddate.format(currentdate);

				String query1 = "insert into Conversation_Record values (?,?,?,?,?,?,?,?)";
				String query2 = "update Dsrdata set Present_Status='"+ remark + "' where Company_ID=" + custid;
				String query3 = "select * from Conversation_Record where Customer_id="+  custid;

				try {
					/*
					 * 
					 */
					preStatement = connect.prepareStatement(query1);
					preStatement.setInt(1, custid);
					preStatement.setInt(2, 0);
					preStatement.setString(3, type);
					preStatement.setString(4, comment);
					preStatement.setString(5, remark);
					preStatement.setString(6, username);
					preStatement.setString(7, newdate);
					preStatement.setString(8, nextdate);
					preStatement.executeUpdate();
					System.out.println("Data inserted");

					/*
					 * 
					 */
					statement.executeUpdate(query2);
					
					/*
					 * 
					 */
					rs = statement.executeQuery(query3);

					while (rs.next()) {
						String conv_type = rs.getString(3);
						String conv_comment = rs.getString(4);
						String conv_remark = rs.getString(5);
						String conv_user = rs.getString(6);
						String conv_date = rs.getString(7);
						String next_call_date = rs.getString(8);
						
						pw.write("<tr>");
						pw.write("<td>"+rs.getRow()+"</td>");
						pw.write("<td>"+conv_type+"</td>");
						pw.write("<td>"+conv_comment+"</td>");
						pw.write("<td>"+conv_remark+"</td>");
						pw.write("<td>"+conv_user+"</td>");
						pw.write("<td>"+conv_date+"</td>");
						pw.write("<td>"+next_call_date+"</td>");
						pw.write("</tr>");
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

}

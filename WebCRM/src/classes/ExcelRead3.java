package classes;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ExcelRead3 {

	private static Connection connect;
	private static PreparedStatement prestatement1, prestatement2;
	private static Statement statement;
	private static ResultSet rs;

	private String userName = "";
	private String sheetName = "";
	private int dsrId = 0;
	
	/*
	 * 
	 */
	public String getUsername() {
		return userName;
	}

	public void setUsername(String username) {
		this.userName = username;
	}

	/*
	 * 
	 */
	public String getSheetName() {
		return sheetName;
	}

	public void setSheetName(String sheetName) {
		this.sheetName = sheetName;
	}
	
	/*
	 * 
	 */
	public int getDsrId() {
		return dsrId;
	}

	public void setDsrId(int dsrId) {
		this.dsrId = dsrId;
	}
	
	public void initializeConnection() {

		String url = "jdbc:mysql://localhost:3306/";	/*Database URL with PORT*/
		String dbName = "CRM";							/*Database name*/
		String userName = "root";						/*Database Username*/
		String pwd = "numerouno";						/*Database Password*/

		try {
			Class.forName("com.mysql.jdbc.Driver");
			connect = DriverManager.getConnection(url + dbName, userName, pwd);
			statement = connect.createStatement();

			System.out.println("Database Connection Established");
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public void processData(List<List<String>> sheetData) {
		
		List<List<String>> checkEntry = sheetData;
		List<List<String>> newEntry = new ArrayList<List<String>>();

		for(int i=0; i<checkEntry.size(); i++) {
			List<String> d = checkEntry.get(i);
			String name = d.get(0);

			for(int j=0; j<checkEntry.size(); j++) {
				boolean exist = checkEntry.get(j).contains(name);

				if(exist) {
					boolean alreadyAdded = newEntry.contains(checkEntry.get(j));

					if(!alreadyAdded) {
						newEntry.add(checkEntry.get(j));
					}
				}
			}
		}

		for(int l=0; l<newEntry.size(); l++) {
			List<String> data = newEntry.get(l);

			if(!data.get(10).equals("")) {
				List<String> meet = new ArrayList<String>();
				meet.add(data.get(0));
				meet.add(data.get(1));
				meet.add(data.get(2));
				meet.add(data.get(3));
				meet.add(data.get(4));
				meet.add(data.get(5));
				meet.add(data.get(10));
				meet.add("1st Meeting Done");
				meet.add(data.get(8));
				meet.add(data.get(9));
				meet.add("");
				meet.add("");
				newEntry.add(meet);
			}
			if(!data.get(11).equals("")) {
				List<String> meet = new ArrayList<String>();
				meet.add(data.get(0));
				meet.add(data.get(1));
				meet.add(data.get(2));
				meet.add(data.get(3));
				meet.add(data.get(4));
				meet.add(data.get(5));
				meet.add(data.get(11));
				meet.add("2nd Meeting Done");
				meet.add(data.get(8));
				meet.add(data.get(9));
				meet.add("");
				meet.add("");
				newEntry.add(meet);
			}
			for(int m=0; m<data.size(); m++) {
				System.out.print(data.get(m));
				System.out.println();
			}	
		}

		for(int l=0; l<newEntry.size(); l++) {
			List<String> data = newEntry.get(l);

			try {
				System.out.println(data.get(0));

				String comp_name = data.get(0);

				if(!comp_name.equals("")) {
					String query1 = "select * from Dsrdata where Company_Name='"+comp_name+"' and DSR_ID="+dsrId;
					String query2 = "insert into Dsrdata values (?,?,?,?,?,?,?,?,?)";
					String query3 = "insert into Conversation_Record values (?,?,?,?,?,?,?,?)";

					System.out.println(query1);
					System.out.println(query2);

					rs = statement.executeQuery(query1);
					prestatement1 = connect.prepareStatement(query2);
					prestatement2 = connect.prepareStatement(query3);

					String remark_finalStatus = data.get(7);

					if(remark_finalStatus.equals("")) {
						remark_finalStatus = "Calling";
					} else {
						remark_finalStatus = "Meeting";
					}

					if(rs.next()) {
						System.out.println("Result Executed");

						prestatement2.setInt(1, rs.getInt(2));
						prestatement2.setInt(2, 0);
						prestatement2.setString(3, remark_finalStatus);
						prestatement2.setString(4, data.get(6));
						prestatement2.setString(5, data.get(7));
						prestatement2.setString(6, userName);
						prestatement2.setString(7, data.get(8));
						prestatement2.setString(8, data.get(9));
						prestatement2.executeUpdate();

						System.out.println("Data inserted into Conversation_Record table");

						String query4 = "update Dsrdata set Present_Status='"+data.get(7)+"' where Company_ID="+rs.getInt(2);
						statement.executeUpdate(query4);
						System.out.println("Dsrdata Data Updated");

					} else {
						prestatement1.setInt(1, dsrId);
						prestatement1.setInt(2, 0);
						prestatement1.setString(3, data.get(0));
						prestatement1.setString(4, data.get(1));
						prestatement1.setString(5, data.get(2));
						prestatement1.setString(6, data.get(3));
						prestatement1.setString(7, data.get(4));
						prestatement1.setString(8, data.get(5));
						prestatement1.setString(9, data.get(7));
						prestatement1.executeUpdate();

						System.out.println("Data inserted into Dsrdata table");

						String retrieveID = "SELECT LAST_INSERT_ID()";
						int id = 0;

						rs = statement.executeQuery(retrieveID);
						while(rs.next()) {
							id = rs.getInt(1);
						}

						prestatement2.setInt(1, id);
						prestatement2.setInt(2, 0);
						prestatement2.setString(3, remark_finalStatus);
						prestatement2.setString(4, data.get(6));
						prestatement2.setString(5, data.get(7));
						prestatement2.setString(6, userName);
						prestatement2.setString(7, data.get(8));
						prestatement2.setString(8, data.get(9));
						prestatement2.executeUpdate();
						System.out.println("Data inserted into Conversation_Record table");
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
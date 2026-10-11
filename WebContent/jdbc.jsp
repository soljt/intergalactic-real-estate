<!--
A JSP file that encapsulates database connections.

Public methods:
- public void getConnection() throws SQLException
- public void closeConnection() throws SQLException  
-->

<%@ page import="java.sql.*"%>

<%!
	// User id, password, and server information
	private String url = "jdbc:postgresql://cosc304-postgres:5432/orders?stringtype=unspecified";
	private String uid = "shop";
	private String pw = System.getenv("DB_PASSWORD");

	// Connection
	private Connection con = null;
%>

<%!
	public void getConnection() throws SQLException 
	{
		try
		{	// Load driver class
			Class.forName("org.postgresql.Driver");
		}
		catch (java.lang.ClassNotFoundException e)
		{
			throw new SQLException("ClassNotFoundException: " +e);
		}
	
		con = DriverManager.getConnection(url, uid, pw);
	}
   
	public void closeConnection() throws SQLException 
	{
		if (con != null)
			con.close();
		con = null;
	}
%>

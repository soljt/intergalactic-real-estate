<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
<link rel="stylesheet" href="css/styles2.css">
</head>
<body>
<%@ include file="header.jsp" %>
<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<div class="table-section">
	<h1>Customer Profile</h1>
	<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%

// TODO: Print Customer information
try{
	getConnection();
	String sql = String.format("SELECT customerId, firstName,	lastName, email, phonenum, address,	city, state, postalCode, country, userid FROM customer WHERE userid = '%s'",userName);
	Statement stmt = con.createStatement();
	ResultSet rst = stmt.executeQuery(sql);
	rst.next();
	out.println(String.format("<table class=\"doc-table\"><tbody><tr><th>ID</th><td>%d</td></tr>",rst.getInt(1)));
	out.println(String.format("<tr><th>First Name</th><td>%s</td></tr>",rst.getString(2)));
	out.println(String.format("<tr><th>Last Name</th><td>%s</td></tr>",rst.getString(3)));
	out.println(String.format("<tr><th>Email</th><td>%s</td></tr>",rst.getString(4)));
	out.println(String.format("<tr><th>Phone</th><td>%s</td></tr>",rst.getString(5)));
	out.println(String.format("<tr><th>Address</th><td>%s</td></tr>",rst.getString(6)));
	out.println(String.format("<tr><th>City</th><td>%s</td></tr>",rst.getString(7)));
	out.println(String.format("<tr><th>State</th><td>%s</td></tr>",rst.getString(8)));
	out.println(String.format("<tr><th>Postal Code</th><td>%s</td></tr>",rst.getString(9)));
	out.println(String.format("<tr><th>Country</th><td>%s</td></tr>",rst.getString(10)));
	out.println(String.format("<tr><th>User ID</th><td>%s</td></tr>",rst.getString(11)));
	out.println("</tbody></table>");
	
}catch(SQLException ex){
	out.println(ex);
}finally{
	if (con != null)
		try{
			con.close();
		}catch(SQLException ex){
			out.println(ex);
		}
	con = null;
}


// Make sure to close connection
%>
</div>




</body>
</html>


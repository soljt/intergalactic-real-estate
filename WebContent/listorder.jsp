<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order List</title>
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
</head>
<body>
	<%@ include file="jdbc.jsp" %>
	<%@ include file="header.jsp" %>
<h1 align="center">Order List</h1>

<div class="row justify-content-center">
	<div class="col-lg-6">
		<%
		//Note: Forces loading of SQL Server driver
		try
		{	// Load driver class
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		}
		catch (java.lang.ClassNotFoundException e)
		{
			out.println("ClassNotFoundException: " +e);
		}
		
		// Useful code for formatting currency values:
		// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		// out.println(currFormat.format(5.0);  // Prints $5.00
		
		
		
		/* this is what I have added. should work if you can get all the docker working*/
		String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
		String uid = "sa";
		String pw = "304#sa#pw";
			
		try ( Connection con = DriverManager.getConnection(url, uid, pw);
				Statement stmt = con.createStatement();) 
		{	
			NumberFormat currFormat = NumberFormat.getCurrencyInstance();
			// Write query to retrieve all order summary records
			String outerQuery = "SELECT orderId, orderSummary.customerId, firstName, lastName, totalAmount FROM orderSummary join customer on customer.customerId = orderSummary.customerId";
			String innerQuery = "SELECT productId, quantity, price FROM orderProduct WHERE orderId = ?";
			PreparedStatement pstmt = con.prepareStatement(innerQuery);
			ResultSet rst = stmt.executeQuery(outerQuery);
			
			out.println("<table class=\"table table-bordered table-secondary table-hover table-striped\">");
			out.println("<tbody>");		
			out.println("<tr>");	
			out.println("<th>Order ID</th><th>Customer ID</th><th>Customer Name</th><th>Total Amount</th>");
			out.println("</tr>");
			// For each order in the ResultSet
			while (rst.next())
			{	
				// Print out the order summary information
				out.println("<tr class=\"custinfo\">");
				int orderId = rst.getInt("orderId");
				out.println("<td>" + orderId + "</td>");
				out.println("<td>" + rst.getInt("customerId") + "</td>");
				out.println("<td>" + rst.getString("firstName") + " " + rst.getString("lastName")+ "</td>");
				out.println("<td>" + currFormat.format(rst.getDouble("totalAmount")) + "</td>");
				out.println("</tr>");
				
				// Write a query to retrieve the products in the order
				//   - Use a PreparedStatement as will repeat this query many times
				pstmt.setInt(1, orderId);
				ResultSet rst2 = pstmt.executeQuery();
		
				// For each product in the order
				// Write out product information 
				out.println("<tr align = \"right\"><td colspan = 4><table class=\"table table-dark table-hover table-striped\"><tbody><tr><th>Product ID</th><th>Quantity</th><th>Price</th></tr>");
				while (rst2.next()){
					out.println("<tr>");
					out.println("<td>" + rst2.getInt("productId") + "</td>");
					out.println("<td>" + rst2.getInt("quantity") + "</td>");
					out.println("<td>" + currFormat.format(rst2.getDouble("price")) + "</td>");
					out.println("</tr>");
				}
				out.println("</tbody></table></tr>");
			}
			out.println("</tbody>");	
			out.println("</table>");
		}
		catch (SQLException ex)
		{
			out.println("SQLException: " + ex);
		}finally{
			out.println("<a class=\"btn btn-info\" href=\"index.jsp\" role=\"button\">Back to Homepage</a>");
		}

		%>

	</div>

</div>



</body>
</html>


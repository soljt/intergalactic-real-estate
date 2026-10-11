<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order List</title>
<link rel="stylesheet" href="bg-styles.css">
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
</head>
<style>
  body {
    background: url('images/background2.jpg') center center / cover no-repeat fixed;
	background-attachment: fixed;
    min-height: 100vh;
    color: white; /* Default text color over background */
    position: relative;
    margin: 0;
    overflow-x: hidden;
  }

  .overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.4); /* darkens background slightly */
    z-index: -1; /* behind content */
  }

  .content {
    position: relative;
    z-index: 1;
    text-align: center;
    padding: 5rem 2rem;
  }
</style>
<body>
	<%@ include file="jdbc.jsp" %>
	<%@ include file="header.jsp" %>
<h1 align="center" class="p-3">Order List</h1>

<div class="row justify-content-center">
	<div class="col-lg-6">
		<%
		//Note: Forces loading of SQL Server driver
		try
		{	// Load driver class
			Class.forName("org.postgresql.Driver");
		}
		catch (java.lang.ClassNotFoundException e)
		{
			out.println("ClassNotFoundException: " +e);
		}
		
		// Useful code for formatting currency values:
		// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		// out.println(currFormat.format(5.0);  // Prints $5.00
		
		
		
		/* this is what I have added. should work if you can get all the docker working*/
		String url = "jdbc:postgresql://cosc304-postgres:5432/orders?stringtype=unspecified";		
		String uid = "shop";
		String pw = System.getenv("DB_PASSWORD");
			
		try ( Connection con = DriverManager.getConnection(url, uid, pw);
				Statement stmt = con.createStatement();) 
		{	
			NumberFormat currFormat = NumberFormat.getCurrencyInstance();
			// Write query to retrieve all order summary records
			String outerQuery = "SELECT orderId, orderSummary.customerId, orderDate, firstName, lastName, totalAmount FROM orderSummary join customer on customer.customerId = orderSummary.customerId";
			String innerQuery = "SELECT productId, quantity, price FROM orderProduct WHERE orderId = ?";
			PreparedStatement pstmt = con.prepareStatement(innerQuery);
			ResultSet rst = stmt.executeQuery(outerQuery);
			
			out.println("<table class=\"table table-bordered table-secondary table-hover table-striped\">");
			out.println("<tbody>");		
			out.println("<tr>");	
			out.println("<th>Order ID</th><th>Date</th><th>Customer ID</th><th>Customer Name</th><th>Total Amount</th>");
			out.println("</tr>");
			// For each order in the ResultSet
			while (rst.next())
			{	
				// Print out the order summary information
				out.println("<tr class=\"custinfo\">");
				int orderId = rst.getInt("orderId");
				out.println("<td>" + orderId + "</td>");
				out.println("<td>" + rst.getDate("orderDate") + "</td>");
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
				out.println("<tr align = \"right\"><td colspan = 5><table class=\"table table-dark table-hover table-striped\"><tbody><tr><th>Product ID</th><th>Quantity</th><th>Price</th></tr>");
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
			out.println("<a class=\"btn btn-info mb-3\" href=\"index.jsp\" role=\"button\">Back to Homepage</a>");
		}

		%>

	</div>

</div>



</body>
</html>


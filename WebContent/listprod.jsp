<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Real Space</title>
<link rel="stylesheet" href="css/styles2.css"/>
<script src="https://kit.fontawesome.com/b0f917e6c7.js" crossorigin="anonymous"></script>
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form align="center" method="get" action="listprod.jsp">
	<div class="formdiv">
		<input  type="text" name="productName" size="50" id="textbox">
	</div>
	<div class="formdiv">
		<input class="product_btn" type="submit" value="Search"><input class="product_btn" type="reset" value="Reset">
	</div>
	<div class="formdiv">
		<p style="background-color:inherit; font-size:11pt;">Leave blank to search all products</p>

	</div>
</form>


<% // Get product name to search for
String name = request.getParameter("productName");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";			
String uid = "sa";
String pw = "304#sa#pw";
	
try ( Connection con = DriverManager.getConnection(url, uid, pw);
Statement stmt = con.createStatement();) 
{	
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	// Write query to retrieve all order summary records
	String sql = "SELECT productId, productName, productPrice FROM product WHERE productName LIKE ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	ResultSet rst;
	if(name != null) {
		pstmt.setString(1, "%" + name + "%");
		rst = pstmt.executeQuery();
	}
	else
		rst = stmt.executeQuery("SELECT productId, productName, productPrice FROM product");
	
	out.println("<table class=\"doc-table\" id=\"product_table\">");
	out.println("<tbody>");		
	out.println("<tr class=\"prod-row\">");	
	out.println("<th></th><th>Product Name</th><th>Price</th>");
	out.println("</tr>");
	// For each order in the ResultSet
	while (rst.next())
	{	
		// Print out the ResultSet

		// For each product create a link of the form
		// addcart.jsp?id=productId&name=productName&price=productPrice

		String pname = rst.getString("productName");
		double price = rst.getDouble("productPrice");
		int pid = rst.getInt("productId");

		out.println("<tr class=\"prod-row\">");
		out.println(String.format("<td><a class=\"product-link\" style=\"font-size:11;\" id=\"add\" href=\"addcart.jsp?id=%d&name=%s&price=%.2f\">Add to cart</a></td>", pid, pname , price));
		out.println(String.format("<td><a class=\"product-link\" href=\"product.jsp?id=%d\">%s</a></td>",pid, pname));
		out.println("<td>" + currFormat.format(price) + "</td>");
		out.println("</tr>");
	}
	out.println("</tbody>");	
	out.println("</table>");
}

// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>



</body>
</html>
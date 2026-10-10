<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Real Space</title>
<link rel="stylesheet" href="bg-styles.css">
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<!--link rel="stylesheet" href="css/styles2.css"/-->
<script src="https://kit.fontawesome.com/b0f917e6c7.js" crossorigin="anonymous"></script>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="text-center mt-3">
	<h1>Search for the products you want to buy:</h1>
	<p class="lead">Leave blank to search for all products</p>
	<div class="row justify-content-center mb-3">
		<div class="col-md-4">
			<form method="get" action="listprod.jsp">
				<div class="input-group mb-3">
					<span class="input-group-text"><i class="bi bi-search"></i></span>
					<input type="text" class="form-control" name="productName">
				</div>
				<div class="input-group">
					<select class="form-select" name="category" id="category">
						<option selected value=0>All Categories</option>
						<option value=1 name="category">Space</option>
						<option value=2 name="category">Galactic</option>
						<option value=3 name="category">Planetary</option>
						<option value=4 name="category">Andromeda</option>
						<option value=5 name="category">Bruh</option>
						
					  </select>
					<button type="submit" class="btn btn-primary">Search</button>
				</div>
				
			</form>
		</div>
	</div>
	
</div>
<div class="container-sm">








	<!--div class="category-search">
		<input type="radio" value=1 name="category"><label>Beverages</label><br>
		<input type="radio" value=2 name="category"><label>Condiments</label><br>
		<input type="radio" value=3 name="category"><label>Dairy Products</label><br>
		<input type="radio" value=4 name="category"><label>Produce</label><br>
		<input type="radio" value=5 name="category"><label>Meat/Poultry</label><br>
		<input type="radio" value=6 name="category"><label>Seafood</label><br>
		<input type="radio" value=7 name="category"><label>Confections</label><br>
		<input type="radio" value=8 name="category"><label>Grains/Cereals</label><br>
	</div-->
	
	





	


<% // Get product name to search for
String name = request.getParameter("productName");
String categoryId = request.getParameter("category");
		
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
String pw = System.getenv("DB_PASSWORD");
	
try ( Connection con = DriverManager.getConnection(url, uid, pw);
Statement stmt = con.createStatement();) 
{	
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	// Write query to retrieve all order summary records

	//Case where both category and name are given
	String sql1 = "SELECT productId, productName,  productImageURL, productDesc, productPrice FROM product WHERE productName LIKE ? AND categoryId=?";

	//Case where only product name is given
	String sql2 = "SELECT productId, productName,  productImageURL, productDesc, productPrice FROM product WHERE productName LIKE ?";

	//Case where only category is given
	String sql3 = "SELECT productId, productName,  productImageURL, productDesc, productPrice  FROM product WHERE categoryId=?";

	//Case where neither category or product name is given
	String sql4 = "SELECT productId, productName,  productImageURL, productDesc, productPrice FROM product";

	PreparedStatement pstmt;
	ResultSet rst;
	if(name != null) {
		//Case 1
		if(!categoryId.equals("0")){
			pstmt = con.prepareStatement(sql1);
			pstmt.setString(1, "%" + name + "%");
			pstmt.setString(2, categoryId);
			rst = pstmt.executeQuery();
		}
		//Case 2
		else{
			pstmt = con.prepareStatement(sql2);
			pstmt.setString(1, "%" + name + "%");
			rst = pstmt.executeQuery();
		}
	}
	else{
		//Case 3
		if(categoryId != null){
			pstmt = con.prepareStatement(sql3);
			pstmt.setString(1, categoryId);
			rst = pstmt.executeQuery();
		}
		//Case 4
		else{
			pstmt = con.prepareStatement(sql4);
			rst = pstmt.executeQuery();	
		}
	}

	out.println("<div class=\"table-responsive my-4 rounded shadow-sm\">");
	out.println("<table class=\"table table-secondary table-striped table-hover table-sm align-middle text-center\">");
	out.println("<thead>");
		
	out.println("<tr>");	
	out.println("<th scope=\"col\" style=\"width: 120px;\"></th><th class=\"text-start\" scope=\"col\">Product Name</th><th scope=\"col\" style=\"width: 150px;\">Image</th><th class=\"text-start\" scope=\"col\">Description</th><th scope=\"col\" style=\"width: 120px;\">Price</th>");
	out.println("</tr>");
	out.println("</thead>");
	out.println("<tbody>");	
	// For each order in the ResultSet
	while (rst.next())
	{	
		// Print out the ResultSet

		// For each product create a link of the form
		// addcart.jsp?id=productId&name=productName&price=productPrice

		String pname = rst.getString("productName");
		double price = rst.getDouble("productPrice");
		int pid = rst.getInt("productId");
		String imurl = rst.getString("productImageURL");
		String desc = rst.getString("productDesc");

		out.println("<tr>");
		out.println(String.format("<td><a class=\"btn btn-link p-0 text-decoration-underline\" id=\"add\" href=\"addcart.jsp?id=%d&name=%s&price=%.2f\">Add to cart</a></td>", pid, pname , price));
		out.println(String.format("<td class=\"text-start\"><a class=\"btn link-primary text-decoration-underline\" href=\"product.jsp?id=%d\">%s</a></td>",pid, pname));
		out.println(String.format("<td>" + "<img class=\"img-fluid img-thumbnail\" style=\"max-width: 100px; height: auto;\" src=\"%s\">" + "</td>", imurl));
		out.println(String.format("<td class=\"text-start\">%s</td>",desc));
		out.println("<td>" + currFormat.format(price) + "</td>");
		out.println("</tr>");
	}
	out.println("</tbody>");	
	out.println("</table>");
}

// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0));	// Prints $5.00
%>
</div>




</div>
</body>
</html>
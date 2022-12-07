<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Real Space - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

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

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";			
String uid = "sa";
String pw = "304#sa#pw";
	
try ( Connection con = DriverManager.getConnection(url, uid, pw);
Statement stmt = con.createStatement();) 
{	
    //Get the current list of products
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");


// Get product name to search for
String productId = request.getParameter("id");
// TODO: Retrieve and display info for the product

if (productList == null)
{	// No products currently in list.  Create a list.
	productList = new HashMap<String, ArrayList<Object>>();
}



String sql = "SELECT productId, productName, productPrice, productImageURL FROM product WHERE productId = ?";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setString(1, productId);
ResultSet rs = pstmt.executeQuery();

while(rs.next()){
    int pid = rs.getInt("productId");
    String pname = rs.getString("productName");
    double price = rs.getDouble("productPrice");
    String img_url = rs.getString("productImageURL");
    
    //Display the product image if there is one
    if(img_url != null){   
        out.println(String.format("<div id=\"product_img_container\"><img src=\"%s\"><img src=\"displayImage.jsp?id=%d\"></div>",img_url, pid));
    }

    
    out.println("<div>");
    //Product name
    out.println(String.format("<h2>%s</h2>", pname));
    //Product ID
    out.println(String.format("<h3>Product ID:%d</h3>", pid));
    //Price
    out.println(String.format("<h3>Price: $%.2f</h3>", price));
    
    //Add to cart link
    out.println(String.format("<a href=\"addcart.jsp?id=%d&name=%s&price=%.2f\">Add to cart</a>", pid, pname, price));
    //Continue shopping link
    out.println("<a href=\"listprod.jsp\">Continue Shopping</a>");
    
    out.println("</div>");
}

String sql2 = "SELECT reviewRating, reviewComment FROM review WHERE productId=?";
PreparedStatement ps2 = con.prepareStatement(sql2);
ps2.setString(1, productId);

ResultSet rs2 = ps2.executeQuery();

while(rs2.next()){
    String reviewRating = "<h3>Rating (out of 5)"+rs2.getString(1) + "</h3>";
    String reviewComment = "\"" + rs2.getString(2) + "\"";

    out.println(reviewRating);
    out.println(reviewComment);
}




		
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
		

}

%>



</body>
</html>


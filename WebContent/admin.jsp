<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<link rel="stylesheet" href="css/styles2.css">
</head>
<body>
<%@ include file="header.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@include file="jdbc.jsp" %>  
<%@include file="auth.jsp" %>
<div class="table-section">
    <h1>Administrator Sales Report by Day</h1>


    <%
    // TODO: Write SQL query that prints out total order amount by day
    
    // Make the connection
    /*String url = "jdbc:sqlserver://mssql-lab7:1433;DatabaseName=tempdb;TrustServerCertificate=True";		
    String uid = "SA";
    String pw = "YourStrong@Passw0rd";*/
    
    NumberFormat currFormat = NumberFormat.getCurrencyInstance();
        
    try //( Connection con = DriverManager.getConnection(url, uid, pw); Statement stmt = con.createStatement();)
    {
        getConnection();
        Statement stmt = con.createStatement();
        String sql = "SELECT sum(totalAmount), YEAR(orderDate),MONTH(orderDate),DAY(orderDate) from OrderSummary GROUP BY YEAR(orderDate),MONTH(orderDate),DAY(orderDate)";
        ResultSet rst = stmt.executeQuery(sql);
        out.println("<table class=\"doc-table\"><tbody><tr><th>Order Date</th><th>Total Order Amount</th></tr>");
        while(rst.next())
        {   out.println("<tr><td>"+rst.getInt(2)+"-"+rst.getInt(3)+"-"+rst.getInt(4)+"</td>"+"<td>"+currFormat.format(rst.getDouble(1))+"</td></tr>");}
        out.println("</tbody></table>");
    }   catch(SQLException ex){
        out.println(ex);
    }finally{
        closeConnection();
    }

    //Stuff done by Wilfred
    //Get parameters for new/update product from form
    String productId = request.getParameter("productId");
    String productName = request.getParameter("productName");
    String productPrice = request.getParameter("productPrice");
    String productDesc = request.getParameter("productDesc");
    String categoryId = request.getParameter("categoryId");

    //Query to create new product
    String new_prod = "INSERT INTO product(productId, productName, productPrice, productDesc, categoryId) VALUES (?, ?, ?, ?, ?)";  
    PreparedStatement pstmt_new = con.prepareStatement(new_prod);

    //Sets new product parameters given inputs
    pstmt_new.setString(1, productId);
    pstmt_new.setString(2, productName);
    pstmt_new.setString(3, productPrice);
    pstmt_new.setString(4, productDesc);
    pstmt_new.setString(5, categoryId);
    
    //Query to update a product
    String update_prod = "UPDATE product SET productName="+productName+", productPrice="+productPrice+", productDesc="+productDesc+"categoryId="+categoryId+" WHERE productId="+productId;
    preparedStatement pstmt_up = con.prepareStatement(update_prod);

    //Deletes product from on product id entered by admin
    String productId = request.getParameter("productId");
    String delete_prod = "DELETE FROM product WHERE productId = ?";
    PreparedStatement pstmt_del = con.prepareStatement(delete_prod);

    
    //Get parameters for customer update from form
    String customerId = request.getParameter("customerId);
    String email = request.getParameter("email");
    String phonenum = request.getParameter("phonenum");
    String userid = request.getParameter("userid");
    String password = request.getParameter("password");

    //Query to update customer
    String update_customer = "UPDATE customer SET email="+email+", phonenum="+phonenum+", userid="+userid+", password="+password+" WHERE customerId="+customerId;
    PreparedStatement pstmt_cust = con.prepareStatement(update_customer);


    //Get parameters for warehouse update from form
    String warehouseId = request.getParameter("warehouseId");
    String warehouseName = request.getParameter("warehouseName");

    //Query to update warehouse
    String update_warehouse = "UPDATE warehouse SET warehouseName="+warehouseName+" WHERE warehouseId="+warehouseId;
    PreparedStatement pstmt_ware = con.prepareStatement(update_warehouse);

    //Get parameters for shipment update from form
    String shipmentDate = request.getParameter("shipmentDate");
    String shipmentDesc = request.getParameter("shipmentDesc");
    String warehouseId = request.getParameter("warehouseId");
    String shipmentId = request.getParameter("shipmentId");

    //Query to update shipment (Order is shipped)
    String ship_order = "UPDATE shipment SET shipmentDate="+shipmentDate+", shipmentDesc="+shipmentDesc+", warehouseId="+warehouseId" WHERE shipmentId="+shipmentId;
    PreparedStatement pstmt_ship = con.prepareStatement(ship_order);

    //Lists customers
    String list_customer = "SELECT customerId, firstName, lastName, email, phonenum, address, userid FROM customer";
    ResultSet rst = stmt.executeQuery(list_customer);
    while(rst.next()) {
        out.println(String.format("<h3>Customer Id: %d First Name: %d Last Name: %d email: %d Phone Number: %d Address: %d User Id: %d</h3>", customerId, firstName, lastName, email, phonenum, address, userid));
    }

    //Restores Database
    RESTORE DATABASE orders FROM DISK = './directory'
    %>
</div>
<form align="center" method="get" action="admin.jsp">
	<div class="formdiv">
		<input  type="text" name="productId" size="50" id="textbox">
		<input  type="text" name="productName" size="50" id="textbox">
		<input  type="text" name="productPrice" size="50" id="textbox">
		<input  type="text" name="productDesc" size="50" id="textbox">
		<input  type="text" name="categoryId" size="50" id="textbox">
	</div>
	<div class="formdiv">
		<input  type="text" name="productId" size="50" id="textbox">
    </div>
    <div class="formdiv">
		<input  type="text" name="warehouseId" size="50" id="textbox">
    </div>
    <div class="formdiv">
		<input  type="text" name="shipmentDate" size="50" id="textbox">
		<input  type="text" name="shipmentDesc" size="50" id="textbox">
		<input  type="text" name="warehouseId" size="50" id="textbox">
		<input  type="text" name="shipmentId" size="50" id="textbox">
    </div>
    <div class="formdiv">
		<input  type="text" name="customerId" size="50" id="textbox">
		<input  type="text" name="email" size="50" id="textbox">
		<input  type="text" name="phonenum" size="50" id="textbox">
		<input  type="text" name="userid" size="50" id="textbox">
		<input  type="text" name="password" size="50" id="textbox">
    </div>
</form>

</body>
</html>


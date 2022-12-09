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

        //Lists customers
        String list_customer = "SELECT customerId, firstName, lastName, email, phonenum, userid FROM customer";
        rst = stmt.executeQuery(list_customer);
        out.println("<table class=\"doc-table\"><tbody><tr><th>Customer Id</th><th>First Name</th><th>Last Name</th><th>Email</th><th>Phone Number</th><th>User Id</th></tr>");
            while(rst.next())
            {   out.println("<tr><td>"+rst.getInt(1)+"</td>"+"<td>"+rst.getString(2)+"</td>"+"<td>"+rst.getString(3)+"</td>"+"<td>"+rst.getString(4)+"</td>"+"<td>"+rst.getString(5)+"</td>"+"<td>"+rst.getString(6)+"</td></tr>");}
            out.println("</tbody></table>");

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
        String update_prod = "UPDATE product SET productName="+productName+" productPrice="+productPrice+" productDesc="+productDesc+"categoryId="+categoryId+" WHERE productId="+productId;
        PreparedStatement pstmt_up = con.prepareStatement(update_prod);
    
        //Deletes product from product id entered by admin
        String delete_prod = "DELETE FROM product WHERE productId = ?";
        PreparedStatement pstmt_del = con.prepareStatement(delete_prod);
        pstmt_del.setString(1, productId);
    
        
        //Get parameters for customer add/update from form
        String customerId = request.getParameter("customerId");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phonenum = request.getParameter("phonenum");
        String uid = request.getParameter("userid");
        String password = request.getParameter("password");
    

        if (customerId != "NULL"){
            //Query to update customer
            String update_customer = "UPDATE customer SET email="+email+"phonenum="+phonenum+"userid="+uid+"password="+password+"WHERE customerId="+customerId;
            stmt.executeUpdate(update_customer);
        } else {
            //Query to add customer
            String add_customer = "INSERT INTO customer(firstName, lastName, email, phonenum, userid, password) VALUES (firstName, lastName, email, phonenum, uid, password)";
            stmt.executeUpdate(add_customer);
        }
        
        //Get parameters for warehouse add/update from form
        String warehouseId = request.getParameter("warehouseId");
        String warehouseName = request.getParameter("warehouseName");
    
        if(warehouseId != "NULL"){
            //Query to update warehouse
            String update_warehouse = "UPDATE warehouse SET warehouseName="+warehouseName+" WHERE warehouseId="+warehouseId;
            stmt.executeUpdate(update_warehouse);
        } else {
            //Query to add warehouse
            String add_customer = "INSERT INTO warehouse(warehouseName) VALUES (warehouseName)";
            stmt.executeUpdate(add_customer);
        }
        
    
        //Get parameters for shipment update from form
        String shipmentDate = request.getParameter("shipmentDate");
        String shipmentDesc = request.getParameter("shipmentDesc");
        String shipmentId = request.getParameter("shipmentId");
    
        //Query to update shipment (ship order)
        String ship_order = "UPDATE shipment SET shipmentDate="+shipmentDate+"shipmentDesc="+shipmentDesc+"warehouseId="+warehouseId+" WHERE shipmentId="+shipmentId;
        PreparedStatement pstmt_ship = con.prepareStatement(ship_order);
        pstmt_ship.executeQuery();
    
       
    
        //Restores Database
        //String restore = "RESTORE DATABASE orders FROM DISK = './WebContent/ddl/orderdb_sql.ddl'";
        //PreparedStatement pstmt_rest = con.prepareStatement(restore);
    }   catch(SQLException ex){
        out.println(ex);
    }finally{
        closeConnection();
    }
    %>
</div>
<form align="left" method="get" action="admin.jsp">
	<div class="formdiv">
        <tr><th>Add/Update Product</th></tr>
		<input  type="text" name="productId" placeholder="Product ID" size="20" id="textbox">
		<input  type="text" name="productName" placeholder="Product Name" size="20" id="textbox">
		<input  type="text" name="productPrice" placeholder="Product Price" size="20" id="textbox">
		<input  type="text" name="productDesc" placeholder="Product Description" size="20" id="textbox">
		<input  type="text" name="categoryId" placeholder="Category ID" size="20" id="textbox">
        <button type="submit" class="btn btn-primary">Add/Update</button>
	</div>
    <div class="formdiv">
        <tr><th>Update Shipment</th></tr>
		<input  type="text" name="shipmentDate" placeholder="Shipment Date" size="20" id="textbox">
		<input  type="text" name="shipmentDesc" placeholder="Shipment Description" size="20" id="textbox">
		<input  type="text" name="warehouseId" placeholder="Warehouse ID" size="20" id="textbox">
		<input  type="text" name="shipmentId" placeholder="Shipment ID" size="20" id="textbox">
        <button type="submit" class="btn btn-primary">Update</button>
    </div>
    <div class="formdiv">
        <tr><th>Add/Update Warehouse</th></tr>
		<input  type="text" name="warehouseId" placeholder="Warehouse ID" size="20" id="textbox">
        <input  type="text" name="warehouseName" placeholder="Warehouse Name" size="20" id="textbox">
        <button type="submit" class="btn btn-primary">Add/Update</button>
    </div>
    <div class="formdiv">
        <tr><th>Add/Update Customer</th></tr>
		<input  type="text" name="customerId" placeholder="Customer ID" size="20" id="textbox">
		<input  type="text" name="firstName" placeholder="First Name" size="20" id="textbox">
		<input  type="text" name="lastName" placeholder="Last Name" size="20" id="textbox">
		<input  type="text" name="email" placeholder="Email" size="20" id="textbox">
		<input  type="text" name="phonenum" placeholder="Phone Number" size="20" id="textbox">
		<input  type="text" name="userid" placeholder="User ID" size="20" id="textbox">
		<input  type="text" name="password" placeholder="Password" size="20" id="textbox">
        <button type="submit" class="btn btn-primary">Add/Update</button>
    </div>
    <div class="formdiv">
        <button type="submit" class="btn btn-primary">Reset Database</button>
    </div>
</form>

</body>
</html>


<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
</head>
<body>
<%@ include file="header.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@include file="jdbc.jsp" %>  
<%@include file="auth.jsp" %>
<%@ page import="java.util.Scanner" %>
<%@ page import="java.io.File" %>

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

    }   catch(SQLException ex){
        out.println(ex.toString());
    }finally{
        closeConnection();
    }
    %>
</div>
<form align="left" method="get" action="adminFunctionality.jsp">
	<div class="formdiv">
        <tr><th>Add/Update Product</th></tr>
		<input  type="text" name="productId" placeholder="Product ID" size="20" id="textbox">
		<input  type="text" name="productName" placeholder="Product Name" size="20" id="textbox">
		<input  type="text" name="productDesc" placeholder="Product Description" size="20" id="textbox">
        <button type="submit" class="btn btn-primary">Add/Update</button>
	</div>
    <div class="formdiv">
        <tr><th>Delete Product</th></tr>
		<input  type="text" name="del_prodId" placeholder="Product ID" size="20" id="textbox">
        <button type="submit" class="btn btn-primary">Delete</button>
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
		<input  type="text" name="customerId" placeholder="Customer ID" size="10" id="textbox">
		<input  type="text" name="firstName" placeholder="First Name" size="10" id="textbox">
		<input  type="text" name="lastName" placeholder="Last Name" size="10" id="textbox">
		<input  type="text" name="email" placeholder="Email" size="10" id="textbox">
		<input  type="text" name="phonenum" placeholder="Phone Number" size="10" id="textbox">
		<input  type="text" name="userid" placeholder="User ID" size="10" id="textbox">
		<input  type="text" name="password" placeholder="Password" size="10" id="textbox">
        <button type="submit" class="btn btn-primary">Add/Update</button>
    </div>
</form>
<form align="left" method="get" action="loaddata.jsp?caller=admin">
    <div class="formdiv">
        <button type="submit" class="btn btn-primary">Reset Database</button>
    </div>
</form>
</body>
</html>


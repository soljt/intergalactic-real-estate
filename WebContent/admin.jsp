<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<link rel="stylesheet" href="bg-styles.css">
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

<div class="table-section p-3">
    <h1>Administrator Sales Report by Day:</h1>


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
        out.println("<table class=\"table table-bordered table-secondary table-striped\"><tbody><tr><th>Order Date</th><th>Total Order Amount</th></tr>");
        while(rst.next())
        {   out.println("<tr><td text-align=\"center\">"+rst.getInt(2)+"-"+rst.getInt(3)+"-"+rst.getInt(4)+"</td>"+"<td text-align=\"center\">"+currFormat.format(rst.getDouble(1))+"</td></tr>");}
        out.println("</tbody></table>");

        out.println("<h1>All customers:</h1>");
        sql = "SELECT firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid from customer";
        rst = stmt.executeQuery(sql);
        out.println("<table class=\"table table-bordered table-secondary table-striped\"><tbody><tr><th>First Name</th><th>Last Name</th><th>Email</th><th>Phone</th><th>Address</th><th>City</th><th>State</th><th>Postal Code</th><th>Country</th><th>User ID</th></tr>");
        while(rst.next())
        {   
          out.println("<tr>");
          for(int i = 1; i < 11; i ++)
            out.println("<td text-align=\"center\">"+rst.getString(i)+"</td>");
          out.println("<tr>");
        }
        out.println("</tbody></table>");

    }   catch(SQLException ex){
        out.println(ex.toString());
    }finally{
        closeConnection();
    }
    %>
</div>
<form class="p-3" method="get" action="adminFunctionality.jsp">

  <!-- Add/Update Product -->
  <div class="mb-4">
    <h5>Add/Update Product</h5>
    <div class="row g-2 align-items-center">
      <div class="col-auto">
        <input type="text" class="form-control" name="productId" placeholder="Product ID" style="width:150px;">
      </div>
      <div class="col-auto">
        <input type="text" class="form-control" name="productName" placeholder="Product Name" style="width:150px;">
      </div>
      <div class="col-auto">
        <input type="text" class="form-control" name="productDesc" placeholder="Product Description" style="width:200px;">
      </div>
      <div class="col-auto">
        <input type="text" class="form-control" name="productPrice" placeholder="Product Price" style="width:200px;">
      </div>
      <div class="col-auto">
        <button type="submit" class="btn btn-primary">Add/Update</button>
      </div>
    </div>
  </div>

  <!-- Delete Product -->
  <div class="mb-4">
    <h5>Delete Product</h5>
    <div class="row g-2 align-items-center">
      <div class="col-auto">
        <input type="text" class="form-control" name="del_prodId" placeholder="Product ID" style="width:150px;">
      </div>
      <div class="col-auto">
        <button type="submit" class="btn btn-danger">Delete</button>
      </div>
    </div>
  </div>

  <!-- Add/Update Warehouse -->
  <div class="mb-4">
    <h5>Add/Update Warehouse</h5>
    <div class="row g-2 align-items-center">
      <div class="col-auto">
        <input type="text" class="form-control" name="warehouseId" placeholder="Warehouse ID" style="width:150px;">
      </div>
      <div class="col-auto">
        <input type="text" class="form-control" name="warehouseName" placeholder="Warehouse Name" style="width:200px;">
      </div>
      <div class="col-auto">
        <button type="submit" class="btn btn-primary">Add/Update</button>
      </div>
    </div>
  </div>

  <!-- Add/Update Customer -->
  <div class="mb-4">
    <h5>Update Customer</h5>
    <div class="row g-2 align-items-center flex-wrap">
      <div class="col-auto">
        <input type="text" class="form-control" name="customerId" placeholder="Customer ID" style="width:120px;">
      </div>
      <div class="col-auto">
        <input type="text" class="form-control" name="firstName" placeholder="First Name" style="width:120px;">
      </div>
      <div class="col-auto">
        <input type="text" class="form-control" name="lastName" placeholder="Last Name" style="width:120px;">
      </div>
      <div class="col-auto">
        <input type="email" class="form-control" name="email" placeholder="Email" style="width:180px;">
      </div>
      <div class="col-auto">
        <input type="text" class="form-control" name="phonenum" placeholder="Phone Number" style="width:140px;">
      </div>
      <div class="col-auto">
        <input type="text" class="form-control" name="userid" placeholder="User ID" style="width:120px;">
      </div>
      <div class="col-auto">
        <input type="password" class="form-control" name="password" placeholder="Password" style="width:120px;">
      </div>
      <div class="col-auto">
        <button type="submit" class="btn btn-primary">Update</button>
      </div>
    </div>
  </div>
    <!-- Delete Customer -->
  <div class="mb-4">
    <h5>Delete Customer</h5>
    <div class="row g-2 align-items-center">
      <div class="col-auto">
        <input type="text" class="form-control" name="del_custId" placeholder="Customer ID" style="width:120px;">
      </div>
      <div class="col-auto">
        <button type="submit" class="btn btn-danger">Delete</button>
      </div>
    </div>
  </div>
</form>



<!-- Ship Order Form -->
<form class="p-3" method="get" action="ship.jsp">
  <div class="mb-4">
    <h5>Ship Order</h5>
    <div class="row g-2 align-items-center">
      <div class="col-auto">
        <input type="text" class="form-control" name="orderId" placeholder="Enter Order ID to ship" style="width:200px;">
      </div>
      <div class="col-auto">
        <button type="submit" class="btn btn-primary">Ship</button>
      </div>
    </div>
  </div>
</form>

<h3 class="p-3">
  <a class="btn btn-info" href="loaddata.jsp?caller=admin" role="button">Reload Database</a>
</h3>

</body>
</html>

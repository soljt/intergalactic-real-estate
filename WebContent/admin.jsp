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
    //Creates new product
    String new_prod = "INSERT INTO product(productId, productName, productPrice, productDesc, categoryId) VALUES (?, ?, ?, ?, ?)";  
    PreparedStatement pstmt_new = con.prepareStatement(new_prod);

    //Sets parameters input by the admin
    pstmt_new.setString(1, pid);
    pstmt_new.setString(2, pname);
    pstmt_new.setString(3, price);
    pstmt_new.setString(4, desc);
    pstmt_new.setString(5, cid);

    //Updates product given inputs from admin
    String productId = request.getParameter("productId");
    String productName = request.getParameter("productName");
    String productPrice = request.getParameter("productPrice");
    String productDesc = request.getParameter("productDesc");
    String categoryId = request.getParameter("categoryId");

    String update_prod = "UPDATE product SET productName="+productName+", productPrice="+productPrice+", productDesc="+productDesc+"categoryId="+categoryId+" WHERE productId="+productId;
    prepareStatement pstmt_up = con.prepareStatement(update_prod);

    //Deletes product from on product id entered by admin
    String productId = request.getParameter("productId");
    String delete_prod = "DELETE FROM product WHERE productId = ?";

    
    //Update customer from inputs
    String customerId = request.getParameter("customerId);
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    String phonenum = request.getParameter("phonenum");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String postalCode = request.getParameter("postalCode");
    String country = request.getParameter("country");
    String userid = request.getParameter("userid");
    String password = request.getParameter("password");

    String update_customer = "UPDATE customer SET firstName="+firstName+", lastName="+lastName+", email="+email+", phonenum="+phonenum+", address="+address+", city="+city+"state="+state+"postalCode="+postalCode+"country="+country+"userid="+userid+"password="+password+"WHERE customerId="+customerId;
    
    //Update warehouse from inputs
    String warehouseId = request.getParameter("warehouseId");
    String warehouseName = request.getParameter("warehouseName");
    String update_warehouse = "UPDATE warehouse SET warehouseName="+warehouseName+" WHERE warehouseId="+warehouseId;

    //Update shipment 
    String ship_order = "UPDATE shipment SET shipmentDate="+shipmentDate+", shipmentDesc="+shipmentDesc+", warehouseId="+warehouseId" WHERE shipmentId="+shipmentId;
    
    String list_customer = "SELECT customerId, firstName, lastName, email, phonenum, address, userid FROM customer"
    ResultSet rst = stmt.executeQuery(list_customer);
    while(rst.next()) {
        out.println(String.format("<h3>Customer Id: %d First Name: %d Last Name: %d email: %d Phone Number: %d Address: %d User Id: %d</h3>", customerId, firstName, lastName, email, phonenum, address, userid));
    }
    %>
</div>


</body>
</html>


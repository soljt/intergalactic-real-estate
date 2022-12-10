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

        //Get parameters for new/update product from form
        String productId = request.getParameter("productId");
        String productName = request.getParameter("productName");
        String productPrice = request.getParameter("productPrice");
        String productDesc = request.getParameter("productDesc");
        String categoryId = request.getParameter("categoryId");
    
        if (productId.length() != 0) {
            //Checks if product already exists
            rst = stmt.executeQuery("SELECT productId FROM product");
            boolean check = false;
            while(rst.next()){
                String prod = rst.getString(1);
                if(prod == productId) {
                    check = true;
                }
            }

            //Creates new product
            if (check == false) {
            String new_prod = "INSERT INTO product(productName, productPrice, productDesc) VALUES (?, 5, ?)";  
            PreparedStatement pstmt_new = con.prepareStatement(new_prod);
            pstmt_new.setString(1, productName);
            pstmt_new.setString(2, productDesc);
            pstmt_new.executeQuery();
            }
            
            //Updates a product
            if (check == true) {
            String update_prod = "UPDATE product SET productName="+productName+" productPrice="+productPrice+" productDesc="+productDesc+"categoryId="+categoryId+" WHERE productId="+productId;
            PreparedStatement pstmt_up = con.prepareStatement(update_prod);
            pstmt_up.executeUpdate();
            }
        }   
    
        //Deletes product from product id entered by admin
        String del_prodId = request.getParameter("del_prodId");
        if(del_prodId.length() != 0) {
        String delete_prod = "DELETE FROM product WHERE productId = ?";
        PreparedStatement pstmt_del = con.prepareStatement(delete_prod);
        pstmt_del.setString(1, del_prodId);
        }
        
        //Get parameters for customer add/update from form
        String custId = request.getParameter("customerId");
        String first = request.getParameter("firstName");
        String last = request.getParameter("lastName");
        String mail = request.getParameter("email");
        String phone = request.getParameter("phonenum");
        String uid = request.getParameter("userid");
        String pass = request.getParameter("password");

        //Query to update customer
        if (custId.length() != 0){
            String update_customer = "UPDATE customer SET firstName=?, lastName=?, email=?, phonenum=?, userid=?, password=? WHERE customerId=?";
            PreparedStatement pstmt_upcus = con.prepareStatement(update_customer);
            pstmt_upcus.setString(1, first);
            pstmt_upcus.setString(2, last);
            pstmt_upcus.setString(3, mail);
            pstmt_upcus.setString(4, phone);
            pstmt_upcus.setString(5, uid);
            pstmt_upcus.setString(6, pass);
            pstmt_upcus.setString(7, custId);
            pstmt_upcus.executeUpdate();
        }

        //Query to add customer
        if (custId.length() == 0 && first.length() != 0) {
            String add_customer = "INSERT INTO customer(firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?, ?, ?, ?, '', '', '', '', '', ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(add_customer);
            pstmt.setString(1, first);
            pstmt.setString(2, last);
            pstmt.setString(3, mail);
            pstmt.setString(4, phone);
            pstmt.setString(5, uid);
            pstmt.setString(6, pass);
            pstmt.executeQuery();
        }
        
        //Get parameters for warehouse add/update from form
        String warehouseId = request.getParameter("warehouseId");
        String warehouseName = request.getParameter("warehouseName");
    
        //Update warehouse
        if(warehouseId.length() != 0){
            String update_warehouse = "UPDATE warehouse SET warehouseName=? WHERE warehouseId=?";
            PreparedStatement pstmt_upware = con.prepareStatement(update_warehouse);
            pstmt_upware.setString(1, warehouseName);
            pstmt_upware.setString(2, warehouseId);
            pstmt_upware.executeUpdate();
        } 

        //Add warehouse
        if(warehouseName.length() != 0 && warehouseId.length() == 0) {
            String add_warehouse = "INSERT INTO warehouse(warehouseName) VALUES (?)";
            PreparedStatement pstmt_addware = con.prepareStatement(add_warehouse);
            pstmt_addware.setString(1, warehouseName);
            pstmt_addware.executeQuery();
        }
        
        //Get parameters for shipment update from form
        String shipmentDate = request.getParameter("shipmentDate");
        String shipmentDesc = request.getParameter("shipmentDesc");
        String shipmentId = request.getParameter("shipmentId");
    
        //Update shipment (ship order)
        if(shipmentId.length() != 0) {
        String ship_order = "UPDATE shipment SET shipmentDate=?, shipmentDesc=?, warehouseId=? WHERE shipmentId=?";
        PreparedStatement pstmt_ship = con.prepareStatement(ship_order);
        pstmt_ship.setString(1, shipmentDate);
        pstmt_ship.setString(2, shipmentDesc);
        pstmt_ship.setString(3, warehouseId);
        pstmt_ship.setString(4, shipmentId);
        pstmt_ship.executeUpdate();
        }
       
    
        //Restores Database
        String reset_btn = request.getParameter("reset_btn");
        if (reset_btn == "Y") {
            // Create statement
            stmt = con.createStatement();

            Scanner scanner = new Scanner(new File("/usr/local/tomcat/webapps/shop/ddl/orderdb_sql.ddl"));
            // Read commands separated by ;
            scanner.useDelimiter(";");
            while (scanner.hasNext())
            {
                String command = scanner.next();
                if (command.trim().equals("") || command.trim().equals("go"))
                    continue;
                // out.print(command+"<br>");        // Uncomment if want to see commands executed
                try
                {
                    stmt.execute(command);
                }
                catch (Exception e)
                {	// Keep running on exception.  This is mostly for DROP TABLE if table does not exist.
                    out.println(e+"<br>");
                }
            }	 
            scanner.close();
        }        
    }   catch(SQLException ex){
        out.println(ex.toString());
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
    <div class="formdiv">
        <input  type="text" name="reset_btn" placeholder="Y/N" size="20" id="textbox">
        <button type="submit" class="btn btn-primary">Reset Database</button>
    </div>
</form>

</body>
</html>


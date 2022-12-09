<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Real Space Hub Shipment Processing</title>
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
//Connection info
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
String uid = "sa";
String pw = "304#sa#pw";

try (Connection con = DriverManager.getConnection(url, uid, pw);) 
{
	boolean success = true;
	//Turn off Autocommit
	con.setAutoCommit(false);

	// TODO: Get order id
	Statement stmt = con.createStatement();
	String id = request.getParameter("orderId");

	// TODO: Check if valid order id
	String sql = "SELECT COUNT(1) FROM ordersummary WHERE orderId = " + id;
	ResultSet rst = stmt.executeQuery(sql);
	rst.next();
	if (rst.getInt(1) != 1) {
		out.println("<h3>That order number does not match any current orders.</h3>");
		return;
	}
	// TODO: Start a transaction (turn-off auto-commit)
	con.setAutoCommit(false);

	// TODO: Retrieve all items in order with given id
	sql = "SELECT productId, quantity FROM orderproduct WHERE orderId = " + id + " ORDER BY productId";
	rst = stmt.executeQuery(sql);

	// TODO: Create a new shipment record.
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
	Date date = new Date();  
	String shipmentDesc = "Test description of order.";
	int warehouseId = 1;
	sql = "INSERT INTO shipment(shipmentDate, shipmentDesc, warehouseId) VALUES (?, ?, ?)";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, formatter.format(date));
	pstmt.setString(2, shipmentDesc);
	pstmt.setInt(3, warehouseId);
	int rowcount = pstmt.executeUpdate();

	// TODO: For each item verify sufficient quantity available in warehouse 1.
	pstmt = con.prepareStatement("SELECT quantity FROM productinventory WHERE productId = ? AND warehouseId = 1");

	while(rst.next())
	{
		int orderedQuantity = rst.getInt(2);
		int orderedProductId = rst.getInt(1);
		pstmt.setInt(1,orderedProductId);
		ResultSet rst2 = pstmt.executeQuery();
		rst2.next();
	
		int warehouseQuantity = rst2.getInt(1);
		if(orderedQuantity <= warehouseQuantity) {
			int newQuantity = warehouseQuantity - orderedQuantity;
			Statement stmt2 = con.createStatement();
			stmt2.executeUpdate("UPDATE productInventory SET quantity = " + newQuantity + " WHERE productId = " + orderedProductId + " AND warehouseId = 1");
			out.println(String.format("<h3>Ordered product: %d Qty: %d Previous inventory: %d New inventory: %d</h3>", orderedProductId, orderedQuantity, warehouseQuantity, newQuantity));
		} 
		else{
			out.println(String.format("<h1>Insufficient inventory for product ID: %d. NOT shipping you this</h1>", orderedProductId));
			success = false;
			break;
		}
		
	}

	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
	if(success) {
		con.commit();
		out.println("<h1>Order shipment success! will be shipped soon</h1>");
	}
	else
		con.rollback();
	
	// TODO: Auto-commit should be turned back on
	con.setAutoCommit(true);
	
}
catch(SQLException ex) 
{
	out.println("SQLException: " + ex);
}
%>                       				


<h3><a class="btn btn-info" href="index.jsp" role="button">Back to Main Page</a></h3>

</body>
</html>

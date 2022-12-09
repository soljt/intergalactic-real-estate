<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order Processing</title>
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">

</head>
<body>
	<div class="container-lg">


	<div class="row justify-content-center">
		<div class="col-md-4">
			<div>
				<% 
				@SuppressWarnings({"unchecked"})
				HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
				session = request.getSession(true);
				// Determine if there are products in the shopping cart
				// If either are not true, display an error message
				if (productList == null || productList.isEmpty()) {
					out.println("<div class=\"alert alert-danger\" role=\"alert\">There is nothing in your cart. Please go back and add something</div>");
					return;
				}
				
				NumberFormat currFormat = NumberFormat.getCurrencyInstance();
				// Determine if valid customer id was entered
				String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
				String uid = "sa";
				String pw = "304#sa#pw";
				
				try ( Connection con = DriverManager.getConnection(url, uid, pw);
				Statement stmt = con.createStatement();) 
				{	
				
					// Write query to see if customer is in DB

					String username = request.getParameter("username");
					String password = request.getParameter("password");
					String retStr = null;
			
					if(username == null || password == null){
						out.println("<h1>Your username or password are empty. Please go back and try again.</h1>");
						return;
					}
					if(username.isEmpty() || password.isEmpty()){
						out.println("<h1>Your username or password are empty. Please go back and try again.</h1>");
						return;
					}

					String sql = "SELECT customerId FROM Customer WHERE userId = ? and password = ?";
					PreparedStatement pstmt = con.prepareStatement(sql);			
					pstmt.setString(1, username);
					pstmt.setString(2, password);
					
					ResultSet rst = pstmt.executeQuery();
							
					if (!rst.next()){
						out.println("<h1>That username/password combination is invalid. Please go back and try again.</h1>");
						return;
					}
					
					int custId = rst.getInt(1);	

					//legacy code from when we only asked for customer id
					/*String sql = "SELECT COUNT(1) FROM customer WHERE customerId = ?";
					PreparedStatement pstmt = con.prepareStatement(sql);
					ResultSet rst;
					if(custId != null && !custId.isEmpty()) {
						pstmt.setInt(1, custId);
						rst = pstmt.executeQuery();
						rst.next();
						if(rst.getInt(1)!=1) {
							out.println("<h1>The ID you have entered is not registered with a customer. Please go back and try again</h1>"); 
							return;
						}
					}
					else {
						out.println("<h1>You did not enter an ID. Please go back and try again</h1>"); 
						return;
					}*/
				
					// Save order information to database
					sql = "INSERT INTO ordersummary(customerId, orderDate) VALUES (?,?)";
					
					pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);	
					
					pstmt.setInt(1, custId);
					
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
					Date date = new Date();  
					
					pstmt.setString(2, formatter.format(date));
				
					int rowcount = pstmt.executeUpdate();
				
					ResultSet keys = pstmt.getGeneratedKeys();
					keys.next();
					int orderId = keys.getInt(1);
				
					// Insert each item into OrderProduct table using OrderId from previous INSERT
					double total = 0;
					sql = "INSERT INTO orderproduct(orderId,productId,quantity,price) VALUES (?,?,?,?)";
					Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
					while (iterator.hasNext()) 
					{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
						ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
						if (product.size() < 4)
						{
							out.println("Expected product with four entries. Got: "+product);
							continue;
						}
						
						Object price = product.get(2);
						Object itemqty = product.get(3);
						double pr = 0;
						int qty = 0;
						
						try
						{
							pr = Double.parseDouble(price.toString());
						}
						catch (Exception e)
						{
							out.println("Invalid price for product: "+product.get(0)+" price: "+price);
						}
						try
						{
							qty = Integer.parseInt(itemqty.toString());
						}
						catch (Exception e)
						{
							out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
						}		
				
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1,orderId);
						pstmt.setInt(2,Integer.parseInt(product.get(0).toString()));
						pstmt.setInt(3,qty);
						pstmt.setDouble(4,pr);
						rowcount = pstmt.executeUpdate();
						total = total +pr*qty;
					}
				
					// Update total amount for order record
					sql = "UPDATE ordersummary SET totalAmount = ? WHERE orderId = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setDouble(1,total);
					pstmt.setInt(2,orderId);
					rowcount = pstmt.executeUpdate();
				
				
					// Print out order summary
					out.println("<h1 class=\"text-center\">Your Order Summary</h1>");
					out.print("<table class=\"table table-secondary table-hover table-striped table-bordered\"><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
					out.println("<th>Price</th><th>Subtotal</th></tr>");
					iterator = productList.entrySet().iterator();
					while (iterator.hasNext())
					{ 
						Map.Entry<String, ArrayList<Object>> entry = iterator.next();
						ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
						String productId = (String) product.get(0);
						String price = (String) product.get(2);
						double pr = Double.parseDouble(price);
						int qty = ( (Integer)product.get(3)).intValue();
				
						out.print("<tr><td>"+productId+"</td>");
						out.print("<td>"+product.get(1)+"</td>");
						out.print("<td align=\"center\">"+product.get(3)+"</td>");
						
						out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
						out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td></tr>");
						out.println("</tr>");
				
						
					}
					out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
					out.println("</table>");
				
					out.println("<p>Order Complete! Totally gonna ship you this order</p>");
					out.println(String.format("<p>Reference Number: %d</p>",orderId));
					out.println(String.format("<p>Shipping to customer number: %s</p>", custId));
					out.println("<a class=\"btn btn-info\" href=\"index.jsp\" role=\"button\">Back to Homepage</a>");
				
					// Clear cart if order placed successfully
					session.removeAttribute("productList");
					session.setAttribute("authenticatedUser",username);
				}
				catch (SQLException ex)
				{
					out.println("SQLException: " + ex);
				}
				catch (NumberFormatException e)
				{
					out.println("<div class=\"alert alert-danger\" role=\"alert\">The ID you entered is not an integer. Please go back and try again</div>");
				}
				
				
				
				
				%>

				
			</div>
		</div>
	</div>
</div>



</BODY>
</HTML>


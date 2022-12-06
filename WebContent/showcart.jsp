<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Your Shopping Cart</title>
<!--link rel="stylesheet" href="css/styles2.css"-->
</head>
<body>
<div class="table-section">
	<%
	// Get the current list of products
	@SuppressWarnings({"unchecked"})
	HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
	
	if (productList == null)
	{	out.println("<H1 align=\"center\">Your shopping cart is empty!</H1>");
		productList = new HashMap<String, ArrayList<Object>>();
	}
	else
	{
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	
		out.println("<h1 align=\"center\">Your Shopping Cart</h1>");
		out.print("<table class=\"doc-table\"><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
		out.println("<th>Price</th><th>Subtotal</th></tr>");
	
		double total =0;
		Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
		while (iterator.hasNext()) 
		{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
			ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
			if (product.size() < 4)
			{
				out.println("Expected product with four entries. Got: "+product);
				continue;
			}
			
			out.print("<tr><td>"+product.get(0)+"</td>");
			out.print("<td>"+product.get(1)+"</td>");
	
			out.print("<td align=\"center\">"+product.get(3)+"</td>");
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
	
			out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
			out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td></tr>");
			out.println("</tr>");
			total = total +pr*qty;
		}
		out.println("<tr><td colspan=\"4\" align=\"right\" id=\"order_total\"><b id=\"order_total\">Order Total</b></td>"
				+"<td align=\"right\" id=\"order_total\">"+currFormat.format(total)+"</td></tr>");
		out.println("</table>");
		out.println("<ul class=\"nav_links\" align=\"center\">");
		out.println("<li><a href=\"checkout.jsp\">Check Out</a></li>");
	}
	%>
	<li><a href="listprod.jsp">Continue Shopping</a></li>
<li><a href="index.jsp">Home</a></li>
</div>


</ul>
</body>
</html> 


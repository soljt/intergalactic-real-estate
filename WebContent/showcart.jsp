<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Your Shopping Cart</title>
<link rel="stylesheet" href="bg-styles.css">
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
</head>
<body>
	<%@ include file="header.jsp" %>
<div class="container-sm mt-3 mb-3">
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
		out.println("<div class=\"table-responsive my-4 rounded shadow-sm\">");
		out.print("<table class=\"table table-secondary table-hover align-middle table-sm mb-0\">");
		out.println("<thead class=\"table-light\">");
		out.println("<tr>");
		out.println("<th class=\"text-start\">Product ID</th>");
		out.println("<th class=\"text-start\">Product Name</th>");
		out.println("<th class=\"text-center\">Quantity</th>");
		out.println("<th class=\"text-end\">Price</th>");
		out.println("<th class=\"text-end\">Subtotal</th>");
		out.println("</tr>");
		out.println("</thead>");

		out.println("<tbody>");
		double total =0;
		Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
		while (iterator.hasNext()) 
		{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
			ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
			if (product.size() < 4)
			{
				out.println("<tr><td colspan=\"5\" class=\"text-danger\">Expected product with four entries. Got: " + product + "</td></tr>");
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
	
			out.println("<tr>");
			out.println("<td class=\"text-start\">" + product.get(0) + "</td>");
			out.println("<td class=\"text-start\">" + product.get(1) + "</td>");
			out.println("<td class=\"text-center\">" + qty + "</td>");
			out.println("<td class=\"text-end\">" + currFormat.format(pr) + "</td>");
			out.println("<td class=\"text-end\">" + currFormat.format(pr * qty) + "</td>");
			out.println("</tr>");
			total = total +pr*qty;
		}
		out.println("</tbody>");

		// Footer / total row
		out.println("<tfoot>");
		out.println("<tr class=\"fw-semibold\">");
		out.println("<td colspan=\"4\" class=\"text-end\">Order Total</td>");
		out.println("<td class=\"text-end\">" + currFormat.format(total) + "</td>");
		out.println("</tr>");
		out.println("</tfoot>");

		out.println("</table>");
		out.println("</div>");
		out.println("<a class=\"btn btn-primary\" href=\"checkout.jsp\" role=\"button\">Check Out</a>");
	
	}
	%>
	<div class="text-center">
	<a class="btn btn-secondary" href="index.jsp" role="button">Home</a>
	<a class="btn btn-dark" href="listprod.jsp" role="button">Continue Shopping</a>
	</div>
</div>


</ul>
</body>
</html> 


<!DOCTYPE html>
<html>
<head>
<title>Warehouse Page</title>
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
</head>
<body>
<%@ include file="header.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@include file="jdbc.jsp" %>  
<%@include file="auth.jsp" %>
<div class="table-section">
    <h1>Inventory by Warehouse</h1>


    <%
    // TODO: Write SQL query that prints out total order amount by day
    
    NumberFormat currFormat = NumberFormat.getCurrencyInstance();
        
    try
    {
        getConnection();
        Statement stmt = con.createStatement();
        /*String sql = "SELECT warehouseName, productName, quantity FROM productinventory pi JOIN warehouse w ON pi.warehouseId=w.warehouseId JOIN product p ON pi.productId=p.productId";
        ResultSet rst = stmt.executeQuery(sql);
        out.println("<table class=\"doc-table\"><tbody><tr><th>Warehouse</th><th>Product</th><th>Inventory</th></tr>");
        while(rst.next())
        {   out.println("<tr><td text-align=\"center\">"+rst.getString(1)+"</td>"+"<td text-align=\"center\">"+rst.getString(2)+"</td>"+"<td text-align=\"center\">"+rst.getString(3)+"</td></tr>");}
        out.println("</tbody></table>");*/

        // Write query to retrieve all order summary records
        String outerQuery = "SELECT * FROM warehouse";
        String innerQuery = "SELECT productName, quantity FROM productinventory pi JOIN product p ON pi.productId=p.productId WHERE warehouseId = ?";
        PreparedStatement pstmt = con.prepareStatement(innerQuery);
        ResultSet rst = stmt.executeQuery(outerQuery);
        
        out.println("<table class=\"table table-bordered table-secondary table-hover table-striped\">");
        out.println("<tbody>");		
        out.println("<tr>");	
        out.println("<th>Warehouse ID</th><th>Warehouse Name</th>");
        out.println("</tr>");
        // For each order in the ResultSet
        while (rst.next())
        {	
            // Print out the order summary information
            out.println("<tr class=\"custinfo\">");
            int warehouseId = rst.getInt(1);
            out.println("<td>" + warehouseId + "</td>");
            out.println("<td>" + rst.getString(2) + "</td>");
            out.println("</tr>");
            
            // Write a query to retrieve the products in the order
            //   - Use a PreparedStatement as will repeat this query many times
            pstmt.setInt(1, warehouseId);
            ResultSet rst2 = pstmt.executeQuery();
    
            // For each product in the order
            // Write out product information 
            out.println("<tr align = \"right\"><td colspan = 4><table class=\"table table-dark table-hover table-striped\"><tbody><tr><th>Product Name</th><th>Quantity</th></tr>");
            while (rst2.next()){
                out.println("<tr>");
                out.println("<td>" + rst2.getString(1) + "</td>");
                out.println("<td>" + rst2.getInt(2) + "</td>");
                out.println("</tr>");
            }
            out.println("</tbody></table></tr>");
        }
        out.println("</tbody>");	
        out.println("</table>");

    }   catch(SQLException ex){
        out.println(ex);
    }finally{
        closeConnection();
    }
    %>
</div>


</body>
</html>
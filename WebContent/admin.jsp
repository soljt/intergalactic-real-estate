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
<div class="table-section">
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
        out.println(ex);
    }finally{
        closeConnection();
    }
    %>
</div>


</body>
</html>

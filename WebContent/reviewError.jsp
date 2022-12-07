<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.io.*,java.sql.*,java.time.LocalDateTime,java.time.format.DateTimeFormatter"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Real Space Hub Main Page</title>
<link rel="stylesheet" href="css/bootstrap.min.css"/>
</head>
<body>

<div class="text-center mt-3">
<%
String error = request.getParameter("id");

if(error.equals("prod")){
    out.println("<h1>" + "You already reviewed that product" +"</h1>");
    out.println("<p class=\"lead\">" + "I'm sorry... rules are rules" + "</p>");
    out.println("<a class=\"btn btn-info\" href=\"reviewPage.jsp\" role=\"button\">Review Another Product</a>");
}

else if(error.equals("nouser")){
    out.println("<h1>" + "You must login to place a review!" +"</h1>");
    out.println("<p class=\"lead\">" + "I'm sorry... rules are rules" + "</p>");
    out.println("<a class=\"btn btn-info\" href=\"login.jsp\" role=\"button\">Login</a>");
}
   

out.println("<a class=\"btn btn-info\" href=\"index.jsp\" role=\"button\">Home</a>");


%>



</div>






</body>
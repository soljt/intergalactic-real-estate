<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Real Space</title>
<link rel="stylesheet" href="css/styles2.css"/>
<script src="https://kit.fontawesome.com/b0f917e6c7.js" crossorigin="anonymous"></script>
</head>
<body>

<h1>Enter user account information:</h1>

<form align="center" method="get" action="userAccount.jsp">
	<div class="formdiv">
		<input  type="text" name="productName" size="50" id="textbox">
	</div>
	<div class="formdiv">
		<input class="product_btn" type="submit" value="Search"><input class="product_btn" type="reset" value="Reset">
	</div>
	<div class="formdiv">
		<p style="background-color:inherit; font-size:11pt;">Leave blank to search all products</p>

	</div>
</form>
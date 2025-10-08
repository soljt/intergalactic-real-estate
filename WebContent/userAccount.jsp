<!DOCTYPE html>
<%@ include file="jdbc.jsp" %>
<html>
<head>
<title>Create Account</title>
<link rel="stylesheet" href="bg-styles.css">
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container-lg">
	<div class="text-center mt3">
		<h1>Create Account</h1>
	</div>
	<div class="row align-content-center justify-content-center">
		<div class="col-md-4">
			<form name="MyForm" method=post action="validateUser.jsp">
				<table>
				<tr>
					<td><div><p>First Name:</p></div></td>
					<td><input type="text" name="firstName" size=30 maxlength=20></td>
				</tr>
				<tr>
					<td><div><p>Last Name:</p></div></td>
					<td><input type="text" name="lastName" size=30 maxlength="20"></td>
				</tr>
				<tr>
					<td><div ><p>Email:</p></div></td>
					<td><input type="text" name="email" size=30 maxlength=50></td>
				</tr>
				<tr>
					<td><div ><p>Phone:</p></div></td>
					<td><input type="text" name="phone" size=30 maxlength=10></td>
				</tr>
				<tr>
					<td><div ><p>Address:</p></div></td>
					<td><input type="text" name="address" size=30 maxlength=30></td>
				</tr>
				<tr>
					<td><div ><p>City:</p></div></td>
					<td><input type="text" name="city" size=30 maxlength=20></td>
				</tr>
				<tr>
					<td><div ><p>State:</p></div></td>
					<td><input type="text" name="state" size=30 maxlength=2></td>
				</tr>
				<tr>
					<td><div ><p>Postal Code:</p></div></td>
					<td><input type="text" name="postalCode" size=30 maxlength=6></td>
				</tr>
				<tr>
					<td><div ><p>Country:</p></div></td>
					<td><input type="text" name="country" size=30 maxlength=20></td>
				</tr>
				<tr>
					<td><div ><p>Username:</p></div></td>
					<td><input type="text" name="userID" size=30 maxlength=30></td>
				</tr>
				<tr>
					<td><div ><p>Password:</p></div></td>
					<td><input type="password" name="password" size=30 maxlength=30></td>
				</tr>
				</table>
				<br/>
				<div class="container text-center">
				<button type="submit" class="btn btn-primary">Create Account</button>
				<a class="btn btn-info" href="index.jsp" role="button">Home</a>
				</div>
				</form>
				
		</div>

	</div>
</div>


<div class="container p-3">
	

<%
// Print prior error login message if present

if (session.getAttribute("errorMessage") != null)
	out.println("<div class=\"alert alert-danger\" role=\"alert\">"+session.getAttribute("errorMessage").toString()+"</div>");
%>
</div>


</body>
</html>


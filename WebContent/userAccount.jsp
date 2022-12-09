<!DOCTYPE html>
<html>
<head>
<title>Create Account</title>
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
</head>
<body>
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
					<td><input type="text" name="firstName" size=10 maxlength=20></td>
				</tr>
				<tr>
					<td><div><p>Last Name:</p></div></td>
					<td><input type="text" name="lastName" size=10 maxlength="20"></td>
				</tr>
				<tr>
					<td><div ><p>Email:</p></div></td>
					<td><input type="text" name="email" size=10 maxlength=50></td>
				</tr>
				<tr>
					<td><div ><p>Phone:</p></div></td>
					<td><input type="text" name="phone" size=10 maxlength=10></td>
				</tr>
				<tr>
					<td><div ><p>Address:</p></div></td>
					<td><input type="text" name="address" size=10 maxlength=30></td>
				</tr>
				<tr>
					<td><div ><p>City:</p></div></td>
					<td><input type="text" name="city" size=10 maxlength=20></td>
				</tr>
				<tr>
					<td><div ><p>State:</p></div></td>
					<td><input type="text" name="state" size=10 maxlength=2></td>
				</tr>
				<tr>
					<td><div ><p>Postal Code:</p></div></td>
					<td><input type="text" name="postalCode" size=10 maxlength=6></td>
				</tr>
				<tr>
					<td><div ><p>Country:</p></div></td>
					<td><input type="text" name="country" size=10 maxlength=20></td>
				</tr>
				<tr>
					<td><div ><p>User ID:</p></div></td>
					<td><input type="text" name="userID" size=10 maxlength=30></td>
				</tr>
				<tr>
					<td><div ><p>Password:</p></div></td>
					<td><input type="password" name="password" size=10 maxlength=30></td>
				</tr>
				</table>
				<br/>
				<button type="submit" class="btn btn-primary">Create Account</button>
				<a class="btn btn-info" href="index.jsp" role="button">Home</a>
				</form>
				
		</div>

	</div>
</div>


<div class="title-container">
	

<%
// Print prior error login message if present

if (session.getAttribute("errorMessage") != null)
	out.println("<p>"+session.getAttribute("errorMessage").toString()+"</p>");
%>
</div>

<div class="form-container">

</div>


</body>
</html>


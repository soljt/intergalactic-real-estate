<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
<link rel="stylesheet" href="css/styles2.css">
</head>
<body>

<div class="title-container">
	<h1 id="title" >Please Login to System</h1>
<%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null)
	out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
%>

</div>

<div class="form-container">
	<form name="MyForm" method=post action="validateLogin.jsp">
		<table>
		<tr>
			<td><div ><p>Username:</p></div></td>
			<td><input type="text" name="username"  size=10 maxlength=10></td>
		</tr>
		<tr>
			<td><div><p>Password:</p></div></td>
			<td><input type="password" name="password" size=10 maxlength="10"></td>
		</tr>
		</table>
		<br/>
		<input class="submit" type="submit" name="Submit2" value="Log In" id="login">
		<a href="createAccount.jsp">Create Account</a>
		</form>
</div>


</body>
</html>


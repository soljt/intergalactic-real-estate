<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>

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
        
        <tr>
			<td><div ><p>First Name:</p></div></td>
			<td><input type="text" name="firstname"  size=10 maxlength=10></td>
		</tr>
        <tr>
			<td><div ><p>Last Name:</p></div></td>
			<td><input type="text" name="lastname"  size=10 maxlength=10></td>
		</tr>
                <tr>
			<td><div ><p>E-mail:</p></div></td>
			<td><input type="text" name="email"  size=10 maxlength=10></td>
		</tr>
                <tr>
			<td><div ><p>Phone Number:</p></div></td>
			<td><input type="text" name="phonenum"  size=10 maxlength=10></td>
		</tr>
                <tr>
			<td><div ><p>Address:</p></div></td>
			<td><input type="text" name="address"  size=10 maxlength=10></td>
		</tr>
                       <tr>
			<td><div ><p>City:</p></div></td>
			<td><input type="text" name="city"  size=10 maxlength=10></td>
		</tr>
		
                       <tr>
			<td><div ><p>State:</p></div></td>
			<td><input type="text" name="state"  size=10 maxlength=10></td>
		</tr>
                       <tr>
			<td><div ><p>Postal Code:</p></div></td>
			<td><input type="text" name="postalcode"  size=10 maxlength=10></td>
		</tr>
                       <tr>
			<td><div ><p>Country:</p></div></td>
			<td><input type="text" name="country"  size=10 maxlength=10></td>
		</tr>
        </table>
		<br/>
		<input class="submit" type="submit" name="Submit2" value="Create Account" id="login">
		</form>
</div>
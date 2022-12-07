<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
</head>
<body>

<div class="container-lg">
	<div class="text-center mt-3">
		<h1>Please Login to System</h1>
<%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null)
	out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
%>

		<div class="row justify-content-center my-4">
			
			<div class="col-md-4">
				<form method=post action="validateLogin.jsp">
					<div class="text-start">
						<label class="form-label" for="username">Username</label>
						<div class="input-group mb-3">
							<span class="input-group-text">
								<i class="bi bi-person-fill"></i>
							</span>
							<input type="text" name="username" class="form-control" placeholder="Username">
						</div>

						<label class="form-label" for="username">Password</label>
						<div class="input-group mb-3">
							<span class="input-group-text">
								<i class="bi bi-lock-fill"></i>
							</span>
							<input type="password" name="password" class="form-control" placeholder="Password">
						</div>
						<button type="submit" class="btn btn-primary">Log In</button>
					</div>
					
				</form>
			</div>
			
		</div>
	</div>
</div>




</body>
</html>


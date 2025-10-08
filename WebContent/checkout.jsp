<!DOCTYPE html>
<html>
<head>
<title>Check Out</title>
<link rel="stylesheet" href="bg-styles.css">
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
</head>
<body>
<div class="container-sm mt-3 mb-3">
    <h1 align="center">Please enter your username and password to complete the transaction</h1>
    <div class="row justify-content-center">
        <div class="col-md-4">
            
            <form method="get" action="order.jsp">
                
                    <label for="customerId" class="input-label">Username</label>
                    <input type="text" class="form-control mb-3" name="username" placeholder="Enter your username here">
                    <label for="customerId" class="input-label">Password</label>
                    <input type="password" class="form-control mb-3" name="password" placeholder="Enter your password here">
                    <button type="submit" class="btn btn-primary">Submit Order</button>
                    <a class="btn btn-primary" href="userAccount.jsp" role="button">Create Account</a>
                
            </form>
        </div>

    </div>
    
</div>




</body>
</html>


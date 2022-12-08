<!DOCTYPE html>
<html>
<head>
<title>Check Out</title>
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
</head>
<body>
<div class="container-sm mt-3 mb-3">
    <h1 align="center">Enter your customer id to complete the transaction:</h1>
    <div class="row justify-content-center">
        <div class="col-md-4">
            
            <form method="get" action="order.jsp">
                
                    <label for="customerId" class="input-label">Please enter your Customer Id</label>
                    <input type="text" class="form-control mb-3" name="customerId" placeholder="Enter your customer ID here">
                    <button type="submit" class="btn btn-primary">Submit Order</button>
                
            </form>
        </div>

    </div>
    
</div>




</body>
</html>


<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Real Space Hub Main Page</title>
<!--link rel="stylesheet" href="css/styles2.css"/-->
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
</head>
<body class="bg-dark text-white">
<%@ include file="header.jsp" %>



<!-- Jumbotron -->
<div
  class="bg-image p-lg-5 text-center shadow-1-strong rounded mb-5 text-white align-content-center"
  style="background-image: url('https://images.unsplash.com/photo-1528722828814-77b9b83aafb2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80'); height: 50vh;"
>
  <h1 class="mb-3 h2">Welcome</h1>

  <p>
   To your best choice of intergalactic real state!
 
  </p>
  <a class="btn btn-primary" href="listprod.jsp" role="button">Shop Now!</a>
  <a class="btn btn-primary" href="userAccount.jsp" role="button">Create an Account!</a>
</div>
<div class="container text-center">
        <div class="row align-content-center justify-content-center">
                <div class="col-md-4">
                        <h1>Our Team</h1>
                        <p>Leo</p>
                        <p>Viv</p>
                        <p>Tyler</p>
                        <p>Wilfred</p>
                        <p>Sol</p>
                </div>
        </div>


</div>
<!-- Jumbotron -->


</body>
</head>
</html>


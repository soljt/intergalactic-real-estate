<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Real Space Hub Main Page</title>
<link rel="stylesheet" href="css/bootstrap.min.css"/>
</head>
<body>
    <div class="container-sm mt-3">
        <form name="MyForm" method=post action="createReview.jsp">
            <div class="mb-3">
                <select class="form-select" name="rating">
                    <option selected>Rate the Product</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                  </select>
            </div>
            <div class="mb-3">
                <select class="form-select" name="productId">
                    <option selected>Select the Product Id</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                  </select>
            </div>
            <div class="mb-3">
                <label for="review" class="form-label">Review</label>
                <input type="text" class="form-control" name="review" value="Write your comments here">
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
            <a class="btn btn-info" href="index.jsp" role="button">Home</a>
        </form>
    </div>
        


</body>

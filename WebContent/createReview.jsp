<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.io.*,java.sql.*,java.time.LocalDateTime,java.time.format.DateTimeFormatter"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Leave a Review</title>
<!--link rel="stylesheet" href="css/styles2.css"/-->
</head>
<body>
<%
String username = (String) session.getAttribute("authenticatedUser"); //Gets the current user's name
String error = ""; //If there is an error while submitting a review, update this and it will change what is displayed in the ReviewError page
//nouser = user not logged in
//prod = user already reviewed that product


if(username == null){
    error="nouser";
    response.sendRedirect(String.format("reviewError.jsp?id=%s", error));
    return;
}

//Get the form parameters
String rating = request.getParameter("rating");
String review = request.getParameter("review");
String pid = request.getParameter("productId");

DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH: mm: ss");  
LocalDateTime now = LocalDateTime.now();  
String time = dtf.format(now);




try{
    getConnection();

    //Get the user's id
    String sql1 = "SELECT customerId FROM customer WHERE userid=?";
    PreparedStatement ps = con.prepareStatement(sql1);
    ps.setString(1, username);
    ResultSet r = ps.executeQuery();
    String userId = null;
    while(r.next()){
        userId = r.getString(1);
    }


    


    String sql = "INSERT INTO review(reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (?, ?, ?, ?, ?)";
    PreparedStatement pstmt = con.prepareStatement(sql);

    //Set parameters input by the user
    pstmt.setString(1, rating);
    pstmt.setString(2, time);
    pstmt.setString(3, userId);
    pstmt.setString(4, review);
    pstmt.setString(5, pid);


    //Check if the user has done any reviews of the product

    //Get all of the reviews from that user
    String verify = "SELECT reviewId FROM review WHERE customerId=? AND productId=?";
    PreparedStatement validate = con.prepareStatement(verify);
    validate.setString(1, userId);
    validate.setString(2, pid);
    ResultSet rs2 = validate.executeQuery();

    

    //If the user has already done a review on the current product, terminate
    if(rs2.next()){
        error = "prod";
        response.sendRedirect(String.format("reviewError.jsp?id=%s", error));
        return;
    }
    
    


    
            


    



    pstmt.executeUpdate();

    String sql2 = "SELECT * FROM review";
    Statement s = con.createStatement();
    ResultSet rs = s.executeQuery(sql2);

    //testing some things
    while(rs.next()){
        int reviewId = rs.getInt(1);
        int reviewRating = rs.getInt(2);
        String reviewDate = rs.getString(3);
        int cid = rs.getInt(4);
        int productId = rs.getInt(5);
        String reviewComment = rs.getString(6);
        



        out.println("<p>Review Id: </p>" + reviewId);
        out.println("<p>Review Rating: </p>" + reviewRating);
        out.println("<p>Review Date: </p>" + reviewDate);
        out.println("<p>Customer ID:  </p>" + cid);
        out.println("<p>Product ID: </p>" + productId);
        out.println("<p>Review: </p>" + reviewComment);
        out.println("<br>");

    }

}catch(SQLException e){
    out.println(e);
}
finally{
    //response.sendRedirect("index.jsp");
}
//Function that adds a review




    
%>
</body>
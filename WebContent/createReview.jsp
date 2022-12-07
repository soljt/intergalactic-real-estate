<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Leave a Review</title>
<!--link rel="stylesheet" href="css/styles2.css"/-->
</head>
<body>
<%

//Get the form parameters
String rating = request.getParameter("rating");
String review = request.getParameter("review");
String pid = request.getParameter("productId");

try{
    getConnection();
    String sql = "INSERT INTO review(reviewRating, reviewComment, productId) VALUES (?, ?, ?)";
    PreparedStatement pstmt = con.prepareStatement(sql);

    //Set parameters input by the user
    pstmt.setString(1, rating);
    pstmt.setString(2, review);
    pstmt.setString(3, pid);


    pstmt.executeUpdate();

    String sql2 = "SELECT reviewRating, reviewComment, productId FROM review";
    Statement s = con.createStatement();
    ResultSet rs = s.executeQuery(sql2);

    //testing some things
    while(rs.next()){
        int reviewRating = rs.getInt(1);
        String reviewComment = rs.getString(2);
        int productId = rs.getInt(3);



        out.println("<p>Rating: </p>" + reviewRating);
        out.println("<p>Comment: </p>" + reviewComment);
        out.println("<p>Product: </p>" + productId);

    }

}catch(SQLException e){
    out.println(e);
}
finally{
    response.sendRedirect("index.jsp");
}
//Function that adds a review




    
%>
</body>
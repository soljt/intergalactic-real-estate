<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Real Space Hub Main Page</title>
<link rel="stylesheet" href="bg-styles.css">
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
</head>
<body>
    <%@ include file="header.jsp" %>
    
    <section id="review-form">
        <div class="container-lg">
            <div class="text-center mt-3">
                <h2>Leave a Product Review!</h2>
                <p class="lead">We promise we take your reviews *VERY* seriously</p>
                <div class="row justify-content-center my-4">
                    
                    <div class="col-md-4">
                        
                        <form action="createReview.jsp">
                            <label class="form-label" for="rating">Select a rating from 1 to 5</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="bi bi-star-fill"></i>
                                </span>
                                <select class="form-select" name="rating" id="rating">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5" selected>5</option>
                                  </select>
                            </div>
                            
                              <label class="form-label" for="productId">Select product Id</label>
                              <div class="input-group">
                                <span class="input-group-text">
                                    <i class="bi bi-house-fill"></i>
                                </span>
                                <select class="form-select" name="productId" id="productId">
                                <%
                                    String sql = "SELECT productId, productName FROM product"; //in case the list would be too long
                                    PreparedStatement pstmt = con.prepareStatement(sql);
                                    ResultSet rs = pstmt.executeQuery();
                                    
                                    while(rs.next()){
                                        int pid = rs.getInt("productId");
                                        String pname = rs.getString("productName");

                                        out.println(String.format("<option value=\"%d\">%s</option>", pid, pname));
                                    }
                                %>
                                  </select>
                              </div>
                                
                              

                              <div class="form-floating mb-4 mt-4">
                                <textarea id="reviewComment" class="form-control" style="height: 20vh" name="review"></textarea>
                                <label for="reviewComment">Add a written review</label>
                              </div>
                            
                              
                              
                              <br>

                              <button type="submit" class="btn btn-primary">Submit</button>
                            <a class="btn btn-info" href="index.jsp" role="button">Home</a>
                              
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </section>


</body>

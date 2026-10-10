<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Real Space - Product Information</title>
<link rel="stylesheet" href="bg-styles.css">
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
</head>
<body>
    <%@ include file="header.jsp" %>
    <div class="container product-container my-5">
        
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="card bg-dark bg-opacity-75 text-white shadow-lg border-0 p-4">

                <%
                //Note: Forces loading of SQL Server driver
                try
                {	// Load driver class
                    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                }
                catch (java.lang.ClassNotFoundException e)
                {
                    out.println("ClassNotFoundException: " +e);
                }
                
                // Variable name now contains the search string the user entered
                // Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!
                
                // Make the connection
                String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";			
                String uid = "sa";
                String pw = System.getenv("DB_PASSWORD");
                    
                try ( Connection con = DriverManager.getConnection(url, uid, pw);
                Statement stmt = con.createStatement();) 
                {	
                    //Get the current list of products
                HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
                
                
                // Get product name to search for
                String productId = request.getParameter("id");
                // TODO: Retrieve and display info for the product
                
                if (productList == null)
                {	// No products currently in list.  Create a list.
                    productList = new HashMap<String, ArrayList<Object>>();
                }
                
                
                
                String sql = "SELECT productId, productName, productPrice, productDesc, productImageURL FROM product WHERE productId = ?";
                PreparedStatement pstmt = con.prepareStatement(sql);
                pstmt.setString(1, productId);
                ResultSet rs = pstmt.executeQuery();
                
                while(rs.next()){
                    int pid = rs.getInt("productId");
                    String pname = rs.getString("productName");
                    double price = rs.getDouble("productPrice");
                    String desc = rs.getString("productDesc");
                    String img_url = rs.getString("productImageURL");

                    out.println("<div class=\"container my-5\">");
                    out.println("<div class=\"row justify-content-center\">");
                    out.println("<div class=\"col-12 col-md-10\">");
                
                
                    //Product name
                    out.println(String.format("<h2 class=\"fw-bold mb-3\">%s</h2>", pname));
                    //Product ID
                    out.println(String.format("<h5 class=\"text-light mb-2\">Product ID: %d</h5>", pid));
                    //Price
                    out.println(String.format("<h5 class=\"text-success mb-4\">Price: $%.2f</h5>", price));

                    //Display the product image if there is one
                    if (img_url != null && !img_url.trim().isEmpty()) {
                        out.println(String.format("<div class=\"text-center mb-4\"><img src=\"%s\" class=\"img-fluid rounded shadow-sm\" style=\"max-width: 300px;\"></div>", img_url));
                    }

                    out.println(String.format("<div class=\"mb-4\"><p class=\"text-light\">%s</p></div>", desc));
                                        out.println("<div class=\"flex-fill\">");

                    out.println("<div class=\"mb-3\">");
                    //Add to cart link
                    out.println(String.format("<a class=\"btn btn-info\" href=\"addcart.jsp?id=%d&name=%s&price=%.2f\" role=\"button\">Add to cart</a>", pid, pname, price));
                    //Continue shopping link
                    out.println("<a class=\"btn btn-primary\" href=\"listprod.jsp\" role=\"button\">Continue Shopping</a>");
                    out.println("</div>");
                    out.println("</div>");
                    out.println("</div>"); // end col
                    out.println("</div>"); // end row
                    out.println("</div>"); // end container
                }
                
                String sql2 = "SELECT reviewRating, reviewComment FROM review WHERE productId=?";
                PreparedStatement ps2 = con.prepareStatement(sql2);
                ps2.setString(1, productId);
                
                ResultSet rs2 = ps2.executeQuery();

                out.println("<div class=\"container mb-5\">");
                out.println("<div class=\"row justify-content-center\">");
                out.println("<div class=\"col-12 col-md-10\">"); // same centered width as product block
                out.println("<h4 class=\"fw-semibold mb-3\">Customer Reviews</h4>");
                out.println("<div class=\"row g-3\">");

                boolean hasReviews = false;
                while(rs2.next()){
                    hasReviews = true;
                    int rating = Integer.parseInt(rs2.getString(1)); // numeric rating expected
                    String comment = rs2.getString(2);

                    // build simple star string (filled + empty up to 5)
                    StringBuilder stars = new StringBuilder();
                    for (int i = 0; i < rating && i < 5; i++) stars.append("&#9733;"); // filled
                    for (int i = rating; i < 5; i++) stars.append("&#9734;"); // empty

                    out.println("        <div class=\"col-12 col-md-6\">");
                    out.println("          <div class=\"card shadow-sm h-100\">");
                    out.println("            <div class=\"card-body\">");
                    out.println(String.format("              <div class=\"mb-2 small text-muted\">%s  <span class=\"ms-2\">%d/5</span></div>", stars.toString(), rating));
                    out.println(String.format("              <p class=\"mb-0 fst-italic text-secondary\">“%s”</p>", comment));
                    out.println("            </div>");
                    out.println("          </div>");
                    out.println("        </div>");
                }
                
                if (!hasReviews) {
                    out.println("<div class=\"col-12\">");
                    out.println("<p class=\"text-light fst-italic\">No reviews yet.</p>");
                    out.println("</div>");
                }

                out.println("</div>");
                out.println("</div>"); 
                out.println("</div>"); 
                out.println("</div>"); 
                
                
                
                        
                // TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
                        
                
                }
                
                %>
            </div>
        </div>
        </div>
    </div>





</body>
</html>
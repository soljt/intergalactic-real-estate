
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
    <head>
      <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon">
      <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon">
      
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <link 
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
        rel="stylesheet">
      <script 
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
      </script>
    </head>
    <nav class="px-3 navbar navbar-expand-lg sticky-top navbar-dark bg-dark">
        <a class="navbar-brand" href="index.jsp">Real Space</a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
              <li class="nav-item">
                <a class="nav-link" href="listprod.jsp">Begin Shopping</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="showcart.jsp">My Cart</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="listorder.jsp">List All Orders</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="customer.jsp">Customer Info</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="reviewPage.jsp">Review a Product</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="login.jsp">Login</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="admin.jsp">Administrator Portal</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="warehouse.jsp">Warehouse Inventory</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="logout.jsp">Logout</a>
              </li>

          
              

              <%
              String userquery = "SELECT firstName FROM customer WHERE userid = ?";
              String userid = (String)session.getAttribute("authenticatedUser");
              if(userid != null){
                getConnection();
                try {
                PreparedStatement puser = con.prepareStatement(userquery);
                puser.setString(1, userid);

                ResultSet resultset = puser.executeQuery();
                resultset.next();
                String fname = resultset.getString(1);
                out.println("<li class=\"nav-item\">");
                    out.println("<a class=\"nav-link \">"+ "Logged in as: " + fname + "</a>");
                out.println("</li>");
                } finally {
                  closeConnection();
                }
              }
              


              %>
              
          
              
              
            </ul>
            </div>
        <!--Our brand-->


        <!--Section for shopping related links-->
        


        <!--div id="link_section" class="nav_section">
                
                <a href="listprod.jsp">Begin Shopping</a>
                <a href="listorder.jsp">List All Orders</a>
                <a href="customer.jsp">Customer Info</a>
                <a href="reviewPage.jsp">Review a Product</a>
        </div>
        <div id="logo_section" class="nav_section">
            <h1>Real Space</h1>
        </div>
        <div id="login_section" class="nav_section">
            <a href="login.jsp">Login</a>
            <a href="admin.jsp">Administrators</a>
            <a href="logout.jsp">Log out</a>
        </div-->
    </nav> 


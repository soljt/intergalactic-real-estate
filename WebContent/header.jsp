
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
    
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="index.jsp">Real Space</a>
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
              getConnection();

              String userquery = "SELECT firstName FROM customer WHERE userid = ?";
              String userid = (String)session.getAttribute("authenticatedUser");
              if(userid != null){
                PreparedStatement puser = con.prepareStatement(userquery);
                puser.setString(1, userid);

                ResultSet resultset = puser.executeQuery();
                resultset.next();
                String fname = resultset.getString(1);
                out.println("<li class=\"nav-item\">");
                    out.println("<a class=\"nav-link \">"+ "Logged in as: " + fname + "</a>");
                out.println("</li>");
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


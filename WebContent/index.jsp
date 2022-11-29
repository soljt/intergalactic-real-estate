<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Real Space Hub Main Page</title>
<link rel="stylesheet" href="css/styles2.css"/>
</head>
<body>
<%@ include file="header.jsp" %>
<section class="main_section" id="homepage_section">



        <%
        // TODO: Display user name that is logged in (or nothing if not logged in)
        String username = (String)session.getAttribute("authenticatedUser");
        
        if (username != null){
                String name = username.substring(0, 1).toUpperCase() + username.substring(1);
                out.println(String.format("<h1>Welcome, %s</h1>",name));	
        }
        else{
                out.println("<h1>Welcome</h1>");
        }
                
        %>



<p>to your best choice of intergalactic real state</p>







        

</section>

<dev>
        <h1>Our Team</h1>
                <li>Leo</li>
                <li>Viv</li>
                <li>Sol</li>
                <li>Tyler</li>
                <li>Wilfred</li>
</dev>
</body>
</head>
</html>


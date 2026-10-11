<%@ page import="java.sql.*" %>
<%@ page import="java.util.Scanner" %>
<%@ page import="java.io.File" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Your Shopping Cart</title>
</head>
<body>

<%
out.print("<h1>Connecting to database.</h1><br><br>");

// User id, password, and server information
String url = "jdbc:postgresql://cosc304-postgres:5432/orders?stringtype=unspecified";
String uid = "shop";
String pw = System.getenv("DB_PASSWORD");

try
    {	// Load driver class
        Class.forName("org.postgresql.Driver");
    }
catch (java.lang.ClassNotFoundException e)
    {
        throw new SQLException("ClassNotFoundException: " +e);
    }

con = DriverManager.getConnection(url, uid, pw);
        
String fileName = "/usr/local/tomcat/webapps/shop/ddl/orderdb_sql.ddl";


try
{
    // Create statement
    Statement stmt = con.createStatement();
    
    Scanner scanner = new Scanner(new File(fileName));
    // Read commands separated by ;
    scanner.useDelimiter(";");
    while (scanner.hasNext())
    {
        String command = scanner.next();
        if (command.trim().equals("") || command.trim().equals("go"))
            continue;
        // out.print(command+"<br>");        // Uncomment if want to see commands executed
        try
        {
            stmt.execute(command);
        }
        catch (Exception e)
        {	// Keep running on exception.  This is mostly for DROP TABLE if table does not exist.
            out.println(e+"<br>");
        }
    }	 
    scanner.close();
    out.print("<br><br><h1>Database loaded.</h1>");
    String call = request.getParameter("caller");
    String userid = (String)session.getAttribute("authenticatedUser");
    if(call!=null && call.equals("admin")){
        if(!(userid.equals("bobby")||userid.equals("arnold")||userid.equals("candace")||userid.equals("darren")||userid.equals("beth")))
            session.setAttribute("authenticatedUser","arnold");
        response.sendRedirect("admin.jsp");
    } else {
        session.invalidate();
    }
}
catch (Exception e)
{
    out.print(e);
}
finally
{
    closeConnection();
}
%>
</body>
</html> 

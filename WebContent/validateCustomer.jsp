<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<% 
String[] custAttributes = new String[]{"customerId", "firstName", "lastName", "email","phonenum","address","city","state","postalCode","country","userid","password"};
String edit = null;
int i = -1;
while(edit==null && i < 12){
    edit = request.getParameter(custAttributes[++i]);
}
String confirm = request.getParameter("confirm"+custAttributes[i]);
if(!edit.equals(confirm)) {
    session.setAttribute("custErrorMessage", "Your entries were not the same");
    response.sendRedirect("changeCustomer.jsp?edit=" + custAttributes[i]);
}
else if (i==3 && (!edit.contains("@") && !edit.contains("."))){
    session.setAttribute("custErrorMessage", "An email must contain an '@' and a '.' to be valid");
    response.sendRedirect("changeCustomer.jsp?edit=" + custAttributes[i]);
}
else if (edit.isEmpty()){
    session.setAttribute("custErrorMessage", "You must enter a new value");
    response.sendRedirect("changeCustomer.jsp?edit=" + custAttributes[i]);
}
else{
    String userName = (String) session.getAttribute("authenticatedUser");
    int rowcount = 0;
    try{
        getConnection();
        String sql = "UPDATE customer SET " + custAttributes[i] + " = ? WHERE userid = ?";
        PreparedStatement pstmt = con.prepareStatement(sql);		

        pstmt.setString(1, edit);
        pstmt.setString(2, userName);
        
        rowcount = pstmt.executeUpdate();

    }

    catch (SQLException ex) {
        out.println(ex);
    }

    finally{
        closeConnection();
    }
    if(rowcount != 0) {
        session.removeAttribute("custErrorMessage");
        response.sendRedirect("customer.jsp");
    }
    else {
        session.setAttribute("custErrorMessage", "Database connection failed");
        response.sendRedirect("customer.jsp");
    }
    out.println(String.format("%s %s %s", custAttributes[i], edit, userName));
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Warehouse Update</title>
</head>
<body>
    <h1>bruh</h1>
    <%@ page language="java" import="java.io.*,java.sql.*"%>
    <%@ include file="jdbc.jsp" %>
    <%
        session = request.getSession(true);
        //get warehouse id
        int warehouseId = Integer.parseInt(request.getParameter("warehouseId"));
        //get product id
        int productId = Integer.parseInt(request.getParameter("productId"));
        //get quantity
        int quantity = 0;
        boolean flag = false;
        try {
            quantity = Integer.parseInt(request.getParameter("quantity"));
        } catch (NumberFormatException e){
            out.println("<h1>something went wrong</h1>");
            session.setAttribute("errorMessage", "The value you entered is not a number");
            flag = true;
        } catch (NullPointerException e){
            session.setAttribute("errorMessage", "You must enter something in the cell to update");
            flag = true;
        }
        int rowcount = 0;
        if(!flag) {
            
            //access DB
            try 
            {
                //updateQuantity
                getConnection();
                String sql = "UPDATE productinventory SET quantity = ? WHERE warehouseId = ? AND productId = ?";
                PreparedStatement pstmt = con.prepareStatement(sql);		

                pstmt.setInt(1, quantity);
                pstmt.setInt(2, warehouseId);
                pstmt.setInt(3, productId);
                
                rowcount = pstmt.executeUpdate();

            }

            catch (SQLException ex) {
                out.println(ex);
            }

            finally{
                closeConnection();
            }
        }
        if (rowcount != 0)
            session.removeAttribute("errorMessage");
        response.sendRedirect("warehouse.jsp");       
    %>
</body>
</html>
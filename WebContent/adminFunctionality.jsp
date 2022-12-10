<%@ include file="header.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@include file="jdbc.jsp" %>  
<%@include file="auth.jsp" %>
<%@ page import="java.util.Scanner" %>
<%@ page import="java.io.File" %>

<html>
<%
// TODO: Write SQL query that prints out total order amount by day

// Make the connection
/*String url = "jdbc:sqlserver://mssql-lab7:1433;DatabaseName=tempdb;TrustServerCertificate=True";		
String uid = "SA";
String pw = "YourStrong@Passw0rd";*/

NumberFormat currFormat = NumberFormat.getCurrencyInstance();
    
try //( Connection con = DriverManager.getConnection(url, uid, pw);)
{
    Statement stmt = con.createStatement();

    //Get parameters for new/update product from form
    String productId = request.getParameter("productId");
    String productName = request.getParameter("productName");
    String productPrice = request.getParameter("productPrice");
    String productDesc = request.getParameter("productDesc");
    String categoryId = request.getParameter("categoryId");

    if (productId.length() != 0) {
        //Checks if product already exists
        ResultSet rst = stmt.executeQuery("SELECT productId FROM product");
        boolean check = false;
        while(rst.next()){
            String prod = rst.getString(1);
            if(prod == productId) {
                check = true;
            }
        }

        //Creates new product
        if (check == false) {
        String new_prod = "INSERT INTO product(productName, productPrice, productDesc) VALUES (?, 5, ?)";  
        PreparedStatement pstmt_new = con.prepareStatement(new_prod);
        pstmt_new.setString(1, productName);
        pstmt_new.setString(2, productDesc);
        pstmt_new.executeQuery();
        }
        
        //Updates a product
        if (check == true) {
        String update_prod = "UPDATE product SET productName=?, productPrice=5, productDesc=? WHERE productId=?";
        PreparedStatement pstmt_up = con.prepareStatement(update_prod);
        pstmt_up.setString(1, productName);
        pstmt_up.setString(2, productDesc);
        pstmt_up.setString(3, productId);
        pstmt_up.executeUpdate();
        }
    }   

    //Deletes product from product id entered by admin
    String del_prodId = request.getParameter("del_prodId");
    if(del_prodId.length() != 0) {
        String delete_prod = "DELETE FROM product WHERE productId = ?";
        PreparedStatement pstmt_del = con.prepareStatement(delete_prod);
        pstmt_del.setString(1, del_prodId);
    }
    
    //Get parameters for customer add/update from form
    String custId = request.getParameter("customerId");
    String first = request.getParameter("firstName");
    String last = request.getParameter("lastName");
    String mail = request.getParameter("email");
    String phone = request.getParameter("phonenum");
    String uid = request.getParameter("userid");
    String pass = request.getParameter("password");

    //Query to update customer
    if (custId.length() != 0){
        String update_customer = "UPDATE customer SET firstName=?, lastName=?, email=?, phonenum=?, userid=?, password=? WHERE customerId=?";
        PreparedStatement pstmt_upcus = con.prepareStatement(update_customer);
        pstmt_upcus.setString(1, first);
        pstmt_upcus.setString(2, last);
        pstmt_upcus.setString(3, mail);
        pstmt_upcus.setString(4, phone);
        pstmt_upcus.setString(5, uid);
        pstmt_upcus.setString(6, pass);
        pstmt_upcus.setString(7, custId);
        pstmt_upcus.executeUpdate();
    }

    //Query to add customer
    if (custId.length() == 0 && first.length() != 0) {
        String add_customer = "INSERT INTO customer(firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?, ?, ?, ?, '', '', '', '', '', ?, ?)";
        PreparedStatement pstmt = con.prepareStatement(add_customer);
        pstmt.setString(1, first);
        pstmt.setString(2, last);
        pstmt.setString(3, mail);
        pstmt.setString(4, phone);
        pstmt.setString(5, uid);
        pstmt.setString(6, pass);
        pstmt.executeQuery();
    }
    
    //Get parameters for warehouse add/update from form
    String warehouseId = request.getParameter("warehouseId");
    String warehouseName = request.getParameter("warehouseName");

    //Update warehouse
    if(warehouseId.length() != 0){
        String update_warehouse = "UPDATE warehouse SET warehouseName=? WHERE warehouseId=?";
        PreparedStatement pstmt_upware = con.prepareStatement(update_warehouse);
        pstmt_upware.setString(1, warehouseName);
        pstmt_upware.setString(2, warehouseId);
        pstmt_upware.executeUpdate();
    } 

    //Add warehouse
    if(warehouseName.length() != 0 && warehouseId.length() == 0) {
        String add_warehouse = "INSERT INTO warehouse(warehouseName) VALUES (?)";
        PreparedStatement pstmt_addware = con.prepareStatement(add_warehouse);
        pstmt_addware.setString(1, warehouseName);
        pstmt_addware.executeQuery();
    }
    
    //Get parameters for shipment update from form
    String shipmentDate = request.getParameter("shipmentDate");
    String shipmentDesc = request.getParameter("shipmentDesc");
    String shipmentId = request.getParameter("shipmentId");

    //Update shipment (ship order)
    if(shipmentId.length() != 0) {
    String ship_order = "UPDATE shipment SET shipmentDate=?, shipmentDesc=?, warehouseId=? WHERE shipmentId=?";
    PreparedStatement pstmt_ship = con.prepareStatement(ship_order);
    pstmt_ship.setString(1, shipmentDate);
    pstmt_ship.setString(2, shipmentDesc);
    pstmt_ship.setString(3, warehouseId);
    pstmt_ship.setString(4, shipmentId);
    pstmt_ship.executeUpdate();
    }        
}   catch(SQLException ex){
    out.println(ex.toString());
}finally{
    response.sendRedirect("admin.jsp");
}
%>
</html>
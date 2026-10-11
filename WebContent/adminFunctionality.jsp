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

NumberFormat currFormat = NumberFormat.getCurrencyInstance();
    
try //( Connection con = DriverManager.getConnection(url, uid, pw);)
{
    getConnection();
    Statement stmt = con.createStatement();

    //Get parameters for new/update product from form
    String productId = request.getParameter("productId");
    String productName = request.getParameter("productName");
    String productPrice = request.getParameter("productPrice");
    String productDesc = request.getParameter("productDesc");
    String categoryId = request.getParameter("categoryId");

    if (productId.length() != 0) {
        //Checks if product already exists
        ResultSet rst = stmt.executeQuery("SELECT productId, productName, productDesc, productPrice FROM product");
        boolean check = false;
        while(rst.next()){
            String prod = rst.getString(1);
            if(prod.equals(productId)) {
                check = true;
                productName = productName == null || productName.isEmpty() ? rst.getString("productName") : productName;
                productDesc = productDesc == null || productDesc.isEmpty() ? rst.getString("productDesc") : productDesc;
                productPrice = productPrice == null || productPrice.isEmpty() ? rst.getString("productPrice") : productPrice;
            }
        }

        //Creates new product
        if (!check) {
        String new_prod = "INSERT INTO product(productName, productPrice, productDesc) VALUES (?, ?, ?)";  
        PreparedStatement pstmt_new = con.prepareStatement(new_prod);
        pstmt_new.setString(1, productName);
        pstmt_new.setString(2, productPrice);
        pstmt_new.setString(3, productDesc);
        pstmt_new.executeUpdate();
        }
        
        //Updates a product
        else {
        String update_prod = "UPDATE product SET productName=?, productPrice=?, productDesc=? WHERE productId=?";
        PreparedStatement pstmt_up = con.prepareStatement(update_prod);
        pstmt_up.setString(1, productName);
        pstmt_up.setString(2, productPrice);
        pstmt_up.setString(3, productDesc);
        pstmt_up.setString(4, productId);
        pstmt_up.executeUpdate();
        }
    }   

    //Deletes product from product id entered by admin
    String del_prodId = request.getParameter("del_prodId");
    if(del_prodId.length() != 0) {
        String delete_prod = "DELETE FROM product WHERE productId = ?";
        PreparedStatement pstmt_del = con.prepareStatement(delete_prod);
        pstmt_del.setString(1, del_prodId);
        pstmt_del.executeUpdate();
    }

    //Deletes customer from customer id entered by admin
    String del_custId = request.getParameter("del_custId");

    if (del_custId != null && !del_custId.isEmpty()) {
        String delete_cust = "DELETE FROM customer WHERE customerId = ?";
        PreparedStatement pstmt_del = con.prepareStatement(delete_cust);
        pstmt_del.setString(1, del_custId);
        pstmt_del.executeUpdate();
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
        //Query to get old cust
        String get_cust = "SELECT firstName, lastName, email, phonenum, userid, password FROM customer WHERE customerId=?";
        PreparedStatement pstmt_getcus = con.prepareStatement(get_cust);
        pstmt_getcus.setString(1, custId);
        ResultSet rs = pstmt_getcus.executeQuery();
        while (rs.next()) {
            if (first == null || first.isEmpty()) first = rs.getString("firstName");
            if (last == null || last.isEmpty()) last = rs.getString("lastName");
            if (mail == null || mail.isEmpty()) mail = rs.getString("email");
            if (phone == null || phone.isEmpty()) phone = rs.getString("phonenum");
            if (uid == null || uid.isEmpty()) uid = rs.getString("userid");
            if (pass == null || pass.isEmpty()) pass = rs.getString("password");
        }
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
        pstmt.executeUpdate();
    }
    
    //Get parameters for warehouse add/update from form
    String warehouseId = request.getParameter("warehouseId");
    String warehouseName = request.getParameter("warehouseName");

    //Update warehouse
    if(warehouseId.length() != 0){
        String get_warehouse = "";
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
        pstmt_addware.executeUpdate();
    }
          
}   catch(SQLException ex){
    out.println(ex.toString());
}finally{
    closeConnection();
    response.sendRedirect("admin.jsp");
}
%>
</html>
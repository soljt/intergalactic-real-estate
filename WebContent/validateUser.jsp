<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%

int success = 0;
session = request.getSession(true);

	try
	{
		success = validateUser(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e);
    }

	if(success != 0){
        response.sendRedirect("index.jsp");
    }else
		response.sendRedirect("userAccount.jsp");
%>

<%!
int validateUser(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException, SQLException
	{
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String postalCode= request.getParameter("postalCode");
        String country = request.getParameter("country");
        String userID = request.getParameter("userID");
        String password = request.getParameter("password");

		int rowCount = 0;

        try{
		if(firstName.isEmpty() || firstName.matches("[0-9]+")){
            session.setAttribute("errorMessage", "Your first name field is either empty or contains digits");
            return 0;
        }
        
        
        if(lastName.isEmpty() || lastName.matches("[0-9]+")){
            session.setAttribute("errorMessage", "Your last name field is either empty or contains digits");
        return 0;
        }


        if(email.isEmpty() || !(email.contains("@"))){
            session.setAttribute("errorMessage", "Your email field is either empty or needs an @ character in the email");
            return 0;
        }
	

        if(phone.isEmpty() || phone.matches("[a-z A-Z]+") || phone.length() != 10){
            session.setAttribute("errorMessage", "Your phone field is either empty, contains letters, or is not a length of 10 numbers");
			return 0;
        }


        if(address.isEmpty() || !(address.matches("[a-z A-Z 0-9]+"))){
            session.setAttribute("errorMessage", "Your address field is either empty or contains symbols");
            return 0;
        }


        if(city.isEmpty() || city.matches("[0-9]+")){
            session.setAttribute("errorMessage", "Your city field is either empty or contains digits");
            return 0;
        }
		

        if(state.isEmpty() || state.matches("[0-9]+") || state.length() != 2){
            session.setAttribute("errorMessage", "Your state field is either empty, contains digits, or is not a length of 2 letters");
            return 0;
        }


        if(postalCode.isEmpty() || !(postalCode.matches("[a-z A-Z 0-9]+")) || postalCode.length() != 6){
            session.setAttribute("errorMessage", "Your postal code field is either empty, contains symbols, or is not a length of 6 or 7");
            return 0;
        }
    

        if(country.isEmpty() || country.matches("[0-9]+")){
            session.setAttribute("errorMessage", "Your country field is either empty or contains digits");
            return 0;
        }
			

        if(userID.isEmpty()){
            session.setAttribute("errorMessage", "Your user ID is empty");
            return 0;
        }

        if(password.isEmpty()){
            session.setAttribute("errorMessage", "Your password is empty");
            return 0;
        }

        
        }catch(NullPointerException e){
            session.setAttribute("errorMessage","One or more of the fields are empty");
            return 0;
        }
		
        phone = phone.substring(0,3) + "-" + phone.substring(3,6) + "-" + phone.substring(6);
		try 
		{
			getConnection();
			Statement stmt = con.createStatement(); 
			stmt.execute("USE orders");

			String sql = "INSERT INTO customer(firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement pstmt = con.prepareStatement(sql);		

			pstmt.setString(1, titleCase(firstName));
			pstmt.setString(2, titleCase(lastName));
            pstmt.setString(3, email);
            pstmt.setString(4, phone);
            pstmt.setString(5, titleCase(address));
            pstmt.setString(6, titleCase(city));
            pstmt.setString(7, state.toUpperCase());
            pstmt.setString(8, postalCode.toUpperCase());
            pstmt.setString(9, titleCase(country));
            pstmt.setString(10, userID);
            pstmt.setString(11, password);
            rowCount = pstmt.executeUpdate();

        }

        catch (SQLException ex) {
            session.setAttribute("errorMessage",ex);
            return 0;
        }

        finally{
            closeConnection();
        }

		if(rowCount != 0){
			session.removeAttribute("errorMessage");
            session.setAttribute("authenticatedUser",userID);
        }
		else
            session.setAttribute("errorMessage","Failed to connect to the database.");
        
        return rowCount;
    }
%>

<%!
String titleCase (String text){
    if (text == null || text.isEmpty()) {
        return text;
    }

    StringBuilder converted = new StringBuilder();

    boolean convertNext = true;
    for (char ch : text.toCharArray()) {
        if (Character.isSpaceChar(ch)) {
            convertNext = true;
        } else if (convertNext) {
            ch = Character.toTitleCase(ch);
            convertNext = false;
        } else {
            ch = Character.toLowerCase(ch);
        }
        converted.append(ch);
    }

    return converted.toString();
}
%>

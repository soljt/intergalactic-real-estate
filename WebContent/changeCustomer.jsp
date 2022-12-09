<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Edit Customer Info</title>
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
</head>
<body>

<div class="container-lg">
	<div class="text-center mt-3">
		
<%
String edit = titleCase(request.getParameter("edit"));
String inputType;
if(edit.equals("Password"))
    inputType = "\"password\"";
else
    inputType = "\"text\"";
out.println("<h1>Please enter your new " + edit + "</h1>");
%>

		<div class="row justify-content-center my-4">
			
			<div class="col-md-4">
				<form method=post action="validateCustomer.jsp">
					<div class="text-start">
                        <%
						out.println("<label class=\"form-label\" for=" + "\"" + edit.toLowerCase() + "\"" + ">" + edit + "</label>");
                        %>
						<div class="input-group mb-3">
                            <%
							out.println("<input type="+ inputType + " name=" + "\"" + edit.toLowerCase() + "\" " + "class=\"form-control\" placeholder=" + "\"" + edit + "\"" + ">");
                            %>
						</div>

						<%
						out.println("<label class=\"form-label\" for=" + "\"" + "confirm" + edit.toLowerCase() + "\"" + ">" + "Confirm " + edit + "</label>");
                        %>
						<div class="input-group mb-3">
							<%
							out.println("<input type=" + inputType + " name=" + "\"" + "confirm" + edit.toLowerCase() + "\" " + "class=\"form-control\" placeholder=" + "\"" + edit + "\"" + ">");
                            %>
						</div>
						<button type="submit" class="btn btn-primary">Save</button><a class="btn btn-primary" href="customer.jsp" role="button">Cancel</a>
                        <%
                        // Print prior error login message if present
                        if (session.getAttribute("custErrorMessage") != null)
                            out.println("<p>"+session.getAttribute("custErrorMessage").toString()+"</p>");
                        %>
					</div>
					
				</form>
                
                
			</div>
			
		</div>

	</div>
</div>

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



</body>
</html>



























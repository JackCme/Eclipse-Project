<%@page contentType="text/html; charset=utf-8" errorPage="/error.jsp"%>
<%@page import="java.sql.*"%>

<%
  	response.setContentType("utf-8");
	request.setCharacterEncoding("utf-8");
	//int s_id = Integer.parseInt(request.getParameter("s_id"));

%>

<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Add new student</title>
  <link rel="stylesheet" href="css/style.css" title="style1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" title="style1">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</head>
<body>
  <div id="title">
    <!-- title ?? -->
  </div>
  		<%
			//Session Timeout
			String memberId = (String)session.getAttribute("id");
			
			boolean login = (memberId == null) ? false : true;
			if(!login) {
			  response.sendRedirect("login.jsp");
			}
			else {
		%>
	<!-- Navigation 시작 -->
		<jsp:include page="/view/nav.jsp" flush="false" />
    <!-- Navigation 끝 -->

  <div class="container">
    <div id="login">
        ID: ${id}<br>
        Name: ${name}<br>
        User level: ${level}<br>
    </div>

    <h2>Add Student Information</h2>
    <p>
    <form method="post" action="/Project/StudentDB">
		<input type="hidden" name="mode" value="add" />
      <table class="table table-bordered small">
        <tr>
	        <th class="success">Name</th>
	        <td>
	        	<input class="form-control" type="text" name="name" placeholder="Student full name" required> 
	        </td>
        </tr>
        <tr>
        	<th class="success">Gender</th>
	        <td>
				<label class="radio-inline"><input type="radio" name="gender" value="M" checked>M</label>
	            <label class="radio-inline"><input type="radio" name="gender" value="F">F</label>
	        </td>
        </tr>
        <tr>
          <th class="success">Address</th>
          <td>
            <input class="form-control" type="text" name="address" placeholder="Student full address" value="">
          </td>
        </tr>
        <tr>
          <th class="success">E-mail</th>
          <td>
            <input class="form-control" type="text" name="e_mail" value="">
          </td>
        </tr>
        <tr>
          <th class="success">Location</th>
          <td>
            <select class="form-control" name="location" required>
              <option>Location 1</option>
              <option>Location 2</option>
              <option>Location 3</option>
              <option>Location 4</option>
            </select>
          </td>
        </tr>
      </table>
    <p></p>
      <input type="submit" class="btn btn-default" value="Save">
      <input type="reset" class="btn btn-default" value="Reset">
      <button type="button" onclick="history.back();" class="btn btn-danger">Back</button>
    </form>
  </div>
  
<% } //if session == null else %>
</body>
</html>

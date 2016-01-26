<%@page contentType="text/html; charset=utf-8" errorPage="/error.jsp"%>
<%@page import="java.sql.*"%>

<%
  	response.setContentType("utf-8");
	request.setCharacterEncoding("utf-8");

%>

<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Add new asset</title>
  <link rel="stylesheet" href="css/style.css" title="style1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" title="style1">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</head>
<body>
  <div id="title">
    <!-- title ?? -->
  </div>
    <!-- Navigation 시작 -->
  		<%
			//Session Timeout
			String memberId = (String)session.getAttribute("id");
			
			boolean login = (memberId == null) ? false : true;
			if(!login) {
			  response.sendRedirect("/Project/login.jsp");
			}
			else {
		%>
	
		<jsp:include page="/view/nav.jsp" flush="false" />
    <!-- Navigation 끝 -->

  <div class="container">
    <div id="login">
        ID: ${id}<br>
        Name: ${name}<br>
        User level: ${level}<br>
    </div>

    <h2>Add Asset Information</h2>
    <p>
    <form method="post" action="/Project/asset">
		<input type="hidden" name="mode" value="add" />
      <table class="table table-bordered small">
        <tr>
	        <th class="success">Serial No.</th>
	        <td>
	        	<input class="form-control" type="text" name="sn" placeholder="Asset serial number" required> 
	        </td>
        </tr>
        <tr>
        	<th class="success">Name</th>
	        <td>
	        	<input class="form-control" type="text" name="name" placeholder="Asset name" required> 
				
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
        
<%
  	request.setCharacterEncoding("utf-8");
  	response.setContentType("utf-8");
  
	String db_url="jdbc:mysql://dbinstance.cmpfvsw5d4kz.ap-northeast-1.rds.amazonaws.com:3306/test";
	String db_user="admin";
	String db_pwd="dbadministrator";
	//int idx = Integer.parseInt(request.getParameter("idx"));

  	Connection conn = null;
  	PreparedStatement stat = null;

  	try{
  		Class.forName("com.mysql.jdbc.Driver");
  		conn = DriverManager.getConnection(db_url,db_user,db_pwd);
  		if(conn==null)  {  throw new Exception("DB 연결 Error"); }
		
  		String query = "select m_no,id,name from member where level=?";
		
  		stat = conn.prepareStatement(query);
  		stat.setString(1,"Local_Manager");
  		
		ResultSet rs = stat.executeQuery();

%>
        <tr>
        	<th class="success">Manager</th>
        	<td>
        		<select class="form-control" name="m_no" required>
        		<%
        			while(rs.next()) {
        			  int m_no = rs.getInt("m_no");
        			  String name = rs.getString("name");
        			  String id = rs.getString("id");
        		%>
        			<option value="<%=m_no%>"><%=name %> (<%=id %>)</option>
        		<% } %>
        		</select>
        	</td>
        </tr>
        
        
 <%
	 rs.close();
	 stat.close();
	 conn.close();
  	} catch (SQLException e) {
		e.printStackTrace(); 
 	}
	 %>
 
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

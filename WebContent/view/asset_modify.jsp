<%@page contentType="text/html; charset=utf-8" errorPage="/error.jsp"%>
<%@page import="java.sql.*"%>

<%
	request.setCharacterEncoding("utf-8");
	response.setContentType("utf-8");
	String db_url="jdbc:mysql://dbinstance.cmpfvsw5d4kz.ap-northeast-1.rds.amazonaws.com:3306/test";
	String db_user="admin";
	String db_pwd="dbadministrator";
	int idx = Integer.parseInt(request.getParameter("idx"));

	Connection conn = null;
	PreparedStatement stat = null;
	
	String sn = null;
	String name = null;
	String location = null;
	int m_no = 0;
	
  try{
	  Class.forName("com.mysql.jdbc.Driver");
	  conn=DriverManager.getConnection(db_url,db_user,db_pwd);
	  if(conn==null) {
	  	throw new Exception("DB 연결 Error");
	  }
	  	//stat = conn.createStatement();

		String query = "select * from asset where s_no=?";
		
		stat = conn.prepareStatement(query);
		stat.setInt(1, idx);
		
		ResultSet rs = stat.executeQuery();
	
		if(rs.next()) {
			sn = rs.getString("sn");
			name = rs.getString("name");
			location = rs.getString("location");
			m_no = rs.getInt("m_no");
		}
	
%>


<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Asset Information Modify Window</title>
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
//Session timeout
String memberId = (String)session.getAttribute("id");
boolean login = memberId == null ? false : true;
if(!login) {
  response.sendRedirect("/Project/login.jsp");
}
%>
  
		<jsp:include page="/view/nav.jsp" flush="false" />
    <!-- Navigation 끝 -->

  <div class="container">
    <div id="login">
        ID: ${id}<br>
        Name: ${name}<br>
        User level: ${level}<br>
    </div>

    <h2>Modify Asset Information</h2>
    <p>
    <form method="post" action="/Project/student?idx=<%=idx%>">
    	<input type="hidden" name="mode" value="modify" />
      <table class="table table-bordered small">
        <tr>
        	<th class="success">Serial No.</th>
	        <td>
	        	<input class="form-control" type="text" name="sn" value="<%=sn %>" required> 
	        </td>
        </tr>
        <tr>
          <th class="success">Name</th>
          <td>
            <input class="form-control" type="text" name="name" value="<%=name%>">
          </td>
        </tr>
        
        <tr>
          <th class="success">Location</th>
           <td>
            <select  name="location" class="form-control">
              <option <%if(location.equals("Location 1")){out.print("selected");}%>>Location 1</option>
              <option <%if(location.equals("Location 2")){out.print("selected");}%>>Location 2</option>
              <option <%if(location.equals("Location 3")){out.print("selected");}%>>Location 3</option>
              <option <%if(location.equals("Location 4")){out.print("selected");}%>>Location 4</option>
            </select>
          </td>
        </tr>
        
	<%
		query = "select m_no,id,name from member where level=?";
	
		stat = conn.prepareStatement(query);
		stat.setString(1,"Local_Manager");
		
		rs = stat.executeQuery();
	
	%>
        <tr>
        	<th class="success">Manager</th>
        	<td>
        		<select class="form-control" name="m_no" required>
        		<%
        			while(rs.next()) {
        			  int member_no = rs.getInt("m_no");
        			  String manager_name = rs.getString("name");
        			  String id = rs.getString("id");
        			
        		%>
        			<option value="<%=member_no%>"><%=manager_name %> (<%=id %>)</option>
        		<% } %>
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
</body>

<%
		rs.close();
		stat.close();
		conn.close();
	}catch(SQLException e)	{
	  e.printStackTrace();
	} 
%>


</html>

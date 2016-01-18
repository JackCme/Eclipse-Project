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
  Statement stat = null;

  try{
  Class.forName("com.mysql.jdbc.Driver");
  conn=DriverManager.getConnection(db_url,db_user,db_pwd);
  if(conn==null)
  {
  throw new Exception("DB 연결 Error");
}
stat = conn.createStatement();

String query = "select * from student where s_no="+idx;
ResultSet rs = stat.executeQuery(query);

if(rs.next())
{
  String name = rs.getString("name");
  String gender = rs.getString("gender");
  String address = rs.getString("address");
  String e_mail = rs.getString("e_mail");
  String location = rs.getString("location");

%>

<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Student deletion confirm</title>
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
  response.sendRedirect("login.jsp");
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

    <h2>Delete Student Information</h2>
    <p class="alert alert-danger">
    	<strong>Are you sure to delete?</strong> Deletion of data cannot be undone.
    </p>
    <form method="post" action="/Project/student?idx=<%=idx%>" >
	    <div class="form" >
	    	<input type="hidden" name="mode" value="delete" />
      <table class="table table-bordered small">
        <!-- <tr>
          <th class="success">No.</th>
          <td><%=idx%></td>
        </tr> -->
        <tr>
          <th class="success">Name</th>
          <td>
            <label ><%=name%></label>
          </td>
        </tr>
        <tr>
          <th class="success">Gender</th>
          <td>
            <label ><%=gender%></label>
          </td>
        </tr>
        <tr>
          <th class="success">Address</th>
          <td>
            <label ><%=address%></label>
          </td>
        </tr>
        <tr>
          <th class="success">E-mail</th>
          <td>
            <label  ><%=e_mail%></label>
          </td>
        </tr>
        <tr>
          <th class="success">Location</th>
           <td>
            <label  ><%=location%></label>
          </td>
        </tr>
      </table>
    
      <input type="submit" class="btn btn-success" value="Delete">
      <button type="button" onclick="history.back();" class="btn btn-danger">Back</button>
	    </div>
   		
    </form>
  
  </div>
</body>
<%
}
}catch(Exception e)
{
  throw new Exception(e);
}
%>



</html>

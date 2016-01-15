<%@page contentType="text/html; charset=utf-8" errorPage="/error.jsp"%>
<%@page import="java.sql.*"%>

<!--session timeout-->
<%
String memberId = (String)session.getAttribute("id");
boolean login = memberId == null ? false : true;
if(!login) {
  response.sendRedirect("login.jsp");
}
%>

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
  <title>Student Information Modify Window</title>
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

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#menu-navbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
        <a class="navbar-brand" href="#">Menu</a>
    </div>
      <div class="collapse navbar-collapse" id="menu-navbar">
        <ul class="nav navbar-nav">
          <li><a href="student_administration.jsp">Student Administration</a></li>
          <li><a href="asset_administration.jsp">Asset Administration</a></li>
          <li><a href="announcement.jsp">Announcement</a><li>
          <li><a href="references.jsp">References</a></li>
          <li><a href="schedules.jsp">Schedules</a></li>

                    <!-- 권한에 따른 메뉴 분리-->
          <%
            String levelCheck = (String)session.getAttribute("level");

          	if(levelCheck.equals("Administrator")){
          %>
                    <li><a href="local_manager.jsp">Local Managers</a></li>
                    <li><a href="menu_manage.jsp">Menu Management</a></li>
          <% } %>

        </ul>
        <ul class="nav navbar-nav navbar-right">
          <li><a href="nav.jsp"><span class="glyphicon glyphicon-home"></span>Home</a></li>
          <li><a href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span>Sign Out</a></li>
        </ul>
      </div>
  </div>
</nav>

    <!-- Navigation 끝 -->

  <div class="container">
    <div id="login">
        ID: ${id}<br>
        Name: ${name}<br>
        User level: ${level}<br>
    </div>

    <h2>Modify Student Information</h2>
    <p>
    <form method="post" action="stu_db_modify.jsp?idx=<%=idx%>">
      <table class="table table-bordered small">
        <tr>
          <th class="success">No.</th>
          <td><%=idx%></td>
        </tr>
        <tr>
          <th class="success">Name</th>
          <td>
            <input type="text" name="name" value="<%=name%>">
          </td>
        </tr>
        <tr>
          <th class="success">Gender</th>
          <td>
<%
  if(gender.equals("M"))
  {
%>
            <input type="radio" name="gender" value="M" checked>M
            <input type="radio" name="gender" value="F">F
<%
  }else{
%>
            <input type="radio" name="gender" value="M">M
            <input type="radio" name="gender" value="F" checked>F
<%
  }
%>
          </td>
        </tr>
        <tr>
          <th class="success">Address</th>
          <td>
            <input type="text" name="address" value="<%=address%>">
          </td>
        </tr>
        <tr>
          <th class="success">E-mail</th>
          <td>
            <input type="text" name="e_mail" value="<%=e_mail%>">
          </td>
        </tr>
        <tr>
          <th class="success">Location</th>
           <td>
            <select name="location" size = "5">
              <option <%if(location.equals("Location 1")){out.print("selected");}%>>Location 1</option>
              <option <%if(location.equals("Location 2")){out.print("selected");}%>="location 2">Location 2</option>
              <option <%if(location.equals("Location 3")){out.print("selected");}%>="location 3">Location 3</option>
              <option <%if(location.equals("Location 4")){out.print("selected");}%>="location 4">Location 4</option>
            </select>
          </td>
        </tr>
      </table>
    </p>
      <input type="submit" class="btn btn-default" value="Save">
      <input type="reset" class="btn btn-default" value="Reset">
      <a href="student_administration.jsp"><button type="button" class="btn btn-danger">Cancel</button></a>
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

<%@page contentType="text/html; charset=utf-8" errorPage="/error.jsp" %>
<%@page import="java.sql.*"%>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Student Administration</title>
    <link rel="stylesheet" href="css/style.css" title="style1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" title="style1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

  </head>
  <body>

<!-- Navigation 시작 -->
		
		<%
			//Session timeout
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

        
        <div id="print_table">
          <h2>Student Information</h2>
        <button type = "button" class = "btn btn-default" title = "Search" data-container = "body"
          data-toggle = "popover"  data-html="true" data-content = '<form><input type="text"/>
          <input type="button" value="search"/></form>'>
          <span class="glyphicon glyphicon-search"></span>Search
        </button>

        <button type="button" class="btn btn-default">
          <span class="glyphicon glyphicon-sort-by-attributes"></span> Sort Ascending
        </button>
        <button type="button" class="btn btn-default">
          <span class="glyphicon glyphicon-sort-by-attributes-alt"></span> Sort Descending
        </button>
        <button type="button" class="btn btn-default">
          <span class="glyphicon glyphicon-filter"></span> Filter
        </button>
        <button type="button" class="btn btn-default" onclick="window.open('print.html','print_win','width=800,height=400,left=200,status=no,toolbar=no,resizable=no,scrollbars=yes')">
          <span class="glyphicon glyphicon-print"></span> Print
        </button>
        <br>

		<p>총 학생 수: ${total_student }</p>
		<div class="table-responsive">
			<table class="table table-striped table-hover">
          <thead>
            <tr>
              <th>Student ID</th>
              <th>Name</th>
              <th>Gender</th>
              <th>Address</th>
              <th>E-Mail</th>
              <th>Location</th>
              <th>Modify</th>
            </tr>
          </thead>
          <tbody>
<%
	ResultSet rs = (ResultSet)request.getAttribute("rs");
  	if((int)request.getAttribute("total_student") == 0){
%>
            <tr>
              <td colspan="7">학생 정보가 존재하지 않습니다.</td>
            </tr>
<%
  	}else{
	  while(rs.next()){
	    int idx = rs.getInt("s_id");
	    String name = rs.getString("name");
	    String gender = rs.getString("gender");
	    String address = rs.getString("address");
	    String e_mail = rs.getString("e_mail");
	    String location = rs.getString("location");
%>

            <tr>
              <td><%=idx%></td>
              <td><%=name%></td>
              <td><%=gender%></td>
              <td><%=address%></td>
              <td><%=e_mail%></td>
              <td><%=location%></td>

              <td><button type="button" class="btn btn-primary btn-xs btn-lg" onclick="location.href='view/student_modify.jsp?idx=<%=idx%>'">Modify</button>&nbsp;&nbsp;&nbsp;
              <button type="button" class="btn btn-primary btn-xs btn-lg" onclick="location.href='view/student_delete.jsp?idx=<%=idx%>'">Delete</button></td>
            </tr>
<%
  		} //while
  	}//if total_student else
  		
  	int last_idx = (int)request.getAttribute("last_idx");
%>
          </tbody>
        </table>
		</div>
        
        </div>
        <a href="/Project/view/student_add.jsp"><button type="button" class="btn btn-default">Add</button></a>
      </div>


<%
	rs.close();
%>

<script>
 $(function (){
  $("[data-toggle = 'popover']").popover();
});
</script>
<% } %>
</body>

</html>

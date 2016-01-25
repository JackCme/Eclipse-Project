<%@ page contentType ="text/html; charset=utf-8" errorPage="/error.jsp"%>

		<nav class="navbar navbar-inverse">
		  <div class="container-fluid">
		    <div class="navbar-header">
		      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#menu-navbar">
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		      </button>
		        <a class="navbar-brand" href="/Project/">Menu</a>
		    </div>
		      <div class="collapse navbar-collapse" id="menu-navbar">
		        <ul class="nav navbar-nav">
		          <li><a href="/Project/student">Student Administration</a></li>
		          <li><a href="/Project/asset">Asset Administration</a></li>
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
		          <li><a href="/Project"><span class="glyphicon glyphicon-home"></span>Home</a></li>
		          <li><a href="/Project/logout.jsp"><span class="glyphicon glyphicon-log-out"></span>Sign Out</a></li>
		        </ul>
		      </div>
		  </div>
		</nav>

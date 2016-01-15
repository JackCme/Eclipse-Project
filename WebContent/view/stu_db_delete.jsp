<%@page contentType="text/html; charset=utf-8" errorPage="/error.jsp"%>
<%@page import="java.sql.*"%>

<%
	int idx = Integer.parseInt(request.getParameter("idx"));

	String db_url="jdbc:mysql://dbinstance.cmpfvsw5d4kz.ap-northeast-1.rds.amazonaws.com:3306/test";
	String db_user="admin";
	String db_pwd="dbadministrator";

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

	String query = String.format("DELETE from student where s_no=%s;",idx);
	int rowNum = stat.executeUpdate(query);

	if(rowNum <1)
	{
		throw new Exception("DB 데이터를 수정하는 데 실패하였습니다.");
	}
	else
	{
		response.sendRedirect("student_administration.jsp");
	}
	}catch(Exception e)
	{
		throw new Exception(e);
	}
%>
<!--
<script>
function next(){
              if(confirm("삭제 하시려면 예를 누르시고 이동을 하지 않으시려면 아니오를 눌러주세요"))
              {

			}
 else
              {
                alert('아니오를 누르셨습니다');
                location.href="student_administration_admin.jsp";
              }
            }
</script>
 -->

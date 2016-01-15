

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginCheck
 */
@WebServlet("/LoginCheck")
public class LoginCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginCheck() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		HttpSession session = request.getSession();
		
		Boolean check = false;
		
		Connection conn = null; // DB연결을 위한 변수
		Statement stat = null; // DB쿼리를 위한 변수
		String db_user = "admin";
		String db_pass = "dbadministrator";
		
		try{
			
			if(id==null || pwd==null)
			{
				throw new Exception("ID or Password 미입력");
			}

			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://dbinstance.cmpfvsw5d4kz.ap-northeast-1.rds.amazonaws.com:3306/test",db_user,db_pass);
			if(conn==null)
			{
				throw new Exception("DB 연결 에러");
			}
			stat = conn.createStatement();
			ResultSet rs = stat.executeQuery("select * from member");

			while(rs.next())
			{
				String db_id = rs.getString("id");
				String db_pwd = rs.getString("pwd");
				String db_name = rs.getString("name");
				String db_level = rs.getString("level");

				if(db_id.equals(id) && db_pwd.equals(pwd))
				{
					session.setAttribute("id",id);
					session.setAttribute("pwd",pwd);
					session.setAttribute("name",db_name);
					session.setAttribute("level",db_level);
					check = true;
				}
			}
		}
		catch(Exception e){
			//throw e;
		}
		finally{
			try{
				stat.close();
			}
			catch(Exception ignore){
				//throw new Exception("stat.close() Error");
			}
			try{
			conn.close();
			}
			catch(Exception ignore){
				//throw new Exception("conn.close() Error");
			}
		}

		if(check){
			response.sendRedirect("index.jsp");
		}
		else{
			PrintWriter out = response.getWriter();
			out.println("<script>" +
					"alert(\"login failed.\");" +
					"location.href = \"login.jsp\";" +
					"</script>");
		}
		
	}

}

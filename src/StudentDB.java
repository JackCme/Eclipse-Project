

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class StudentDBAdd
 */
@WebServlet("/StudentDB")
public class StudentDB extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudentDB() {
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
		request.setCharacterEncoding("utf-8");
	  	response.setContentType("utf-8");
	  	
	  	String idx = request.getParameter("idx");
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		String address = request.getParameter("address");
		String e_mail = request.getParameter("e_mail");
		String location = request.getParameter("location");
		String mode = request.getParameter("mode");
	
		String db_url="jdbc:mysql://dbinstance.cmpfvsw5d4kz.ap-northeast-1.rds.amazonaws.com:3306/test";
		String db_user="admin";
		String db_pwd="dbadministrator";
	
		Connection conn = null;
		Statement stat = null;
	
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(db_url,db_user,db_pwd);
			if(conn==null) 
				throw new Exception("DB 연결 Error");
				
			stat = conn.createStatement();
			
			if (mode.equals("add")) {
				String query = String.format("insert into student(name,gender,address,e_mail,location) values('%s', '%s', '%s', '%s', '%s');",name,gender,address,e_mail,location);
				try{
					int rowNum = stat.executeUpdate(query);
					if(rowNum <1)
						throw new Exception("DB 데이터를 수정하는데 실패하였습니다.");
					else
						response.sendRedirect("/Project/student");
				} catch(SQLException e) {
					e.printStackTrace();
				}
			} // if add
			
			if (mode.equals("modify")) {
				String query = String.format("UPDATE student set name := '%s', gender := '%s', address := '%s', e_mail := '%s', location := '%s' where s_no = %s;",name,gender,address,e_mail,location,idx);
				try{
					int rowNum = stat.executeUpdate(query);

					if(rowNum <1)
						throw new Exception("DB 데이터를 수정하는 데 실패하였습니다.");
					else
						response.sendRedirect("/Project/student");
				} catch(SQLException e) {
					e.printStackTrace();
				}
				
			} // if modify
			
		}catch(Exception e)	{ 
			e.printStackTrace();
		}
		
	}

}



import java.io.IOException;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class StudentDBRequest
 */
@WebServlet("/student")
public class StudentDBRequest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudentDBRequest() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setContentType("utf-8");
		
		String db_url="jdbc:mysql://dbinstance.cmpfvsw5d4kz.ap-northeast-1.rds.amazonaws.com:3306/test";
		String db_user="admin";
		String db_pwd="dbadministrator";
	
		int total_student=0;  // �� �л� �� ���� ��, ��� �� ����
		int last_idx=0; // ������ �й� ����
	
		Connection conn = null;
		Statement stat = null;
	
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(db_url,db_user,db_pwd);
			if(conn==null)
				throw new Exception("DB ���� Error");
			
			stat = conn.createStatement();
	
			String query = "select count(*) from student";
			ResultSet rs = stat.executeQuery(query);
			if(rs.next())
			    total_student = rs.getInt(1); // �л� ���� ����.
			request.setAttribute("total_student", total_student);
			//rs.close(); // �л� �� ���� ���� ������ ����.
		
			query = "select max(s_no) from student";
			rs = stat.executeQuery(query);
			if(rs.next())
			    last_idx = rs.getInt(1); // ������ �й��� ����.
			request.setAttribute("last_idx", last_idx);
			//rs.close();
		
			query = "select lpad(s_no,5,0) as s_id ,name,gender,address,birth,e_mail,location from student"; // �л� ���� ���������� ���� ����
			//query = "SELECT * FROM student";
			rs = stat.executeQuery(query);
			request.setAttribute("rs", rs);
			
			
			RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/student_administration.jsp");
			requestDispatcher.forward(request, response);
			
			stat.close();
			conn.close();
		} catch(Exception e) { 	}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
	}

}

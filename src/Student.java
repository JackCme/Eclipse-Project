
import java.sql.*;

public class Student {
	private int s_id;
	private String name;
	private char gender; 
	private String address;
	private Date birth;
	private String e_mail;
	private String location;
	private int total_student;
	private int last_idx;
	
	Connection conn = null;
	Statement stat = null;
	ResultSet rs = null;
	
	public ResultSet studentList() {
		
		String db_url="jdbc:mysql://dbinstance.cmpfvsw5d4kz.ap-northeast-1.rds.amazonaws.com:3306/test";
		String db_user="admin";
		String db_pwd="dbadministrator";
	
		int total_student=0;  // �� �л� �� ���� ��, ��� �� ����
		int last_idx=0; // ������ �й� ����
	/*
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		*/
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(db_url,db_user,db_pwd);
			if(conn==null)
				throw new Exception("DB ���� Error");
			
			stat = conn.createStatement();
	
			String query = "select count(*) from student";
			rs = stat.executeQuery(query);
			if(rs.next())
			    total_student = rs.getInt(1); // �л� ���� ����.
			this.total_student = total_student;
		
			query = "select max(s_no) from student";
			rs = stat.executeQuery(query);
			if(rs.next())
			    last_idx = rs.getInt(1); // ������ �й��� ����.
			this.last_idx = last_idx; 
		
			query = "select lpad(s_no,5,0) as s_id ,name,gender,address,birth,e_mail,location from student"; // �л� ���� ���������� ���� ����
			//query = "SELECT * FROM student";
			rs = stat.executeQuery(query);
			
			return rs;

		} catch(Exception e) { 
			e.printStackTrace();
		}
		
		return rs;
		
	}
	
	public int getTotalStudent() {
		return this.total_student;
	}
	
	public int getLastIdx() {
		return this.last_idx;
	}
}


import java.sql.*;


public class Member {
	
	private String id;
	private String pwd;
	private String name;
	private String level;
	
	public Member(String id, String pwd) {
		this.id = id;
		this.pwd = pwd;
	}
	
	public String getLevel() {
		return this.level;
	}
	
	public String getName() {
		return this.name;
	}
	
	public boolean isMember() {
		
		Connection conn = null; // DB연결을 위한 변수
		Statement stat = null; // DB쿼리를 위한 변수
		String db_user = "admin";
		String db_pass = "dbadministrator";
		String db_url = "jdbc:mysql://dbinstance.cmpfvsw5d4kz.ap-northeast-1.rds.amazonaws.com:3306/test";
		try{
			
			if(id==null || pwd==null)
			{
				throw new Exception("ID or Password 미입력");
			}

			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(db_url,db_user,db_pass);
			if(conn==null)
				throw new Exception("DB 연결 에러");

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
					this.name = db_name;
					this.level = db_level;
					
					return true;
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			if (stat != null) try{	stat.close(); }	catch(Exception e){	e.printStackTrace();}
			if (conn != null) try{ conn.close();} catch(Exception e){ e.printStackTrace(); }
		}
		
		return false;
	}

}

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class Asset {
	private int a_no;
	private String serial_no;
	private String asset_name;
	private String location;
	private int m_no;
	private int total_asset;
	private int last_idx;
	
	Connection conn = null;
	Statement stat = null;
	ResultSet rs = null;
	
	public ResultSet assetList() {
		
		String db_url="jdbc:mysql://dbinstance.cmpfvsw5d4kz.ap-northeast-1.rds.amazonaws.com:3306/test";
		String db_user="admin";
		String db_pwd="dbadministrator";
	
		int total_asset=0;  // �� �л� �� ���� ��, ��� �� ����
		int last_idx=0; // ������ �й� ����

		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(db_url,db_user,db_pwd);
			if(conn==null)
				throw new Exception("DB ���� Error");
			
			stat = conn.createStatement();
	
			String query = "select a_no, sn, asset.name as asset_name, location, member.name as manager_name "
					+ "from asset left join member "
					+ "on asset.m_no = member.m_no";
			
			rs = stat.executeQuery(query);
			/*
			if(rs.next())
			    total_asset = rs.getInt(1); // �л� ���� ����.
			this.total_asset = total_asset;
			*/
		/*
			query = "select max(s_no) from student";
			rs = stat.executeQuery(query);
			if(rs.next())
			    last_idx = rs.getInt(1); // ������ �й��� ����.
			this.last_idx = last_idx; 
		*/
			//query = "select lpad(s_no,5,0) as s_id ,name,gender,address,birth,e_mail,location from student"; // �л� ���� ���������� ���� ����
			//query = "SELECT * FROM student";
			//rs = stat.executeQuery(query);
			
			return rs;

		} catch(Exception e) { 
			e.printStackTrace();
		}
		
		return rs;
		
	}
	
	public int getTotalAsset() {
		return this.total_asset;
	}
	
	public int getLastIdx() {
		return this.last_idx;
	}
}

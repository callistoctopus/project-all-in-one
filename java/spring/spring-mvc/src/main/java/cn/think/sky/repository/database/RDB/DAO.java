package cn.think.sky.repository.database.RDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class DAO {
	
	@Autowired
	private DataSource dataSource;

	public Object executeSelect(String sql, List<Object> para) {
		Object ret = new Object();
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet retObject = null;
		
		try {
			conn = dataSource.getConnection();
			stmt = conn.prepareStatement(sql);
			
			for(int i = 0; i < para.size(); i++) {
				stmt.setObject(i, para.get(i));
			}
			
			retObject = stmt.executeQuery();
//			Boolean ret = stmt.execute();
			
			ret = translate(retObject);
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(stmt != null) {
					stmt.close();
				}
				
				if(conn != null) {
					conn.close();
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
		}
		
		return ret;
	}
	
	protected HashMap<String, Object> translate(ResultSet rset) {
		HashMap<String, Object> ret = new HashMap<String, Object>();
		ResultSetMetaData meta;
		
		try {
			if(rset.next()) {
				meta = rset.getMetaData();
				for (int i = 1; i <= meta.getColumnCount(); i++) {
					String name = meta.getColumnName(i);
					ret.put(name, rset.getObject(i));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return ret;
	}
}

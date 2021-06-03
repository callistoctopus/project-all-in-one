package cn.think.sky.repository.database.RDB.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import cn.think.sky.model.User;

@Repository
public class JdbcRepository {
	
	@Autowired
	private DataSource dataSource;
	
	private static final String SQL_INSERT_USER = 
			"insert into users (username, password, enabled, authority) values (?, ?, ?, ?)";
	
	private static final String SQL_UPDATE_USER = 
			"update users set password = ?, enabled = ?, authority = ? where username = ? ";
	
	private static final String SQL_FIND_USER = 
			"select password, enabled, authority from users where username = ? ";
	
	public void addUser(User user) {
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			conn = dataSource.getConnection();
			stmt = conn.prepareStatement(SQL_INSERT_USER);
			stmt.setString(1, user.getUsername());
			stmt.setString(2, user.getPassword());
			stmt.setBoolean(3, user.getEnabled());
			stmt.setString(4, user.getAuthority());
			stmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(stmt != null) {
					stmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void updateUser(User user) {
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			conn = dataSource.getConnection();
			stmt = conn.prepareStatement(SQL_UPDATE_USER);
			stmt.setString(1, user.getPassword());
			stmt.setBoolean(2, user.getEnabled());
			stmt.setString(3, user.getAuthority());
			stmt.setString(4, user.getUsername());
			stmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(stmt != null) {
					stmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public User findUser(String username) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dataSource.getConnection();
			stmt = conn.prepareStatement(SQL_FIND_USER);
			stmt.setString(1, username);
			
			rs = stmt.executeQuery();
			
			User user = null;
			
			if(rs.next()) {
				user = new User();
				user.setUsername(username);
				user.setPassword(rs.getString("password"));
				user.setEnabled(rs.getBoolean("enabled"));
				user.setAuthority(rs.getString("authority"));
			}
			return user;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(stmt != null) {
					stmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	

}

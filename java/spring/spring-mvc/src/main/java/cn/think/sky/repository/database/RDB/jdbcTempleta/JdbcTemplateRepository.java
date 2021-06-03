package cn.think.sky.repository.database.RDB.jdbcTempleta;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcOperations;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import cn.think.sky.model.User;

@Repository
public class JdbcTemplateRepository {
	
	@Autowired
	private JdbcOperations jdbcOperations;
	
	private static final String SQL_INSERT_USER = 
			"insert into users (username, password, enabled, authority) values (?, ?, ?, ?)";
	
	private static final String SQL_UPDATE_USER = 
			"update users set password = ?, enabled = ?, authority = ? where username = ? ";
	
	private static final String SQL_FIND_USER = 
			"select * from users where username = ? ";
	
	public void addUser(User user) {
		jdbcOperations.update(SQL_INSERT_USER, 
				user.getUsername(),
				user.getPassword(),
				user.getEnabled(),
				user.getAuthority());
	}
	
	public User findUser(String username) {
		return jdbcOperations.queryForObject(SQL_FIND_USER, new UserRowMapper(), username);
	}
}

final class UserRowMapper implements RowMapper<User>{

	public User mapRow(ResultSet rs, int rowNum) throws SQLException {
		User user = new User();
		user.setUsername(rs.getString("username"));
		user.setPassword(rs.getString("password"));
		user.setEnabled(rs.getBoolean("enabled"));
		user.setAuthority(rs.getString("authority"));
		return user;
	}
	
}

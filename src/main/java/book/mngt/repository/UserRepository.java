package book.mngt.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import book.mngt.model.User;

@Repository
public class UserRepository {

	@Autowired
	DataSource dataSource;
	JdbcTemplate jdbcTemplate = new JdbcTemplate();
	
	public User checkLogin(String email, String password) {
		jdbcTemplate.setDataSource(dataSource);
		
		String query = "SELECT UI.*, R.name as role FROM UserInfo UI INNER JOIN Role R ON UI.role_id = R.id WHERE UI.email = '" + email + "' AND UI.password = '" + password + "'";
		return jdbcTemplate.queryForObject(query, new userMapper());
	}
	
	public static final class userMapper implements RowMapper<User> {
		public User mapRow(ResultSet resultSet, int rowNum) throws SQLException {
			return new User(resultSet.getInt("id"), resultSet.getString("email"), resultSet.getString("password"), resultSet.getString("firstName"),
					resultSet.getString("lastName"), resultSet.getInt("enabled") == 1 ? true : false, resultSet.getString("avatar"), 
					resultSet.getString("role"));
		}
		
	}
}

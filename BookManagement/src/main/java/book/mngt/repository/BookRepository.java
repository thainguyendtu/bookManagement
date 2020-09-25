package book.mngt.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import book.mngt.model.Book;

@Repository
public class BookRepository {
	
	@Autowired
	DataSource dataSource;
	JdbcTemplate jdbcTemplate = new JdbcTemplate();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	public void addBook(Book book) {
		jdbcTemplate.setDataSource(dataSource);
		
		String query = "INSERT INTO Book(title, author, description, created_at, updated_at, image, enabled, user_id) "
				+ "VALUES(N'" + book.getTitle() + "', N'" + book.getAuthor() + "', N'" + book.getDescription() + "', '" + book.getCreatedAt() + "', '" 
				+ book.getUpdatedAt() + "'," + " '" + book.getImage() + "', 0, " + book.getUserId() + ")";
		
		jdbcTemplate.execute(query);
	}
	
	public List<Book> getAllBooks() {
		jdbcTemplate.setDataSource(dataSource);
		String query = "SELECT * FROM Book";
		return jdbcTemplate.query(query, new bookMapper());
	}
	
	public List<Book> getAllBooksByUserId(int userId) {
		jdbcTemplate.setDataSource(dataSource);
		String query = "SELECT * FROM Book WHERE user_id = " + userId + "";
		return jdbcTemplate.query(query, new bookMapper());
	}
	
	public List<Book> getAllEnabledBooks() {
		jdbcTemplate.setDataSource(dataSource);
		String query = "SELECT * FROM Book WHERE enabled = 1";
		return jdbcTemplate.query(query, new bookMapper());
	}
	
	public Book getBookById(int id) {
		jdbcTemplate.setDataSource(dataSource);
		String query = "SELECT * FROM Book WHERE id = " + id + "";
		return jdbcTemplate.queryForObject(query, new bookMapper());
	}
	
	public void updateBook(Book book, int id) {
		jdbcTemplate.setDataSource(dataSource);
		String query = "UPDATE Book SET title = N'" + book.getTitle() + "', "
									+ "author = N'" + book.getAuthor() + "', "
									+ "description = N'" + book.getDescription() + "', "
									+ "created_at = '" + book.getCreatedAt() + "', "
									+ "updated_at = '" + sdf.format(new Date()) + "', "
									+ "image = '" + book.getImage() + "' "
									+ "WHERE id = " + id + "";
		jdbcTemplate.execute(query);
	}
	
	public void setStatus(int id, boolean enabled) {
		jdbcTemplate.setDataSource(dataSource);
		String query = "UPDATE Book SET enabled = " + (enabled == true ? 0 : 1) + " WHERE id = " + id + "";
		jdbcTemplate.execute(query);
	}
	
	public void deleteBook(int id) {
		jdbcTemplate.setDataSource(dataSource);
		
		String query = "DELETE FROM Book WHERE id = " + id + "";
		
		jdbcTemplate.execute(query);
	}
	
	public List<Book> searchBookByAuthor(String author) {
		jdbcTemplate.setDataSource(dataSource);
		String query = "SELECT * FROM Book WHERE author like N'" + author + "'";
		return jdbcTemplate.query(query, new bookMapper());
	}
	
	public List<Book> arrangeBook(String field, boolean asc) {
		jdbcTemplate.setDataSource(dataSource);
		String query = "SELECT * FROM Book ORDER BY " + field + (asc == true ? " ASC" : " DESC");
		return jdbcTemplate.query(query, new bookMapper());
	}
	
	public static final class bookMapper implements RowMapper<Book> {
		public Book mapRow(ResultSet resultSet, int rowNum) throws SQLException {
			return new Book(resultSet.getInt("id"), resultSet.getString("title"), resultSet.getString("author"), resultSet.getString("description"), 
					String.valueOf(resultSet.getDate("created_at")), String.valueOf(resultSet.getDate("updated_at")), resultSet.getString("image"),
					resultSet.getInt("enabled") == 1 ? true : false, resultSet.getInt("user_id"));
		}
		
	}
}

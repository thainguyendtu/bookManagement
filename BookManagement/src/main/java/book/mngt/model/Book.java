package book.mngt.model;

public class Book {

	private int id;
	private int userId;
	private String title;
	private String author;
	private String description;
	private String createdAt;
	private String updatedAt;
	private String image;
	private boolean enabled;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	public String getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(String updatedAt) {
		this.updatedAt = updatedAt;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public boolean isEnabled() {
		return enabled;
	}
	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	public Book(int id, String title, String author, String description, String createdAt, String updatedAt,
			String image, boolean enabled, int userId) {
		super();
		this.id = id;
		this.title = title;
		this.author = author;
		this.description = description;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.image = image;
		this.enabled = enabled;
		this.userId = userId;
	}
	
	public Book() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}

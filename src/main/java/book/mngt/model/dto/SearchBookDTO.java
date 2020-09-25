package book.mngt.model.dto;

public class SearchBookDTO {

	private String title;
	private String author;
	
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
	
	public SearchBookDTO(String title, String author) {
		super();
		this.title = title;
		this.author = author;
	}
	
	public SearchBookDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}

package book.mngt.service;

import java.util.List;

import book.mngt.model.Book;

public interface BookService {
	
	List<Book> getAllBooks();
	
	List<Book> getAllEnabledBooks();
	
	List<Book> getAllBooksByUserId(int userId);
	
	Book getBookById(int id);
	
	void addBook(Book book);
	
	void updateBook(Book book, int id);
	
	void deleteBook(int id);
	
	void setStatus(int id, boolean enabled);
	
	List<Book> arrangeBook(String field, boolean asc);
	
}

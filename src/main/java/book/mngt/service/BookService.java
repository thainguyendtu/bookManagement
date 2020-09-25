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
	
	List<Book> getAllFavoriteBooks(int userId);
	
	void addToFavoriteBook(int bookId, int userId);
	
	void deleteFromFavoriteBook(int bookId, int userId);
	
	List<Book> arrangeFavoriteBook(int userId, String field, boolean asc);
	
	int checkFavoriteBook(int bookId, int userId);
}

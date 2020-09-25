package book.mngt.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import book.mngt.model.Book;
import book.mngt.repository.BookRepository;
import book.mngt.service.BookService;

@Service
public class BookServiceImpl implements BookService {
	
	@Autowired
	BookRepository bookRepository;

	@Override
	public List<Book> getAllBooks() {
		return bookRepository.getAllBooks();
	}
	
	@Override
	public List<Book> getAllEnabledBooks() {
		return bookRepository.getAllEnabledBooks();
	}
	
	@Override
	public List<Book> getAllBooksByUserId(int userId) {
		return bookRepository.getAllBooksByUserId(userId);
	}
	
	@Override
	public void addBook(Book book) {
		bookRepository.addBook(book);
	}

	@Override
	public Book getBookById(int id) {
		return bookRepository.getBookById(id);
	}

	@Override
	public void updateBook(Book book, int id) {
		bookRepository.updateBook(book, id);
	}

	@Override
	public void deleteBook(int id) {
		bookRepository.deleteBook(id);
	}

	@Override
	public void setStatus(int id, boolean enable) {
		bookRepository.setStatus(id, enable);
	}

	@Override
	public List<Book> arrangeBook(String field, boolean asc) {
		return bookRepository.arrangeBook(field, asc);
	}

}

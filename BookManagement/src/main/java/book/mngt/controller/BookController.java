package book.mngt.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import book.mngt.model.Book;
import book.mngt.model.User;
import book.mngt.service.BookService;

@Controller
@RequestMapping("/book")
public class BookController {
	
	List<Book> tempList = new ArrayList<Book>();

	@Autowired
	BookService bookService;
	
	@RequestMapping(value = "/getAllBooks", method = RequestMethod.GET)
	public String getAllBooks(HttpSession session, Model model) {
		List<Book> bookList = new ArrayList<Book>();
		User userLogin = (User) session.getAttribute("userInfo");
		
		if (userLogin != null) {
			if (userLogin.getId() == 1) {
				bookList = bookService.getAllBooks();
			} else {
				bookList = bookService.getAllBooksByUserId(userLogin.getId());
			}
		} else {
			bookList = bookService.getAllEnabledBooks();
		}
		tempList = bookList;

		model.addAttribute("bookList", bookList);
		
		return "bookList";
	}
	
	@RequestMapping(value = "/detail/{id}", method = RequestMethod.GET)
	public String getDetail(@PathVariable("id") int id, Model model) {
		Book book = new Book();
		book = bookService.getBookById(id);

		model.addAttribute("book", book);
		
		return "bookDetail";
	}
	
	@RequestMapping(value = "/showEdit/{id}", method = RequestMethod.GET)
	public String showEdit(@PathVariable("id") int id, Model model) {
		Book book = new Book();
		book = bookService.getBookById(id);

		model.addAttribute("book", book);
		
		return "bookEdit";
	}
	
	@RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
	public String updateBook(@ModelAttribute("book") Book book, @PathVariable("id") int id) {
		bookService.updateBook(book, id);
		
		return "redirect:/book/getAllBooks";
	}
	
	@RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
	@ResponseBody
	public String deleteBook(@PathVariable("id") int id, HttpSession session) throws JsonProcessingException {
		bookService.deleteBook(id);
		
		ObjectMapper objectMapper = new ObjectMapper();
		List<Book> bookList = new ArrayList<Book>();
		User userLogin = (User) session.getAttribute("userInfo");
		
		if (userLogin != null) {
			if (userLogin.getId() == 1) {
				bookList = bookService.getAllBooks();
			} else {
				bookList = bookService.getAllBooksByUserId(userLogin.getId());
			}
		} else {
			bookList = bookService.getAllEnabledBooks();
		}
		
		String jsonResult = objectMapper.writeValueAsString(bookList);
		
		return jsonResult;
	}
	
	@RequestMapping(value = "/search/{title}/{author}", method = RequestMethod.GET)
	@ResponseBody
	public String searchBook(@PathVariable("title") String title, @PathVariable("author") String author) throws JsonProcessingException {
		String getTitle = title.length() > 1 ? title.substring(1, title.length()) : "";
		String getAuthor = author.length() > 1 ? author.substring(1, author.length()) : "";
		
		List<Book> listSearch = new ArrayList<Book>();
		
		for (Book book : this.tempList) {
			if ((book.getTitle().contains(getTitle.toUpperCase()) || book.getTitle().contains(getTitle.toLowerCase())) &&
					(book.getAuthor().contains(getAuthor.toUpperCase()) || book.getAuthor().contains(getAuthor.toLowerCase()))) {
				listSearch.add(book);
			}
		}
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		String jsonResult = objectMapper.writeValueAsString(listSearch);
		
		return jsonResult;
	}
	
	@RequestMapping(value = "/showAddBook", method = RequestMethod.GET)
	public String showAddBook(Model model) {
		
		model.addAttribute("book", new Book());
		return "bookCreate";
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addBook(@ModelAttribute("book") Book book, Model model, HttpSession session) {
		User userLogin = (User) session.getAttribute("userInfo");
		
		String title = book.getTitle();
		String author = book.getAuthor();
		String description = book.getDescription();
		String date = new SimpleDateFormat("yyyy/MM/dd").format(new Date());
		
		Book newBook = new Book(0, title, author, description, date, date, "abc", false, userLogin.getId());
		
		bookService.addBook(newBook);
		
		model.addAttribute("notification", true);
		return "redirect:/book/getAllBooks";
	}
	
	@RequestMapping(value = "/setStatus/{id}", method = RequestMethod.GET)
	@ResponseBody
	public void setStatus(@PathVariable("id") int id) {
		Book book = bookService.getBookById(id);
		bookService.setStatus(id, book.isEnabled());
	}
	
	@RequestMapping(value = "/arrange/{field}/{asc}", method = RequestMethod.GET)
	@ResponseBody
	public String titleAsc(@PathVariable("field") String field, @PathVariable("asc") boolean asc) throws JsonProcessingException {
		List<Book> listArrange = new ArrayList<Book>();
		
		listArrange = bookService.arrangeBook(field, asc);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		String jsonResult = objectMapper.writeValueAsString(listArrange);
		
		return jsonResult;
		
	}
	
}

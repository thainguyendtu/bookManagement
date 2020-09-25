package book.mngt.service;

import book.mngt.model.User;

public interface UserService {
	User checkLogin(String email, String password);
}

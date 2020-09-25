package book.mngt.serviceimpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import book.mngt.model.User;
import book.mngt.repository.UserRepository;
import book.mngt.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	UserRepository userRepository;

	@Override
	public User checkLogin(String email, String password) {
		return userRepository.checkLogin(email, password);
	}

}

package book.mngt.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import book.mngt.model.User;
import book.mngt.service.UserService;

@Controller
public class UserController {

	@Autowired
	UserService userService;
	
	@RequestMapping(value = "/showLogin", method = RequestMethod.GET)
	public String showLogin(Model model) {
		model.addAttribute("userLogin", new User());
		return "login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String checkLogin(@ModelAttribute("userLogin") User userLogin, Model model, HttpServletRequest request) {
		String email = userLogin.getEmail();
		String password = userLogin.getPassword();
		
		if (StringUtils.isEmpty(email) || StringUtils.isEmpty(password)) {
			model.addAttribute("errorEmpty", true);
			return "redirect:/showLogin";
		} else {
			User user = userService.checkLogin(email, password);
			
			if (user != null) {
				HttpSession session = request.getSession();
				session.setAttribute("userInfo", user);
				return "redirect:/book/getAllBooks";
			} else {
				model.addAttribute("errorIncorrect", true);
				return "redirect:/showLogin";
			}
		}
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(Model model, HttpSession session) {
		if (session.getAttribute("userInfo") != null) {
			session.invalidate();
		}
		model.addAttribute("logoutSuccess", true);
		return "redirect:/showLogin";
	}
	
}

package kr.or.picsion;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.View;

import kr.or.picsion.user.dao.UserDao;
import kr.or.picsion.user.dto.User;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping("/popular.ps")
	public String getList(Model model) {
		System.out.println("들어왔");
		List<String> list = new ArrayList<String>();
		list.add("images/5.jpg");
		list.add("images/6.jpg");
		list.add("images/7.jpg");
		list.add("images/8.jpg");
		list.add("images/9.jpg");
		list.add("images/picsionlogo.png");
		list.add("images/picsionlogo.png");
		list.add("images/picsionlogo.png");
		list.add("images/picsionlogo.png");
		list.add("images/picsionlogo.png");
		
		model.addAttribute("popularlist",list);
		
		return "popular.popular";
	}
	
	
	@RequestMapping(value = "home.ps", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		UserDao UserDao = sqlSession.getMapper(UserDao.class);
		
		List<User> user = UserDao.getPicsionList();
		System.out.println("User 리스트를 보여주세요");
		for(User u : user) {
			System.out.println(u);
		}
		
		List<String> list = new ArrayList<String>();
		list.add("images/5.jpg");
		list.add("images/6.jpg");
		list.add("images/7.jpg");
		list.add("images/8.jpg");
		list.add("images/9.jpg");
		
		model.addAttribute("imagelist", list);
		model.addAttribute("userList", user);
		model.addAttribute("serverTime", formattedDate );
		
		return "home.home";
	}

}

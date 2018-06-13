package kr.or.picsion;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.View;

import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.user.dao.UserDao;
import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private UserService userService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	
	@RequestMapping(value = "home.ps", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		UserDao UserDao = sqlSession.getMapper(UserDao.class);
		
		User user2 = (User) session.getAttribute("user");
		
		List<User> user = UserDao.getPicsionList();
		System.out.println("User 리스트를 보여주세요");
		for(User u : user) {
			System.out.println(u);
		}
		
		if(user2 != null) {
			List<Picture> followingPicList = userService.listpic(user2);
		    model.addAttribute("imagelist", followingPicList);
			
		}
		
		model.addAttribute("userList", user);
		model.addAttribute("serverTime", formattedDate );
		
		return "home.home";
	}

}

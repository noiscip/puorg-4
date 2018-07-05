package kr.or.picsion;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.picture.service.PictureService;
import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private PictureService pictureService;
	
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
		System.out.println("formattedDate : " + formattedDate);
		SimpleDateFormat reg = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");		
		System.out.println("regDate : " + reg.format(date));
		User user = (User) session.getAttribute("user");
		List<Picture> ranPicture = pictureService.selectRandom();
		List<Picture> latestPicList = new ArrayList<>();
		List<User> latestPicOwnList = pictureService.latestPicOwnList();
		if(user != null) {
			List<Picture> followingPicList = userService.followingUserPicList(user.getUserNo(), 0, 10);
			List<User> randomuser = userService.randomUsers(user.getUserNo());
			latestPicList = pictureService.latestPicList(user.getUserNo());
		    model.addAttribute("imagelist", followingPicList);
		    model.addAttribute("randomuser",randomuser);
		    model.addAttribute("latestPicList",latestPicList);
		}else{
		 latestPicList = pictureService.latestPicList(0);
		 System.out.println(latestPicList);
		 model.addAttribute("latestPicList",latestPicList);
		 
		}
		
		model.addAttribute("serverTime", formattedDate );
		model.addAttribute("ranPicture",ranPicture);
		model.addAttribute("latestPicOwnList",latestPicOwnList);
		
		return "home.home";
	}

}

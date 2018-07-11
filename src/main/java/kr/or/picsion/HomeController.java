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
import org.springframework.web.servlet.View;

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
    private View jsonview;
   	
	@Autowired
	private UserService userService;
	
	@Autowired
	private PictureService pictureService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "home.ps", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session) {
		logger.info("Welcome home! The client locale is {}.", locale);
		int page=0;
		int endpage=9;
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		User user = (User) session.getAttribute("user");
		List<Picture> ranPicture = pictureService.selectRandom();
		List<Picture> latestPicList = new ArrayList<>();								//사진
		List<User> bestUploader = userService.bestUploader();
		List<User> mostFollowingUser = userService.mostFollowingUser();
		if(user != null) {
			List<Picture> followingPicList = userService.followingUserPicList(user.getUserNo(), 0, 10);
			latestPicList = pictureService.latestPicList(user.getUserNo(), page, endpage);
		    model.addAttribute("imagelist", followingPicList);
		    model.addAttribute("latestPicList",latestPicList);
		}else{
			 latestPicList = pictureService.latestPicList(0, page, endpage);
			 model.addAttribute("latestPicList",latestPicList);
		}
		
		model.addAttribute("mostFollowingUser",mostFollowingUser);
		model.addAttribute("bestUploader",bestUploader);
		model.addAttribute("serverTime", formattedDate );
		model.addAttribute("ranPicture",ranPicture);
		model.addAttribute("page", latestPicList.size());
		
		return "home.home";
	}
	
	/**
	* 날      짜 : 2018. 7. 6.
	* 메소드명 : homeList
	* 작성자명 : 박주원
	* 기      능 : 메인페이지 사진 스크롤 페이징
	*
	* @param locale
	* @param model
	* @param session
	* @return View
	*/
	@RequestMapping(value = "home.ps", method = RequestMethod.POST)
	public View homeList(Locale locale, Model model, HttpSession session, int page) {
		User user = (User) session.getAttribute("user");
		int endpage=9;
		List<Picture> latestPicList = new ArrayList<>();		//사진
		
		if(user != null) {
			latestPicList = pictureService.latestPicList(user.getUserNo(), page, endpage);
		    model.addAttribute("latestPicList",latestPicList);
		}else{
			latestPicList = pictureService.latestPicList(0, page, endpage);
			model.addAttribute("latestPicList",latestPicList);
		}
		model.addAttribute("endpage", latestPicList.size());
		
		return jsonview;
	}
}

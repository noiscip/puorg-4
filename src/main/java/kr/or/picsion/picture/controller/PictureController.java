package kr.or.picsion.picture.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

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

@Controller
@RequestMapping("/picture/")
public class PictureController {

	@Autowired
	private View jsonview;

	@Autowired
	private PictureService pictureService;
	

	@Autowired
	private UserService userService;
	
	//Studio 페이지 이동(userNo 값 받아서)  회원 팔로잉,팔로워,업로드한 사진,팔로잉했는지 확인 결과 불러오기 
	@RequestMapping("mystudio.ps")
	public String myStudio(HttpSession session, Model model, int userNo){
		
		User user = (User) session.getAttribute("user");
		List<Picture> picList = new ArrayList<Picture>();
		List<User> followerList = new ArrayList<User>();
		List<User> followingList = new ArrayList<User>();
		
		//
		User userInfo = userService.userInfo(userNo);
		picList = pictureService.myPicList(userNo);
		followerList = userService.followerUserList(userNo);
		followingList = userService.followingUserList(userNo);
		int followResult = 0;
		
		if(user.getUserNo() != userNo) {
			followResult = userService.followingConfirm(user.getUserNo(), userNo);
		}
		
		model.addAttribute("userinfo", userInfo);
		model.addAttribute("piclist", picList);
		model.addAttribute("followerlist", followerList);
		model.addAttribute("followinglist", followingList);
		model.addAttribute("followReslut", followResult);
		
		return "studio.mystudio";
	}
	
	
}

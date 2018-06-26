package kr.or.picsion.user.controller;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;

import com.drew.imaging.ImageMetadataReader;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.Tag;

import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.picture.service.PictureService;
import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;


/**
 * @project Final_Picsion
 * @package kr.or.picsion.user.controller 
 * @className UserController
 * @date 2018. 6. 12.
 */

@Controller
@RequestMapping("/user/")
public class UserController {

	@Autowired
	private View jsonview;

	@Autowired
	private UserService userService;
	
	@Autowired
	private PictureService pictureService;

	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@RequestMapping(value="register.ps", method=RequestMethod.GET)
    public String register(){
        return "user.register";
    }
	
	@RequestMapping(value="register.ps", method=RequestMethod.POST)
	public String userRegister(User user) {
		userService.register(user);
		return "redirect:/home.ps";
	}
	
	@RequestMapping(value="login.ps", method=RequestMethod.GET)
	public String userLogint() {
		return "user.login";
	}
	
	
	@RequestMapping(value="login.ps", method=RequestMethod.POST)
	public String userLogin(User user, HttpSession session) {
		User loginUser = userService.login(user);
		String result="";
		if(loginUser != null) {
			session.setAttribute("user", loginUser);
			if(loginUser.getRoleNo()==3) {
				result = "redirect:/user/admin.ps";
			}else {
				result = "redirect:/home.ps";
			}
		}else {
			result = "redirect:/user/login.ps";
		}
		return result;
	}
	
	@RequestMapping("logout.ps")
	public String userLogout(HttpSession session) {
		session.invalidate();
		return "redirect:/home.ps";
	}
	
	@RequestMapping("admin.ps")
	public String adminPage(Model model) {
		
		List<User> userList = userService.userList();
		model.addAttribute("userList",userList);
		return "admin.admin";
	}
	
	@RequestMapping("adminUserDel.ps")
	public View userDel(int userNo, Model model) {
		
		int result = userService.userDel(userNo);
		model.addAttribute("result",result);
		return jsonview;
	}
	
	@RequestMapping("adminAllUser.ps")
	public View userFindAll(Model model) {
		List<User> userList = userService.userList();
		model.addAttribute("allUser",userList);
		return jsonview;
	}
	
	@RequestMapping("adminUserSearch.ps")
	public View userSearch(String userId, Model model) {
		
		User user = userService.searchUserId(userId);
		model.addAttribute("searchUser",user);
		return jsonview;
	}
	
	
	//팔로잉하는 사람의 최신 사진 전체 페이지
	@RequestMapping(value="popular.ps", method=RequestMethod.GET)
	public String getList(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		List<Picture> followingPicList = userService.listpic(user.getUserNo()); //팔로잉 최신 사진 리스트
		List<User> followingPicListOwner = userService.listpicown(user.getUserNo()); //사진 주인 리스트
		System.out.println(followingPicList);
		model.addAttribute("imagelistall", followingPicList);
		model.addAttribute("ownlist",followingPicListOwner);
		
		return "popular.followingpicall";
	}
	
	@RequestMapping(value="userlist.ps")
	public String userList(Model model) {
		
		List<User> userList = userService.userList();
		model.addAttribute("testbb", userList);
		return "home.admin";
	}
	
	//팔로잉 하고 있는지 확인
	@RequestMapping("following.ps")
	public View followingConfirm(int userNo, int followingUserNo, Model model) {
		
		int result = userService.followingConfirm(userNo, followingUserNo); 

		if(result!=0) {		//result가 1이면 팔로잉 취소 처리
			userService.deleteFollow(userNo, followingUserNo);
			System.out.println("팔로잉 취소 완료!!");
		}else {				//result가 0이면 팔로우 처리
			userService.insertFollow(userNo, followingUserNo);
			System.out.println("팔로잉 완료!!!");
		}		
		
		model.addAttribute("result", result);
		
		return jsonview;
	}
	
	//즐겨찾기한 사진 목록보기 페이지로 이동
	@RequestMapping("bookmarklist.ps")
	public String myBookmark(HttpSession session, Model model) {
		System.out.println("myBookmark 컨트롤");
		User user = (User)session.getAttribute("user");
		System.out.println(user.getUserNo());
		List<Picture> bookmarkPicList = userService.bookmarkPicList(user.getUserNo());
		List<User> bookmarkPicUserList = userService.bookmarkPicUserList(user.getUserNo());
		model.addAttribute("bookmarkPicList", bookmarkPicList);
		model.addAttribute("bookmarkPicUserList",bookmarkPicUserList);
		
		return "mypage.bookmark";
	}
	
	//팔로잉한 회원의 목록보기 페이지로 이동
	@RequestMapping("followinglist.ps")
	public String myFollowing(HttpSession session, Model model) {
		System.out.println("myFollowing 컨트롤");
		User user = (User)session.getAttribute("user");
		
		List<User> followingList = userService.followingUserList(user.getUserNo());
		
		model.addAttribute("followingList", followingList);
		
		return "mypage.following";
	}
	
	//정보 수정 페이지로 이동 (회원의 정보 검색해서)
	@RequestMapping(value="updateinfo.ps", method=RequestMethod.GET)
	public String updatePage(HttpSession session, Model model) {
		User user = (User)session.getAttribute("user");
		User userinfo = userService.userInfo(user.getUserNo());
		
		model.addAttribute("userinfo", userinfo);
		
		return "mypage.updateinfo";
	}
	
	//정보수정 페이지에서 정보수정
	@RequestMapping(value="updateinfo.ps", method=RequestMethod.POST)
	public String updateInfo(HttpSession session, User user, MultipartFile file) {
		User userSession = (User)session.getAttribute("user");
		user.setUserNo(userSession.getUserNo());
		
		System.out.println(file.getOriginalFilename());
		System.out.println(user);
		String filePathh="";
		String uploadPath = "C:\\bitcamp104\\PICSION\\Final_Picsion\\src\\main\\webapp\\assets\\img\\faces\\";
		String path="/assets/img/faces/";
		
		File dir = new File(uploadPath);
		if (!dir.isDirectory()) {
			dir.mkdirs();
		}

		String originalFileName = file.getOriginalFilename();
		String saveFileName = originalFileName;//	우어어ㅓㅇ~~~~~~~~~~~~~~~
		filePathh = uploadPath + saveFileName;
		
		String dbPath=path+originalFileName;
		
		if(originalFileName.equals("")&&userSession.getPrContent().equals(user.getPrContent())) {
			System.out.println("같은거지?");
		}else {		//파일은 파일 업로드만 따로 분리!
			if(saveFileName != null && !saveFileName.equals("")) {
				/*if(saveFileName.toLowerCase().indexOf(".jpg")>0){
					saveFileName = header+"check01"+".jpg";
				}*/
				if(new File(uploadPath + saveFileName).exists()) {
					saveFileName = saveFileName + "_" + System.currentTimeMillis();
				}
				try {
					File newFile = new File(uploadPath + saveFileName);
					file.transferTo(newFile);
					
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				} 
			} 
			
			user.setPrPicture(dbPath);
			userService.updateUserPr(user);
		}
		
		if(user.getPwd()=="") {
			System.out.println("안되 비었어");
		}else if(userSession.getPwd().equals(user.getPwd())) {
			System.out.println("안되 똑같아");
		}else {
			userService.updateUserInfo(user);
		}
		
		session.setAttribute("user", userService.userInfo(user.getUserNo()));
		
		return "redirect:updateinfo.ps";
	}
	
	//포인트 충전
	@RequestMapping("charge.ps")
	public View pointCharge(HttpSession session, int point, Model model) {
		User user = (User)session.getAttribute("user");
		int result=userService.pointCharge(point, user.getUserNo());
		
		model.addAttribute("result", result);
		
		return jsonview;
	}
	
}

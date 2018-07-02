package kr.or.picsion.user.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.View;
import kr.or.picsion.picture.dto.Picture;
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
	
	
	/**
	* 날      짜 : 2018. 6. 8.
	* 메소드명 : register
	* 작성자명 : 아윤근
	* 기      능 : 회원가입 페이지로 이동
	*
	* @return String
	*/
	@RequestMapping(value="register.ps", method=RequestMethod.GET)
    public String register(){
        return "user.register";
    }
	
	/**
	* 날      짜 : 2018. 6. 8.
	* 메소드명 : userRegister
	* 작성자명 : 아윤근
	* 기      능 : 회원가입
	*
	* @param user
	* @return String
	*/
	@RequestMapping(value="register.ps", method=RequestMethod.POST)
	public String userRegister(User user) {
		userService.register(user);
		return "redirect:/home.ps";
	}
	
	/**
	* 날      짜 : 2018. 6. 8.
	* 메소드명 : userLogin
	* 작성자명 : 아윤근
	* 기      능 : 로그인 페이지로 이동
	*
	* @return String
	*/
	@RequestMapping(value="login.ps", method=RequestMethod.GET)
	public String userLogin() {
		return "user.login";
	}
	
	/**
	* 날      짜 : 2018. 6. 8.
	* 메소드명 : userLogin
	* 작성자명 : 아윤근
	* 기      능 : 로그인
	*
	* @param user
	* @param session
	* @return String
	*/
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
	
	/**
	* 날      짜 : 2018. 6. 8.
	* 메소드명 : userLogout
	* 작성자명 : 아윤근
	* 기      능 : 로그아웃
	*
	* @param session
	* @return String
	*/
	@RequestMapping("logout.ps")
	public String userLogout(HttpSession session) {
		session.invalidate();
		return "redirect:/home.ps";
	}
	
	/**
	* 날      짜 : 2018. 6. 8.
	* 메소드명 : adminPage
	* 작성자명 : 김보경
	* 기      능 : 관리자 페이지로 이동
	*
	* @param model
	* @return String
	*/
	@RequestMapping("admin.ps")
	public String adminPage(Model model) {
		
		List<User> userList = userService.userList();
		model.addAttribute("userList",userList);
		return "admin.admin";
	}
	
	/**
	* 날        짜 : 2018. 6. 13.
	* 메소드명 : popularPicList
	* 작성자명 : 정도혁
	* 기        능 : 팔로잉 유저의 최신 사진 페이지
	*
	* @param session
	* @param model
	* @return String
	*/
	@RequestMapping(value="popular.ps", method=RequestMethod.GET)
	public String popularPicList(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		List<Picture> followingPicList = userService.followingUserPicList(user.getUserNo()); //팔로잉 최신 사진 리스트
		List<User> followingPicListOwner = userService.followingUserPicOwnerList(user.getUserNo()); //사진 주인 리스트
		System.out.println(followingPicList);
		model.addAttribute("followingPicList", followingPicList);
		model.addAttribute("followingPicListOwner",followingPicListOwner);
		
		return "popular.followingpicall";
	}
	
	//삭제 여부?? 테스트용인가요??
	@RequestMapping(value="userlist.ps")
	public String userList(Model model) {
		
		List<User> userList = userService.userList();
		model.addAttribute("testbb", userList);
		return "home.admin";
	}
	
	/**
	* 날      짜 : 2018. 6. 13.
	* 메소드명 : followingConfirm
	* 작성자명 : 박주원
	* 기      능 : 내가 팔로잉하고 있는지 확인
	*
	* @param userNo
	* @param followingUserNo
	* @param model
	* @return View
	*/
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
	
	/**
	* 날      짜 : 2018. 6. 13.
	* 메소드명 : myBookmark
	* 작성자명 : 박주원, 정도혁
	* 기      능 : 즐겨찾기한 사진 목록보기 페이지로 이동
	*
	* @param session
	* @param model
	* @return String
	*/
	@RequestMapping(value="bookmarklist.ps", method=RequestMethod.GET)
	public String myBookmark(HttpSession session, Model model) {
		User user = (User)session.getAttribute("user");
		int page=0;
		int endpage=6;
		
		List<Picture> bookmarkPicList = userService.bookmarkPicList(user.getUserNo(), page, endpage);
		List<User> bookmarkPicUserList = userService.bookmarkPicUserList(user.getUserNo(), page, endpage);
		
		model.addAttribute("bookmarkPicList", bookmarkPicList);
		model.addAttribute("bookmarkPicUserList",bookmarkPicUserList);
		model.addAttribute("page", bookmarkPicList.size());
		
		return "mypage.bookmark";
	}
	
	/**
	* 날      짜 : 2018. 7. 2.
	* 메소드명 : myBookmark
	* 작성자명 : 박주원
	* 기      능 : 북마크 리스트 스크롤 페이징
	*
	* @param session
	* @param model
	* @return View
	*/
	@RequestMapping(value="bookmarklist.ps", method=RequestMethod.POST)
	public View myBookmarkScroll(HttpSession session, Model model, int page) {
		User user = (User)session.getAttribute("user");
		int endpage=6;
		
		List<Picture> scrollPicList = userService.bookmarkPicList(user.getUserNo(), page, endpage);
		List<User> scrollPicUserList = userService.bookmarkPicUserList(user.getUserNo(), page, endpage);
		
		model.addAttribute("scrollPicList", scrollPicList);
		model.addAttribute("scrollPicUserList",scrollPicUserList);
		model.addAttribute("endpage", scrollPicList.size());
		
		return jsonview;
	}
	
	/**
	* 날      짜 : 2018. 6. 13.
	* 메소드명 : myFollowing
	* 작성자명 : 박주원
	* 기      능 : 팔로잉한 회원의 목록보기 페이지로 이동
	*
	* @param session
	* @param model
	* @return String
	*/
	@RequestMapping("followinglist.ps")
	public String myFollowing(HttpSession session, Model model) {
		System.out.println("myFollowing 컨트롤");
		User user = (User)session.getAttribute("user");
		
		List<User> followingList = userService.followingUserList(user.getUserNo());
		
		model.addAttribute("followingList", followingList);
		
		return "mypage.following";
	}

	/**
	* 날      짜 : 2018. 6. 18.
	* 메소드명 : userDel
	* 작성자명 : 김보경
	* 기      능 : 유저 삭제 처리
	*
	* @param userNo
	* @param model
	* @return View
	*/
	@RequestMapping("adminUserDel.ps")
	public View userDel(int userNo, Model model) {
		
		int result = userService.userDel(userNo);
		model.addAttribute("result",result);
		return jsonview;
	}
	
	/**
	* 날      짜 : 2018. 6. 19.
	* 메소드명 : userFindAll
	* 작성자명 : 김보경
	* 기      능 : 회원 전체 검색
	*
	* @param model
	* @return View
	*/
	@RequestMapping("adminAllUser.ps")
	public View userFindAll(Model model) {
		List<User> userList = userService.userList();
		model.addAttribute("allUser",userList);
		return jsonview;
	}
	
	/**
	* 날      짜 : 2018. 6. 19.
	* 메소드명 : userSearch
	* 작성자명 : 김보경
	* 기      능 : userId로 회원 검색
	*
	* @param userId
	* @param model
	* @return View
	*/
	@RequestMapping("adminUserSearch.ps")
	public View userSearch(String userId, Model model) {
		
		User user = userService.searchUserId(userId);
		model.addAttribute("searchUser",user);
		return jsonview;
	}
	
	/**
	* 날      짜 : 2018. 6. 26.
	* 메소드명 : updatePage
	* 작성자명 : 정도혁
	* 기      능 : 정보 수정 페이지로 이동 (회원의 정보 검색해서)
	*
	* @param session
	* @param model
	* @return String
	*/
	@RequestMapping(value="updateinfo.ps", method=RequestMethod.GET)
	public String updatePage(HttpSession session, Model model) {
		User user = (User)session.getAttribute("user");
		User userinfo = userService.userInfo(user.getUserNo());
		
		model.addAttribute("userinfo", userinfo);
		
		return "mypage.updateinfo";
	}
	
	/**
	* 날      짜 : 2018. 6. 26.
	* 메소드명 : updateInfo
	* 작성자명 : 박주원
	* 기      능 : 정보수정
	*
	* @param session
	* @param user
	* @param file
	* @return String
	*/
	@RequestMapping(value="updateinfo.ps", method=RequestMethod.POST)
	public String updateInfo(HttpSession session, User user, MultipartFile file) {
		User userSession = (User)session.getAttribute("user");
		user.setUserNo(userSession.getUserNo());
		
		System.out.println(file.getOriginalFilename());
		String filePathh="";
		String uploadPath = "C:\\bitcamp104\\PICSION\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\Final_Picsion\\assets\\img\\faces\\";
		String path="/assets/img/faces/";
		
		File dir = new File(uploadPath);
		if (!dir.isDirectory()) {
			dir.mkdirs();
		}

		String originalFileName = file.getOriginalFilename();
		String saveFileName = originalFileName;
		filePathh = uploadPath + saveFileName;
		
		String dbPath=path+originalFileName;
		
		//자기소개 변경했을때
		if(userSession.getPrContent().equals(user.getPrContent())) {
			System.out.println("같은거지?");
		}else {		
			userService.updateUserPr(user);
		}
		
		//프로필 사진 변경 했을때
		if(originalFileName.equals("")) {
			System.out.println("프로필 사진 변경 X");
		}else {
			if(saveFileName != null && !saveFileName.equals("")) {
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
			
			System.out.println(user);
			user.setPrPicture(dbPath);
			userService.updateUserPic(user);
		}
		
		//비밀번호, 유저네임 변경했을때
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
	/**
	* 날      짜 : 2018. 6. 26.
	* 메소드명 : pointCharge
	* 작성자명 : 박주원
	* 기      능 : 포인트 충전
	*
	* @param session
	* @param point
	* @param model
	* @return View
	*/
	@RequestMapping("charge.ps")
	public View pointCharge(HttpSession session, int point, Model model) {
		User user = (User)session.getAttribute("user");
		int result=userService.pointCharge(point, user.getUserNo());
		
		model.addAttribute("result", result);
		
		return jsonview;
	}
	
	/**
	* 날      짜 : 2018. 6. 27.
	* 메소드명 : updateBeforePage
	* 작성자명 : 박주원
	* 기      능 : 정보 수정 전 비밀번호 확인 페이지
	*
	* @return String
	*/
	@RequestMapping(value="updatebefore.ps", method=RequestMethod.GET)
	public String updateBeforePage() {
		return "mypage.updatebefore";
	}
	
	/**
	* 날      짜 : 2018. 6. 27.
	* 메소드명 : updateBefore
	* 작성자명 : 박주원
	* 기      능 : 정보 수정 페이지전 (비밀번호 확인)
	*
	* @param user
	* @param session
	* @return String
	*/
	@RequestMapping(value="updatebefore.ps", method=RequestMethod.POST)
	public String updateBefore(User user, HttpSession session) {
		User userSession = (User)session.getAttribute("user");
		String result;
		
		if(userSession.getPwd().equals(user.getPwd())) {
			result="redirect:updateinfo.ps";
		}else {
			result="redirect:updatebefore.ps";
		}
		
		return result;
	}
	
}

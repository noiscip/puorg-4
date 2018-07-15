package kr.or.picsion.user.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.View;

import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;
import kr.or.picsion.utils.AmazonUpload;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.user.controller 
 * @className UserController
 * @date 2018. 6. 4.
 */

@Controller
@RequestMapping("/user/")
public class UserController {

	@Autowired
	private View jsonview;

	@Autowired
	private UserService userService;
	
	@Autowired
	private AmazonUpload amazonService;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;	
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
//		String password = user.getPwd();
		
		User loginUser = userService.login(user);
//		User loginUser = userService.searchUserId(user.getUserId());
		
//		boolean re = bCryptPasswordEncoder.matches(password,loginUser.getPwd());
//		System.out.println(re);
		
		
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
	
	@RequestMapping("adminStats.ps")
	public String salesStats(Model model) {
		
		
		return "admin.stats";
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
		int page=0;
		int endpage=9;
		
		List<Picture> followingPicList = userService.followingUserPicList(user.getUserNo(), page, endpage); //팔로잉 최신 사진 리스트
		model.addAttribute("followingPicList", followingPicList);
		model.addAttribute("page", followingPicList.size());
		
		return "popular.followingpicall";
	}
	
	/**
	* 날      짜 : 2018. 7. 4.
	* 메소드명 : popularPicScroll
	* 작성자명 : 박주원
	* 기      능 : 팔로잉한 유저의 사진 스크롤 페이징
	*
	* @param session
	* @param model
	* @param page
	* @return View
	*/
	@RequestMapping(value="popular.ps", method=RequestMethod.POST)
	public View popularPicScroll(HttpSession session, Model model, int page) {
		User user = (User) session.getAttribute("user");
		int endpage=9;
		
		List<Picture> followingScrollPic = userService.followingUserPicList(user.getUserNo(), page, endpage); //팔로잉 최신 사진 리스트
		
		model.addAttribute("followingScrollPic", followingScrollPic);
		model.addAttribute("endpage", followingScrollPic.size());
		
		return jsonview;
	}

	/**
	* 날      짜 : 2018. 6. 9.
	* 메소드명 : userList
	* 작성자명 : 김보경
	* 기      능 : 유저목록 가져오기
	*
	* @param model
	* @return String
	*/
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
	@Transactional(propagation = Propagation.REQUIRED)
	public View followingConfirm(int userNo, int followingUserNo, Model model) {
		try {
			int result = userService.followingConfirm(userNo, followingUserNo); 

			if(result!=0) {		//result가 1이면 팔로잉 취소 처리
				userService.deleteFollow(userNo, followingUserNo);
			}else {				//result가 0이면 팔로우 처리
				userService.insertFollow(userNo, followingUserNo);
			}		
			
			model.addAttribute("result", result);
		} catch (Exception e) {
			e.printStackTrace();
		}
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
		int endpage=9;
		
		List<Picture> bookmarkPicList = userService.bookmarkPicList(user.getUserNo(), page, endpage);
		List<User> bookmarkPicUserList = userService.bookmarkPicUserList(user.getUserNo(), page, endpage);
		
		model.addAttribute("bookmarkPicList", bookmarkPicList);
		model.addAttribute("bookmarkPicUserList",bookmarkPicUserList);
		model.addAttribute("page", bookmarkPicList.size());
		
		return "mypage.bookmark";
	}
	@RequestMapping("myStats.ps")
	public String myStats(Model model) {
		
		
		return "mypage.personalStatistics";
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
		int endpage=9;
		
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
	/*@RequestMapping("followinglist.ps")
	public String myFollowing(HttpSession session, Model model, String pg) {
		User user = (User)session.getAttribute("user");
		
		int total=0;
        
        int page = 1;
        String Strpg = pg;
        if (Strpg != null) {
            page = Integer.parseInt(Strpg);
        }

        int rowSize = 12;
        int start = (page * rowSize) - (rowSize - 1) - 1;

        //구매목록 count 해서 가져오기 
        total = userService.getFollowingCount(user.getUserNo());

        // ... 목록
        int allPage = (int) Math.ceil(total / (double) rowSize); // 페이지수
        // int totalPage = total/rowSize + (total%rowSize==0?0:1);

        int block = 5; // 한페이지에 보여줄 범위 << [1] [2] [3] [4] [5] [6] [7] [8] [9]
        // [10] >>
        int fromPage = ((page - 1) / block * block) + 1; // 보여줄 페이지의 시작
        // ((1-1)/10*10)
        int toPage = ((page - 1) / block * block) + block; // 보여줄 페이지의 끝
        if (toPage > allPage) { // 예) 20>17
            toPage = allPage;
        }
		
		
		List<User> followingList = userService.followingUserPaging(user.getUserNo(), start, rowSize);
		
		model.addAttribute("followingList", followingList);
		model.addAttribute("pg", page);
        model.addAttribute("allPage", allPage);
        model.addAttribute("block", block);
        model.addAttribute("fromPage", fromPage);
        model.addAttribute("toPage", toPage);
        
		return "mypage.following";
	}*/

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
		System.out.println(userId);
		User user = userService.searchUserId(userId);
		model.addAttribute("searchUser",user);
		
		return jsonview;
	}
	
	/**
	* 날      짜 : 2018. 6. 26.
	* 메소드명 : updatePage
	* 작성자명 : 박주원
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
	@Transactional(propagation = Propagation.REQUIRED)    //정보 수정 트랜잭션
	public String updateInfo(HttpSession session, User user, MultipartFile file) {
		User userSession = (User)session.getAttribute("user");

		try {
			user.setUserNo(userSession.getUserNo());
			
			String uploadPath = "/resources/upload/";
			
			File dir = new File(uploadPath);
			if (!dir.isDirectory()) {
				dir.mkdirs();
			}

			String originalFileName = file.getOriginalFilename();

			
			//프로필 사진 변경 했을때
			if(originalFileName.equals("")) {
			}else {
				String saveFileName = "prPic"+user.getUserNo()+ System.currentTimeMillis()+"."+originalFileName.split("\\.")[1];
				String dbPath="";
				if(saveFileName != null && !saveFileName.equals("")) {
					if(new File(uploadPath + saveFileName).exists()) {
						saveFileName = saveFileName + "_" + System.currentTimeMillis();
					}
					try {
						File newFile = new File(uploadPath + saveFileName);
						file.transferTo(newFile);
						dbPath=amazonService.uploadObject(uploadPath, saveFileName, "picsion/profile");
						
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					} 
				} 
				
				user.setPrPicture(dbPath);
				userService.updateUserPic(user);
			}
			
			//자기소개 변경했을때 (변경하지 않으면 업데이트 X)
			if(userSession.getPrContent() != null && userSession.getPrContent().equals(user.getPrContent())) {
			}else if(userSession.getPrContent() == null && user.getPrContent().equals("")){
			}else {
				userService.updateUserPr(user);
			}
					
			//비밀번호, 유저네임 변경했을때
			if(user.getPwd()=="" || userSession.getPwd().equals(user.getPwd())) {
				
			}else {
				user.setPwd(bCryptPasswordEncoder.encode(user.getPwd()));
				userService.updateUserInfo(user);
			}
			
			session.setAttribute("user", userService.userInfo(user.getUserNo()));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:updateinfo.ps";
	}
	
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
	@Transactional(propagation = Propagation.REQUIRED)  //포인트 충전 트랜잭션
	public View pointCharge(HttpSession session, int point, Model model) {
		User user = (User)session.getAttribute("user");
		try {
			int result=userService.pointCharge(point, user.getUserNo());
			user = userService.userInfo(user.getUserNo());
			session.setAttribute("user", user);
			
			model.addAttribute("point",user.getPoint());
			model.addAttribute("result", result);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
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
		boolean login = bCryptPasswordEncoder.matches(user.getPwd(),userSession.getPwd());
		if(login) {
			result="redirect:updateinfo.ps";
		}else {
			result="redirect:updatebefore.ps";
		}
		
		return result;
	}
	
	@RequestMapping("sessionReset.ps")
	public View sessionReset(HttpSession session) {
		User user = (User)session.getAttribute("user");
		user = userService.userInfo(user.getUserNo());
		
		session.setAttribute("user", user);
		
		return jsonview;
	}
	
}

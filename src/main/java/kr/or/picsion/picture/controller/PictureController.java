package kr.or.picsion.picture.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;

import kr.or.picsion.comment.dto.Comment;
import kr.or.picsion.comment.service.CommentService;
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
	
	@Autowired
	private CommentService commentService;
	
	@RequestMapping("picinfo.ps")
	public String picInfo(Model model, int picNo, int userNo){
		Picture picture = pictureService.picInfo(picNo); 			  //클릭한 사진
		User userInfo = userService.userInfo(userNo);    			  //사진 주인	
		List<Comment> commentList = commentService.picCommentList(picNo); //댓글 목록
		List<User> commentUserList = commentService.picCommentUserList(picNo); //댓글 유저 목록           //댓글 작성자 목록
		List<String> tagList = pictureService.selectTag(picNo);
		model.addAttribute("tagList",tagList);
		model.addAttribute("picture",picture);
		model.addAttribute("userInfo",userInfo);
		model.addAttribute("commentList",commentList);
		model.addAttribute("commentUserList",commentUserList);
		return "picture.picinfo";
	}
	
	//Studio 페이지 이동(userNo 값 받아서)  회원 팔로잉,팔로워,업로드한 사진,팔로잉한 회원인지 확인 결과 불러오기 
	@RequestMapping("mystudio.ps")
	public String myStudio(HttpSession session, Model model, int userNo){
		
		User user = (User) session.getAttribute("user");
		
		User userInfo = userService.userInfo(userNo);
		List<Picture> picList = pictureService.myPicList(userNo);
		List<User> followerList = userService.followerUserList(userNo);
		List<User> followingList = userService.followingUserList(userNo);
		int followResult = 0;
		
		if(user.getUserNo() != userNo) {
			followResult = userService.followingConfirm(user.getUserNo(), userNo);
		}
		
		model.addAttribute("userinfo", userInfo);
		model.addAttribute("piclist", picList);
		model.addAttribute("followerlist", followerList);
		model.addAttribute("followinglist", followingList);
		model.addAttribute("followResult", followResult);
		
		return "studio.mystudio";
	}
	
	//사진 좋아요
	@RequestMapping("increaserespect.ps")
	public View pictureRespect(int picNo, int userNo, Model model) {
		int result = pictureService.respectConfirm(picNo, userNo); //좋아요 하고 있는지 확인
		System.out.println("사진 좋아요 컨트롤러");
		if(result!=0) {	 //좋아요 하고 있을때 -> 좋아요 삭제
			pictureService.deleteRespect(picNo, userNo);
			System.out.println("좋아요 취소");
		}else {	//좋아요 하지 않을때 -> 좋아요 증가
			pictureService.increaseRespect(picNo, userNo);
			System.out.println("좋아요 선택");
		}
		model.addAttribute("result",result);
		return jsonview;
	}
	
	//사진 북마크
	@RequestMapping("increasebookmark.ps")
	public View pictureBookmark(int picNo, int userNo, Model model) {
		int result = pictureService.bookmarkConfirm(picNo, userNo);
		System.out.println("사진 북마크 컨트롤러");
		if(result!=0) {	 //북마크 하고 있을때 -> 북마크 삭제
			pictureService.deleteBookmark(picNo, userNo);
			System.out.println("북마크 취소");
		}else {	//북마크 하지 않을때 -> 북마크 증가
			pictureService.increaseBookmark(picNo, userNo);
			System.out.println("북마크 선택");
		}
		model.addAttribute("result",result);
		return jsonview;
	}
	
	@RequestMapping("uploadAfter.ps")
	public String insertPicture(Picture picture,@RequestParam List<String> tag, HttpSession session) {
		User user = (User) session.getAttribute("user");
		picture.setTagContent(tag);
		pictureService.insertPicture(picture, user.getUserNo());
		System.out.println("내밑에뭐지");
		System.out.println(picture);
		System.out.println(picture.getTagContent());
		//model.addAttribute("pciture",picture);
		return "redirect:mystudio.ps?userNo="+user.getUserNo();
	}
	
}


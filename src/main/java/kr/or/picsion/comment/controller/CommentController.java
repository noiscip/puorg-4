package kr.or.picsion.comment.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.picsion.board.dto.Board;
import kr.or.picsion.board.service.BoardService;
import kr.or.picsion.comment.dto.Comment;
import kr.or.picsion.comment.service.CommentService;
import kr.or.picsion.message.dto.Message;
import kr.or.picsion.notice.service.NoticeService;
import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.picture.service.PictureService;
import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;

@Controller
@RequestMapping("/comment/")
public class CommentController {

	@Autowired
	private View jsonview;

	@Autowired
	private CommentService commentService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private PictureService pictureService;
	
	@Autowired
	private BoardService boardService;

	@RequestMapping(value = "insertreview.ps")
	public View insertComment(Comment comment, HttpSession session, Model model) {
		System.out.println("insertComment 컨트롤");
		User user = (User)session.getAttribute("user");	
		comment.setUserNo(user.getUserNo());
		comment.setTableNo(3);
		int result = commentService.insertComment(comment);
		List<User> commuserlist = commentService.commentuser(comment.getBrdNo());
		System.out.println(comment);
		
		if(result==1) {
			System.out.println("댓글쓰기 성공");
			int receiveUser = boardService.selectBoard(comment.getBrdNo()).getUserNo();
			HashMap<String, Object> noticeMap = new HashMap<String, Object>();
			
			noticeMap.put("no", comment.getBrdNo());
			noticeMap.put("addNo", comment.getCmtNo());
			noticeMap.put("sendUserNo", comment.getUserNo());
			noticeMap.put("receiveUserNo", receiveUser);
			noticeMap.put("table", "brdNo, cmtNo");
			noticeMap.put("tableNo", 4);
			
			noticeService.insertNotice(noticeMap);
		}
		else {
			System.out.println("댓글쓰기 실패");
		}
		List<Comment> comm = commentService.commentList(comment.getBrdNo());
		
		model.addAttribute("comment", comm);
		model.addAttribute("addcomment", comment);
		model.addAttribute("commuserlist", commuserlist);
		return jsonview;
	}
	//socket receive대상에게 매시지 보내주기
	@RequestMapping(value = "readreview.ps")
	public View readreview(Comment comment, Model model) {
		System.out.println("readreview 컨트롤");
		System.out.println(comment);
		Comment receivecomment = commentService.selectComment(comment.getCmtNo());
		User userinfo = userService.userInfo(receivecomment.getUserNo());
		System.out.println(userinfo);
		System.out.println(receivecomment);
		model.addAttribute("userinfo", userinfo);
		model.addAttribute("receivecomment", receivecomment);
		return jsonview;
	}
	//사진 댓글 입력
	@RequestMapping(value = "insertpiccomment.ps")
	public View insertPicComment(Comment comment, Model model, int picNo) {
		commentService.picInsertComment(comment);
		List<Comment> newcommentlist = commentService.picCommentList(picNo); //댓글 목록
		List<User> newcommentUserList = commentService.picCommentUserList(picNo); //댓글 유저 목록
		
		int receiveUser = pictureService.picInfo(comment.getPicNo()).getUserNo();
		HashMap<String, Object> noticeMap = new HashMap<String, Object>();
		
		noticeMap.put("no", comment.getPicNo());
		noticeMap.put("addNo", comment.getCmtNo());
		noticeMap.put("sendUserNo", comment.getUserNo());
		noticeMap.put("receiveUserNo", receiveUser);
		noticeMap.put("table", "picNo, cmtNo");
		noticeMap.put("tableNo", 4);
		
		noticeService.insertNotice(noticeMap);
		System.out.println("ㅇㅇㅇ");
		model.addAttribute("newcommentUserList",newcommentUserList);
		model.addAttribute("newcommentlist",newcommentlist);
		return jsonview;
	}
	
	//댓글 삭제
	@RequestMapping("deletecomment.ps")
	public View delComment(int cmtNo, Model model) {
		int result = commentService.deleteComment(cmtNo);
		model.addAttribute("result", result);
		return jsonview;
	}
	
	
}

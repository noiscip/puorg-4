package kr.or.picsion.comment.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.picsion.board.dto.Board;
import kr.or.picsion.comment.dto.Comment;
import kr.or.picsion.comment.service.CommentService;
import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;

@Controller
public class CommentController {

	@Autowired
	private View jsonview;

	@Autowired
	private CommentService commentService;
	
	@Autowired
	private UserService userService;
	

	@RequestMapping(value = "insertreview.ps")
	public View insertComment(Comment comment, HttpSession session, Model model) {
		System.out.println("insertComment 컨트롤");
		User user = (User)session.getAttribute("user");	
		List<User> commuserlist = commentService.commentuser(comment.getBrdNo());
		comment.setUserNo(user.getUserNo());
		comment.setTableNo(3);
		int result = commentService.insertComment(comment);
		System.out.println(comment);
		if(result==1) {
			System.out.println("댓글쓰기 성공");
		}
		else {
			System.out.println("댓글쓰기 실패");
		}
		List<Comment> comm = commentService.commentList(comment.getBrdNo());
		
		model.addAttribute("comment", comm);
		model.addAttribute("commuserlist", commuserlist);
		return jsonview;
	}
	
	@RequestMapping(value = "insertpiccomment.ps")
	public View insertPicComment(Comment comment, Model model, int picNo) {
		commentService.picInsertComment(comment);
		List<Comment> newcommentlist = commentService.picCommentList(picNo); //댓글 목록
		List<User> newcommentUserList = commentService.picCommentUserList(picNo); //댓글 유저 목록
		model.addAttribute("newcommentUserList",newcommentUserList);
		model.addAttribute("newcommentlist",newcommentlist);
		return jsonview;
	}
	
	
}

package kr.or.picsion.comment.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.picsion.board.service.BoardService;
import kr.or.picsion.comment.dto.Comment;
import kr.or.picsion.comment.service.CommentService;
import kr.or.picsion.notice.service.NoticeService;
import kr.or.picsion.picture.service.PictureService;
import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.comment.controller 
 * @className CommentController
 * @date 2018. 6. 4.
 */

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

	/**
	 * 날      짜 : 2018. 6. 29. 
	 * 메소드명 : insertBoardComment 
	 * 작성자명 : 김준수 
	 * 기      능 : 요청 게시판 댓글 작성
	 *
	 * @param comment
	 * @param session
	 * @param model
	 * @return View
	 */
	@RequestMapping(value = "insertreview.ps")
	@Transactional(propagation = Propagation.REQUIRED)
	public View insertBoardComment(Comment comment, HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		int result = 0;
		int receiveUser = 0;
		List<User> commuserlist = new ArrayList<User>();
		List<Comment> comm = new ArrayList<Comment>();
		try {
			comment.setUserNo(user.getUserNo());
			comment.setTableNo(3);
			result = commentService.insertComment(comment);
			commuserlist = commentService.commentuser(comment.getBrdNo());

			if (result == 1) {  //댓글 쓰기 성공
				receiveUser = boardService.selectBoard(comment.getBrdNo()).getUserNo();
				if(receiveUser != user.getUserNo()) {
						
					HashMap<String, Object> noticeMap = new HashMap<String, Object>();
		
					noticeMap.put("no", comment.getBrdNo());
					noticeMap.put("addNo", comment.getCmtNo());
					noticeMap.put("sendUserNo", comment.getUserNo());
					noticeMap.put("receiveUserNo", receiveUser);
					noticeMap.put("table", "brdNo, cmtNo");
					noticeMap.put("tableNo", 4);
		
					noticeService.insertNotice(noticeMap);
				}
			}
			comm = commentService.commentList(comment.getBrdNo());

			
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("result", result);
		model.addAttribute("comment", comm);
		model.addAttribute("addcomment", comment);
		model.addAttribute("commuserlist", commuserlist);
		return jsonview;
	}

	/**
	 * 날      짜 : 2018. 6. 29. 
	 * 메소드명 : readReview 
	 * 작성자명 : 김준수 
	 * 기      능 : socket receive대상에게 메시지 보내주기
	 *
	 * @param comment
	 * @param model
	 * @return View
	 */
	@RequestMapping(value = "readreview.ps")
	public View readReview(Comment comment, Model model) {
		Comment receivecomment = commentService.selectComment(comment.getCmtNo());
		User userinfo = userService.userInfo(receivecomment.getUserNo());
		model.addAttribute("userinfo", userinfo);
		model.addAttribute("receivecomment", receivecomment);
		return jsonview;
	}

	/**
	 * 날      짜 : 2018. 6. 29. 
	 * 메소드명 : insertPicComment 
	 * 작성자명 : 정도혁 
	 * 기      능 : 사진 댓글 입력
	 *
	 * @param comment
	 * @param model
	 * @param picNo
	 * @return View
	 */
	@RequestMapping(value = "insertpiccomment.ps")
	@Transactional(propagation = Propagation.REQUIRED)
	public View insertPicComment(Comment comment,HttpSession session, Model model, int picNo) {
		User user = (User) session.getAttribute("user");
		List<Comment> newcommentlist = new ArrayList<Comment>();
		List<User> newcommentUserList = new ArrayList<User>();
		int receiveUser = 0;
		int errorCheck = 0;
		try {
			errorCheck = commentService.picInsertComment(comment);
			newcommentlist = commentService.picCommentList(picNo); // 댓글 목록
			newcommentUserList = commentService.picCommentUserList(picNo); // 댓글 유저 목록

			receiveUser = pictureService.picInfo(user.getUserNo(), comment.getPicNo()).getUserNo();
			if(receiveUser != user.getUserNo()) {
				HashMap<String, Object> noticeMap = new HashMap<String, Object>();
				
				noticeMap.put("no", comment.getPicNo());
				noticeMap.put("addNo", comment.getCmtNo());
				noticeMap.put("sendUserNo", comment.getUserNo());
				noticeMap.put("receiveUserNo", receiveUser);
				noticeMap.put("table", "picNo, cmtNo");
				noticeMap.put("tableNo", 4);
				
				noticeService.insertNotice(noticeMap);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("errorCheck",errorCheck);
		model.addAttribute("newcommentUserList", newcommentUserList);
		model.addAttribute("newcommentlist", newcommentlist);
		
		return jsonview;
	}

	/** 
	 * 날      짜 : 2018. 6. 29. 
	 * 메소드명 : delComment 
	 * 작성자명 : 김준수, 정도혁 
	 * 기      능 : 댓글 삭제
	 *
	 * @param cmtNo
	 * @param model
	 * @return View
	 */
	@RequestMapping("deletecomment.ps")
	@Transactional(propagation = Propagation.REQUIRED)
	public View delComment(int cmtNo, Model model) {
		int result = 0;
		try {
			result = commentService.deleteComment(cmtNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("result", result);
		return jsonview;
	}

}

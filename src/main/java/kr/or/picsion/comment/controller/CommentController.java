package kr.or.picsion.comment.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	 * 날 짜 : 2018. 6. 29. 
	 * 메소드명 : insertBoardComment 
	 * 작성자명 : 김준수 
	 * 기 능 : 요청 게시판 댓글 작성
	 *
	 * @param comment
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "insertreview.ps")
	public View insertBoardComment(Comment comment, HttpSession session, Model model) {
		System.out.println("insertBoardComment 컨트롤");
		User user = (User) session.getAttribute("user");
		comment.setUserNo(user.getUserNo());
		comment.setTableNo(3);
		int result = commentService.insertComment(comment);
		List<User> commuserlist = commentService.commentuser(comment.getBrdNo());
		System.out.println(comment);

		if (result == 1) {
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
		} else {
			System.out.println("댓글쓰기 실패");
		}
		List<Comment> comm = commentService.commentList(comment.getBrdNo());

		model.addAttribute("comment", comm);
		model.addAttribute("addcomment", comment);
		model.addAttribute("commuserlist", commuserlist);
		return jsonview;
	}

	/**
	 * 날 짜 : 2018. 6. 29. 
	 * 메소드명 : readreview 
	 * 작성자명 : 김준수 
	 * 기 능 : socket receive대상에게 매시지 보내주기
	 *
	 * @param comment
	 * @param model
	 * @return
	 */
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

	/**
	 * 날 짜 : 2018. 6. 29. 
	 * 메소드명 : insertPicComment 
	 * 작성자명 : 정도혁 
	 * 기 능 : 사진 댓글 입력
	 *
	 * @param comment
	 * @param model
	 * @param picNo
	 * @return View
	 */
	@RequestMapping(value = "insertpiccomment.ps")
	public View insertPicComment(Comment comment,HttpSession session, Model model, int picNo) {
		User user = (User) session.getAttribute("user");
		commentService.picInsertComment(comment);
		List<Comment> newcommentlist = commentService.picCommentList(picNo); // 댓글 목록
		List<User> newcommentUserList = commentService.picCommentUserList(picNo); // 댓글 유저 목록

		int receiveUser = pictureService.picInfo(user.getUserNo(), comment.getPicNo()).getUserNo();
		HashMap<String, Object> noticeMap = new HashMap<String, Object>();

		noticeMap.put("no", comment.getPicNo());
		noticeMap.put("addNo", comment.getCmtNo());
		noticeMap.put("sendUserNo", comment.getUserNo());
		noticeMap.put("receiveUserNo", receiveUser);
		noticeMap.put("table", "picNo, cmtNo");
		noticeMap.put("tableNo", 4);

		noticeService.insertNotice(noticeMap);
		model.addAttribute("newcommentUserList", newcommentUserList);
		model.addAttribute("newcommentlist", newcommentlist);
		return jsonview;
	}

	/**
	 * 날 짜 : 2018. 6. 29. 
	 * 메소드명 : delComment 
	 * 작성자명 : 김준수, 정도혁 
	 * 기 능 : 댓글 삭제
	 *
	 * @param cmtNo
	 * @param model
	 * @return
	 */
	@RequestMapping("deletecomment.ps")
	public View delComment(int cmtNo, Model model) {
		int result = commentService.deleteComment(cmtNo);
		model.addAttribute("result", result);
		return jsonview;
	}

}

/**
 * 
 */
package kr.or.picsion.notice.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.picsion.board.dto.Board;
import kr.or.picsion.board.service.BoardService;
import kr.or.picsion.comment.dto.Comment;
import kr.or.picsion.comment.service.CommentService;
import kr.or.picsion.message.dto.Message;
import kr.or.picsion.notice.dao.NoticeDao;
import kr.or.picsion.notice.dto.Notice;
import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.notice.service 
 * @className NoticeService
 * @date 2018. 6. 14.
 */

@Service
public class NoticeService {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private CommentService commentService;
	
	public HashMap<Integer, Object> noticeList(int userNo){
		NoticeDao noticeDao = sqlSession.getMapper(NoticeDao.class);
		
		List<Notice> noticeList = noticeDao.noticeList(userNo);
		HashMap<Integer, Object> map = new HashMap<>();
		int i = 0;
		for (Notice no : noticeList) {
			List<Object> obj = new ArrayList<>();
			User sendUserNo = userService.userInfo(no.getSendUserNo());
			obj.add(no);
			obj.add(sendUserNo);
			
			System.out.println(no.getTableNo());
			int tableNo = no.getTableNo();
			
			if(tableNo == 2) {
				Picture picture;
			}else if(tableNo == 3) {
				Board board = boardService.selectBoard(no.getBrdNo());
				obj.add(board);
			}else if(tableNo == 4) {
				Comment comment = commentService.selectComment(no.getCmtNo());
				if(comment.getTableNo() == 2) {
					
				}else {
					
				}
				
				
			}else if(tableNo == 5) {
				System.out.println("여기 올리가 없는데...");
			}
			map.put(i, obj);
			i++;
		}
		
		return map;
	}
	
	public int readCheckCount(int userNo) {
		
			NoticeDao noticeDao = sqlSession.getMapper(NoticeDao.class);
			
		return noticeDao.readCheckCount(userNo);
	}
}

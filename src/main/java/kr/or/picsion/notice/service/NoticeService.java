/**
 * 
 */
package kr.or.picsion.notice.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.picsion.board.service.BoardService;
import kr.or.picsion.comment.dto.Comment;
import kr.or.picsion.comment.service.CommentService;
import kr.or.picsion.notice.dao.NoticeDao;
import kr.or.picsion.notice.dto.Notice;
import kr.or.picsion.picture.service.PictureService;
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

	@Autowired
	private PictureService pictureService;
	
	
	public void insertNotice(Map<String, Object> noticeMap) {
		NoticeDao noticeDao = sqlSession.getMapper(NoticeDao.class);
		noticeDao.insertNotice(noticeMap);
	}

	public HashMap<Integer, Object> noticeList(int userNo) {
		NoticeDao noticeDao = sqlSession.getMapper(NoticeDao.class);

		List<Notice> noticeList = noticeDao.noticeList(userNo);
		HashMap<Integer, Object> map = new HashMap<>();
		
		Map<String,Notice> overlap = new HashMap<>();
		int i = 0;
		for (Notice no : noticeList) {
			String key = no.getTableNo() +","+no.getSendUserNo()+","+no.getBrdNo()+","+no.getPicNo();
			
			if(overlap.get(key) == null ) overlap.put(key, no);
			else continue;
			
			List<Object> obj = new ArrayList<>();
			obj.add(no);
			obj.add(userService.userInfo(no.getSendUserNo()));

			int tableNo = no.getTableNo();
			if (tableNo == 3) {
				obj.add(boardService.selectBoard(no.getBrdNo()));
			} else if (tableNo == 4) {
				Comment comment = commentService.selectComment(no.getCmtNo());
				obj.add(comment);
				String title ="";
				if (comment.getTableNo() == 2) {
					title = pictureService.picInfo(comment.getPicNo()).getPicTitle();
				} else {
					title = boardService.selectBoard(comment.getBrdNo()).getBrdTitle();
				}
				obj.add(title);
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
	
	public int readCheck(Notice notice) {
		NoticeDao noticeDao = sqlSession.getMapper(NoticeDao.class);
		return noticeDao.readCheck(notice);
	}
}

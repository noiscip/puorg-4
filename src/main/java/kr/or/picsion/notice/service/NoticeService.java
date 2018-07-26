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
	
	
	/**
	 * 날      짜 : 2018. 6. 25.
	 * 메소드명 : insertNotice
	 * 작성자명 : 아윤근
	 * 기      능 : 알림 대상 객체가 등록 될 경우 알림 등록
	 *
	 * @param noticeMap
	*/
	public void insertNotice(Map<String, Object> noticeMap) {
		NoticeDao noticeDao = sqlSession.getMapper(NoticeDao.class);
		noticeDao.insertNotice(noticeMap);
	}

	/**
	 * 날      짜 : 2018. 6. 19.
	 * 메소드명 : noticeList
	 * 작성자명 : 아윤근
	 * 기      능 : 알림 정보를 종류에 따라 나눈 후, 해당 정보의 데이터를 map에 담아서 리턴
	 *
	 * @param userNo
	 * @return HashMap<Integer, Object>
	*/
	public Map<Integer, Object> noticeList(int userNo) {
		NoticeDao noticeDao = sqlSession.getMapper(NoticeDao.class);

		List<Notice> noticeList = noticeDao.noticeList(userNo);
		HashMap<Integer, Object> map = new HashMap<>();
		
		Map<String,Notice> overlap = new HashMap<>();
		int i = 0;
		for (Notice no : noticeList) {
			String key = no.getTableNo() +","+no.getSendUserNo()+","+no.getBrdNo()+","+no.getPicNo();
			
			if(overlap.get(key) == null ) {
				overlap.put(key, no);
			}else {
				continue;
			}
			
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
					title = pictureService.picInfo(userNo, comment.getPicNo()).getPicTitle();
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

	/**
	 * 날      짜 : 2018. 6. 27.
	 * 메소드명 : readCheckCount
	 * 작성자명 : 아윤근
	 * 기      능 : 읽지 않은 알림 갯수 확인
	 *
	 * @param userNo
	 * @return Integer
	*/
	public int readCheckCount(int userNo) {

		NoticeDao noticeDao = sqlSession.getMapper(NoticeDao.class);

		List<Notice> noticeList = noticeDao.noticeList(userNo);
		
		Map<String,Notice> overlap = new HashMap<>();
		int i = 0;
		for (Notice no : noticeList) {
			String key = no.getTableNo() +","+no.getSendUserNo()+","+no.getBrdNo()+","+no.getPicNo();
			
			if(overlap.get(key) == null ) {
				overlap.put(key, no);
				i++;
			}
		}
		return i;
	}
	
	/**
	 * 날      짜 : 2018. 6. 27.
	 * 메소드명 : readCheck
	 * 작성자명 : 아윤근
	 * 기      능 : 읽은 알림 읽음 표시
	 *
	 * @param notice
	 * @return int
	*/
	public int readCheck(Notice notice) {
		NoticeDao noticeDao = sqlSession.getMapper(NoticeDao.class);
		return noticeDao.readCheck(notice);
	}
}

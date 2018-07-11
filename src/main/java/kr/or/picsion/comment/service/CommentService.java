package kr.or.picsion.comment.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.picsion.comment.dao.CommentDao;
import kr.or.picsion.comment.dto.Comment;
import kr.or.picsion.user.dto.User;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.comment.service 
 * @className CommentService
 * @date 2018. 6. 4.
 */

@Service
public class CommentService {

	@Autowired
	private SqlSession sqlSession;

	/**
	 * 날      짜 : 2018. 6. 29. 
	 * 메소드명 : commentList 
	 * 작성자명 : 김준수 
	 * 기      능 : 댓글 목록 서비스
	 *
	 * @param brdNo
	 * @return List<Comment>
	 */
	public List<Comment> commentList(int brdNo) {
		CommentDao commentdao = sqlSession.getMapper(CommentDao.class);

		return commentdao.commentList(brdNo);
	}

	/**
	 * 날      짜 : 2018. 6. 29. 
	 * 메소드명 : commentuser 
	 * 작성자명 : 김준수 
	 * 기      능 : 댓글 작성자 유저 정보 서비스
	 *
	 * @param brdNo
	 * @return List<User>
	 */
	public List<User> commentuser(int brdNo) {
		CommentDao commentdao = sqlSession.getMapper(CommentDao.class);

		return commentdao.commentuser(brdNo);
	}

	/**
	 * 날      짜 : 2018. 6. 29. 
	 * 메소드명 : insertComment 
	 * 작성자명 : 김준수 
	 * 기      능 : 요청게시판 댓글 쓰기 서비스
	 *
	 * @param comment
	 * @return int
	 */
	public int insertComment(Comment comment) {

		CommentDao commentdao = sqlSession.getMapper(CommentDao.class);
		int result = commentdao.insertComment(comment);
		return result;
	}

	/**
	 * 날      짜 : 2018. 6. 29. 
	 * 메소드명 : deleteComment 
	 * 작성자명 : 김준수 
	 * 기      능 : 댓글 전부 삭제 서비스
	 *
	 * @param cmtNo
	 * @return int
	 */
	public int deleteComment(int cmtNo) {
		CommentDao commentdao = sqlSession.getMapper(CommentDao.class);
		int result = commentdao.deleteComment(cmtNo);
		return result;
	}

	/**
	 * 날      짜 : 2018. 6. 29. 
	 * 메소드명 : deleteAllComment 
	 * 작성자명 : 김준수 
	 * 기      능 : 작업 수락시 해당 게시물 댓글 리셋
	 *
	 * @param brdNo
	 * @return int
	 */
	public int deleteAllComment(int brdNo) {
		CommentDao commentdao = sqlSession.getMapper(CommentDao.class);
		int result = commentdao.deleteAllComment(brdNo);
		return result;
	}

	/**
	 * 날      짜 : 2018. 6. 29. 
	 * 메소드명 : picCommentList 
	 * 작성자명 : 정도혁 
	 * 기      능 : 사진 댓글 목록 서비스
	 *
	 * @param picNo
	 * @return List<Comment>
	 */
	public List<Comment> picCommentList(int picNo) {
		CommentDao commentdao = sqlSession.getMapper(CommentDao.class);
		return commentdao.picCommentList(picNo);
	}

	/**
	 * 날      짜 : 2018. 6. 29. 
	 * 메소드명 : picCommentUserList 
	 * 작성자명 : 정도혁 
	 * 기      능 : 사진 댓글 작성자 리스트
	 *
	 * @param picNo
	 * @return List<User>
	 */
	public List<User> picCommentUserList(int picNo) {
		CommentDao commentdao = sqlSession.getMapper(CommentDao.class);
		return commentdao.picCommentUserList(picNo);
	}

	/**
	 * 날      짜 : 2018. 6. 29. 
	 * 메소드명 : picInsertComment 
	 * 작성자명 : 정도혁 
	 * 기      능 : 사진 댓글 쓰기 서비스
	 *
	 * @param comment
	 * @return int
	 */
	public int picInsertComment(Comment comment) {
		CommentDao commentdao = sqlSession.getMapper(CommentDao.class);
		int result = commentdao.picInsertComment(comment);
		return result;
	}

	/**
	 * 날      짜 : 2018. 6. 29. 
	 * 메소드명 : selectComment 
	 * 작성자명 : 김준수, 정도혁 
	 * 기      능 : 댓글 번호에 해당하는 댓글 찾기 서비스
	 *
	 * @param cmtNo
	 * @return Comment
	 */
	public Comment selectComment(int cmtNo) {
		CommentDao commentdao = sqlSession.getMapper(CommentDao.class);
		return commentdao.selectComment(cmtNo);
	}

}

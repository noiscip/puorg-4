package kr.or.picsion.comment.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.picsion.board.dao.BoardDao;
import kr.or.picsion.board.dto.Board;
import kr.or.picsion.comment.dao.CommentDao;
import kr.or.picsion.comment.dto.Comment;
import kr.or.picsion.user.dto.User;

@Service
public class CommentService {

	@Autowired
	private SqlSession sqlSession;

	

	// 댓글 목록 서비스
	public List<Comment> commentList(int brdNo) {
		CommentDao commentdao = sqlSession.getMapper(CommentDao.class);
		System.out.println("commentList 서비스 ");
			
		return commentdao.commentList(brdNo);	
	}

	// 댓글 작성자 유저 정보 서비스
		public List<User> commentuser(int brdNo) {
			CommentDao commentdao = sqlSession.getMapper(CommentDao.class);
			System.out.println("commentuser 서비스 ");
				
			return commentdao.commentuser(brdNo);	
		}
	
	
	
	// 댓글 쓰기 서비스
	public int insertComment(Comment comment) {
		
		CommentDao commentdao = sqlSession.getMapper(CommentDao.class);
		int result = commentdao.insertComment(comment);
		System.out.println("insertComment 서비스 ");		
		return result;
	}
	// 댓글 전부 삭제 서비스
		public int deleteAllComment(int brdNo) {
			System.out.println("deleteComment 서비스 ");			
			CommentDao commentdao = sqlSession.getMapper(CommentDao.class);
			int result = commentdao.deleteAllComment(brdNo);
			return result;
		}
	
	// 사진 댓글 목록 서비스
	public List<Comment> picCommentList(int picNo){
		CommentDao commentdao = sqlSession.getMapper(CommentDao.class);
		return commentdao.picCommentList(picNo);
	}
	
	// 사진 댓글 쓰기 서비스
	public int picInsertComment(Comment comment) {
		CommentDao commentdao = sqlSession.getMapper(CommentDao.class);
		int result = commentdao.picInsertComment(comment);
		return result;
	}
	
	public Comment selectComment(int cmtNo) {
		CommentDao commentdao = sqlSession.getMapper(CommentDao.class);
		return commentdao.selectComment(cmtNo);
	}
	
}

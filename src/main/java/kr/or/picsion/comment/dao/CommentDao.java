package kr.or.picsion.comment.dao;

import java.util.List;

import kr.or.picsion.comment.dto.Comment;
import kr.or.picsion.user.dto.User;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.comment.dao 
 * @className CommentDao
 * @date 2018. 6. 4.
 */

public interface CommentDao {
	
	public int insertComment(Comment comment);
	public int updateComment(Comment comment);
	public List<Comment> commentList(int brdNo);
	public List<User> commentuser(int brdNo); // 요청글에 해당하는 댓글 유저 정보
	public List<Comment> picCommentList(int picNo); //사진에 대한 댓글리스트
	public List<User> picCommentUserList(int picNo); //사진에 대한 댓글 유저리스트
	public int picInsertComment(Comment comment);	//사진에 댓글 저장
	public int deleteComment(int cmtNo);			//댓글 삭제
	public int deleteAllComment(int brdNo);
	public Comment selectComment(int cmtNo);
}

package kr.or.picsion.comment.dao;

import java.util.List;

import kr.or.picsion.comment.dto.Comment;

public interface CommentDao {
	
	public int insertComment(Comment comment);
	public int updateComment(Comment comment);
	public List<Comment> commentList(int brdNo);
	public List<Comment> picCommentList(int picNo); //사진에 대한 댓글리스트
	public int picInsertComment(Comment comment);	//사진에 댓글 저장
	public int deleteComment(int cmtNo);
<<<<<<< HEAD
	public int deleteAllComment(int brdNo);
=======
	public Comment selectComment(int cmtNo);
>>>>>>> e23c27b06eae10de720c6e0f24aa78e3433788cc
}

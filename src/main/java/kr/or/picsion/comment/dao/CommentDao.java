package kr.or.picsion.comment.dao;

import java.util.List;

import kr.or.picsion.comment.dto.Comment;

public interface CommentDao {
	
	public int insertComment(Comment comment);
	public int updateComment(Comment comment);
	public List<Comment> commentList(int brdNo);
	public int deleteComment(int cmtNo);
}

package kr.or.picsion.user.dao;

import java.util.List;

import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.user.dto.User;

public interface UserDao {

	public List<User> userList();
	public int registerUser(User user);
	public int updateUser(User user);
	public int deleteUser(int userNo);
	public User selectUser(String userId);
	public List<Picture> bookmarkPicList(int userNo);
	public List<Picture> respectPicList(int userNo);
	public List<User> followingUserList(int userNo);
	public List<User> followerUserList(int userNo);
	
	//////////////////////////
	List<User> getPicsionList();
}

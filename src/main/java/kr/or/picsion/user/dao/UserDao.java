package kr.or.picsion.user.dao;

import java.util.List;

import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.user.dto.User;

public interface UserDao {

	public List<User> userList();
	public int registerUser(User user);
	public int insertProfile(int userNo);
	public int updateUser(User user);
	public int deleteUser(int userNo);
	public User selectUser(String userId);
	public User selectUserNo(int userNo);		//userNo으로 회원 정보 검색
	public User selectProfile(int userNo);		//유저의 프로필 정보 검색
	public List<Picture> bookmarkPicList(int userNo);	//내가 즐겨찾기한 사진의 리스트
	public List<Picture> respectPicList(int userNo);	
	public List<User> followingUserList(int userNo);	//내가 따르는 회원 리스트 (팔로잉 회원들)
	public List<User> followerUserList(int userNo);		//나를 따르는 회원 리스트 (팔로워 회원들)
	public int followingConfirm(int userNo, int followingUserNo);	//팔로잉하고 있는지 확인
	public List<Picture> followingUserPictureList(int userNo);	//내가 따르는 회원 최신 사진 리스트
	public List<User> followingUserPictureOwnerList(int userNo);  //최신 사진 리스트 주인
 	public void insertFollow(int userNo, int followingUserNo);		//팔로잉테이블에   insert
	public void deleteFollow(int userNo, int followingUserNo);		//팔로잉테이블에서 delete
	
	//////////////////////////
	List<User> getPicsionList();
}

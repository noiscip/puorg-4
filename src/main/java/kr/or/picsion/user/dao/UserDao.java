package kr.or.picsion.user.dao;

import java.util.List;

import kr.or.picsion.blame.dto.Blame;
import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.user.dto.User;

public interface UserDao {

	public List<User> userList();
	public int registerUser(User user);
	public int insertProfile(int userNo);
	public int updateUser(User user);
	public int deleteUser(int userNo);
	public User selectUser(String user, String userId);		//파라미터 값에따라 유동적으로 회원의 정보 검색
	
	
	public User selectUserProfile(int userNo);
	public User selectUserNo(int userNo);		//userNo으로 회원 정보 검색
	public User selectProfile(int userNo);		//유저의 프로필 정보 검색
	public List<Picture> bookmarkPicList(int userNo);	//내가 북마크한 사진 리스트
	public List<Picture> respectPicList(int userNo);	//내가 좋아요한 사진 리스트
	public List<User> followingUserList(int userNo);	//내가 따르는 회원 리스트 (팔로잉 회원들)
	public List<User> followerUserList(int userNo);		//나를 따르는 회원 리스트 (팔로워 회원들)
	public int followingConfirm(int userNo, int followingUserNo);	//팔로잉하고 있는지 확인
	public List<Picture> followingUserPictureList(int userNo);	//내가 따르는 회원 최신 사진 리스트
	public List<User> followingUserPictureOwnerList(int userNo);  //최신 사진 리스트 주인
 	public void insertFollow(int userNo, int followingUserNo);		//팔로잉테이블에   insert
	public void deleteFollow(int userNo, int followingUserNo);		//팔로잉테이블에서 delete
	public int insertAccount(int userNo, String accountNo, String portalSite);    //회원 계정 연동
	public int updateAccount(int userNo, String accountNo, String portalSite);	 //이미 다른 포털의 계정이 등록되어 있다면 update
	public User selectAccountNo(String accountNo, String portalSite);
	public User selectAccountUserNo(int userNo);

	
	//////////////////////////
	List<User> getPicsionList();
}

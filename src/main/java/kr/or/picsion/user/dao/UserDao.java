package kr.or.picsion.user.dao;

import java.util.List;

import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.user.dto.User;

public interface UserDao {

	public List<User> userList();
	public int registerUser(User user);
	public int insertProfile(int userNo);
	public void updateUser(User user);		//user 정보 변경
	public void updateUserPr(User user);		//프로필 자기소개 수정
	public int deleteUser(int userNo);
	public User selectUser(String user, Object userId);		//파라미터 값에따라 유동적으로 회원의 정보 검색
	public User selectUserProfile(int userNo);
	public List<Picture> bookmarkPicList(int userNo);	//내가 북마크한 사진 리스트
	public List<User> bookmarkPicUserList(int userNo);
	public List<User> followingUserList(int userNo);	//내가 따르는 회원 리스트 (팔로잉 회원들)
	public List<User> followerUserList(int userNo);		//나를 따르는 회원 리스트 (팔로워 회원들)
	public int followingConfirm(int userNo, int followingUserNo);	//팔로잉하고 있는지 확인
	public List<Picture> followingUserPictureList(int userNo);	//내가 따르는 회원 최신 사진 리스트
	public List<User> followingUserPictureOwnerList(int userNo);  //최신 사진 리스트 주인
 	public void insertFollow(int userNo, int followingUserNo);		//팔로잉테이블에   insert
	public void deleteFollow(int userNo, int followingUserNo);		//팔로잉테이블에서 delete
	public int insertAccount(int userNo);    //회원 계정 연동
	public int updateAccount(int userNo, String accountNo, String portalSite);	 //이미 다른 포털의 계정이 등록되어 있다면 update
	public User selectAccountNo(String accountNo, String portalSite);
	public int updateRole(int userNo); //계정 연동 되었을 경우 권한 업데이트
	public int pointCharge(int point, int userNo);	//캐시 충전
	
}

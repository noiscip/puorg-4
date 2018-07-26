package kr.or.picsion.user.dao;

import java.util.List;

import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.user.dto.User;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.user.dao 
 * @className UserDao
 * @date 2018. 6. 4.
 */

public interface UserDao {

	public List<User> userList();						//유저 리스트
	public int registerUser(User user);					//유저 회원가입
	public int insertProfile(int userNo);				//프로필 생성
	public void updateUser(User user);					//유저 정보 변경
	public void updateUserPr(User user);				//프로필 자기소개 수정
	public void updateUserPic(User user);				//유저 프로필 사진 변경
	public int deleteUser(int userNo);					//유저 삭제
	public User selectUser(String user, Object userId); //파라미터 값에따라 유동적으로 회원의 정보 검색
	public User selectUserProfile(int userNo);			//유저 프로필
	public List<Picture> bookmarkPicList(int userNo, int page, int endpage);	//내가 북마크한 사진 리스트
	public List<User> bookmarkPicUserList(int userNo, int page, int endpage);  //내가 북마크한 사진의 유저 리스트
	public List<User> followingUserList(int userNo);	//내가 따르는 유저 리스트 (팔로잉 회원들)		>>
	public List<User> followingUserPaging(int userNo, int start, int rowSize);	//내가 따르는 유저 리스트 (팔로잉 회원들/페이징)
	public int getFollowingCount(int userNo);			//내가 따르는 유저의 총 명수
	public List<User> followerUserList(int userNo);		//나를 따르는 유저 리스트 (팔로워 회원들)		>>
	public List<User> followerUserPaging(int userNo, int start, int rowSize);	//내가 따르는 유저 리스트 (팔로잉 회원들/페이징)
	public int getFollowerCount(int userNo);			//나를 따르는 유저의 총 명수
	public int followingConfirm(int userNo, int followingUserNo);	//팔로잉하고 있는지 확인
	public List<Picture> followingUserPictureList(int userNo, int page, int endpage);		//내가 팔로잉한 유저 최신 사진 리스트
 	public void insertFollow(int userNo, int followingUserNo);		//팔로잉테이블에   insert
	public void deleteFollow(int userNo, int followingUserNo);		//팔로잉테이블에서 delete
	public int insertAccount(int userNo);    						//회원 계정 연동
	public int updateAccount(int userNo, String accountNo, String portalSite);	//이미 다른 포털의 계정이 등록되어 있다면 update
	public User selectAccountNo(String accountNo, String portalSite);      		//계정 연동 확인
	public int updateRole(int userNo); 				//계정 연동 되었을 경우 권한 업데이트
	public int pointCharge(int point, int userNo);	//캐시 충전
	public List<User> bestUploader();				//최근 7일간 최다 업로더 4명
	public List<User> mostFollowingUser(); 		    //팔로워가 많은 순서 유저 리스트
	 
}

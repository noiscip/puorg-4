package kr.or.picsion.user.service;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.user.dao.UserDao;
import kr.or.picsion.user.dto.User;

@Service
public class UserService {

	@Autowired
	private SqlSession sqlSession;
	
	/**
	* 날      짜 : 2018. 6. 8.
	* 메소드명 : register
	* 작성자명 : 아윤근
	* 기      능 : 회원가입
	*
	* @param user
	*/
	public void register(User user) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		userDao.registerUser(user);
		userDao.insertProfile(user.getUserNo());
		userDao.insertAccount(user.getUserNo());
	}
	
	/**
	* 날      짜 : 2018. 6. 8.
	* 메소드명 : login
	* 작성자명 : 아윤근
	* 기      능 : 로그인
	*
	* @param user
	* @return User
	*/
	public User login(User user) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		User loginUser = userDao.selectUser("userId", user.getUserId());
		if(loginUser == null || !user.getPwd().equals(loginUser.getPwd())) {
			loginUser = null;
		}
		return loginUser;
	}
	
	/**
	* 날      짜 : 2018. 6. 8.
	* 메소드명 : userList
	* 작성자명 : 김보경
	* 기      능 : 회원 리스트
	*
	* @return List<User>
	*/
	public List<User> userList(){
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		List<User> userList = userDao.userList();
		return userList;
	}
	
	/**
	* 날      짜 : 2018. 6. 8.
	* 메소드명 : userInfo
	* 작성자명 : 아윤근
	* 기      능 : userNo로 회원정보 검색
	*
	* @param userNo
	* @return User
	*/
	public User userInfo(int userNo) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		User userInfo = userDao.selectUser("u.userNo",userNo);
		return userInfo;
	}
	
	/**
	* 날      짜 : 2018. 6. 8.
	* 메소드명 : searchUserId
	* 작성자명 : 아윤근
	* 기      능 : userId로 회원정보 검색
	*
	* @param userId
	* @return User
	*/
	public User searchUserId(String userId) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		User user = userDao.selectUser("userId", userId);
		return user;
	}
	
	/**
	* 날      짜 : 2018. 6. 11.
	* 메소드명 : followingUserPicList
	* 작성자명 : 정도혁
	* 기      능 : 내가 팔로잉한 사람의 최신 사진 리스트
	*
	* @param userNo
	* @return List<Picture>
	*/
	public List<Picture> followingUserPicList(int userNo, int page, int endpage) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		List<Picture> followingUserPicList = userDao.followingUserPictureList(userNo, page, endpage);
		return followingUserPicList;
	}

		
	/**
	* 날      짜 : 2018. 6. 13.
	* 메소드명 : followerUserList
	* 작성자명 : 박주원
	* 기      능 : 유저의 팔로워 리스트 
	*
	* @param userNo
	* @return List<User>
	*/
	public List<User> followerUserList(int userNo){
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		List<User> followList = userDao.followerUserList(userNo);
		return followList;
	}
		
	/**
	* 날      짜 : 2018. 6. 13.
	* 메소드명 : followingUserList
	* 작성자명 : 박주원
	* 기      능 : 유저의 팔로잉 리스트
	*
	* @param userNo
	* @return List<User>
	*/
	public List<User> followingUserList(int userNo){
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		List<User> followingList = userDao.followingUserList(userNo);
		return followingList;
	}
	
	/**
	* 날      짜 : 2018. 7. 5.
	* 메소드명 : followingUserPaging
	* 작성자명 : 박주원
	* 기      능 : 유저의 팔로잉 리스트(페이징)
	*
	* @param userNo
	* @param start
	* @param rowSize
	* @return List<User>
	*/
	public List<User> followingUserPaging(int userNo, int start, int rowSize){
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		List<User> followingList = userDao.followingUserPaging(userNo, start, rowSize);
		
		return followingList;
	}
	
	/**
	* 날      짜 : 2018. 7. 5.
	* 메소드명 : getFollowingCount
	* 작성자명 : 박주원
	* 기      능 : 유저의 팔로잉 총 명수
	*
	* @param userNo
	* @return Integer
	*/
	public int getFollowingCount(int userNo) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		int result = userDao.getFollowingCount(userNo);
		
		return result;
	}
	
	/**
	* 날      짜 : 2018. 7. 7.
	* 메소드명 : followerUserPaging
	* 작성자명 : 박주원
	* 기      능 : 유저의 팔로워 리스트 (페이징)
	*
	* @param userNo
	* @param start
	* @param rowSize
	* @return List<User>
	*/
	public List<User> followerUserPaging(int userNo, int start, int rowSize){
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		List<User> followerList = userDao.followerUserPaging(userNo, start, rowSize);
		
		return followerList;
	}
	
	/**
	* 날      짜 : 2018. 7. 7.
	* 메소드명 : getFollowerCount
	* 작성자명 : 박주원
	* 기      능 : 유저의 팔로워 총 명수
	*
	* @param userNo
	* @return Integer
	*/
	public int getFollowerCount(int userNo) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		int result = userDao.getFollowerCount(userNo);
		
		return result;
	}
	
	/**
	* 날      짜 : 2018. 6. 13.
	* 메소드명 : followingConfirm
	* 작성자명 : 박주원
	* 기      능 : 회원이 팔로잉 하고 있는지 확인
	*
	* @param userNo
	* @param followingUserNo
	* @return Integer
	*/
	public int followingConfirm(int userNo, int followingUserNo) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		int result = userDao.followingConfirm(userNo, followingUserNo);
		return result;
	}
	
	/**
	* 날      짜 : 2018. 6. 13.
	* 메소드명 : bookmarkPicList
	* 작성자명 : 박주원, 정도혁
	* 기      능 : 유저가 북마크한 사진 리스트
	*
	* @param userNo
	* @return List<Picture>
	*/
	public List<Picture> bookmarkPicList(int userNo, int page, int endpage){
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		List<Picture> bookmarkPicList = userDao.bookmarkPicList(userNo, page, endpage);
		return bookmarkPicList;
	}
	
	/**
	* 날      짜 : 2018. 6. 13.
	* 메소드명 : bookmarkPicUserList
	* 작성자명 : 정도혁
	* 기      능 : 유저가 북마크한 사진의 주인 리스트
	*
	* @param userNo
	* @return List<User>
	*/
	public List<User> bookmarkPicUserList(int userNo, int page, int endpage){
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		List<User> bookmarkPicUserList =userDao.bookmarkPicUserList(userNo, page, endpage);
		return bookmarkPicUserList;
	}
	
	/**
	* 날      짜 : 2018. 6. 14.
	* 메소드명 : deleteFollow
	* 작성자명 : 박주원
	* 기      능 : 팔로잉 취소
	*
	* @param userNo
	* @param followingUserNo
	*/
	public void deleteFollow(int userNo, int followingUserNo) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		userDao.deleteFollow(userNo, followingUserNo);
	}
	
	/**
	* 날      짜 : 2018. 6. 14.
	* 메소드명 : insertFollow
	* 작성자명 : 박주원
	* 기      능 : 팔로잉 생성
	*
	* @param userNo
	* @param followingUserNo
	*/
	public void insertFollow(int userNo, int followingUserNo) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		userDao.insertFollow(userNo, followingUserNo);
	}
	
	/**
	* 날      짜 : 2018. 6. 18.
	* 메소드명 : userDel
	* 작성자명 : 김보경
	* 기      능 : 유저 삭제
	*
	* @param userNo
	* @return Integer
	*/
	public int userDel(int userNo) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		int result = userDao.deleteUser(userNo);
		return result;
	}
	
	/**
	* 날      짜 : 2018. 6. 18.
	* 메소드명 : updateAccountNo
	* 작성자명 : 아윤근
	* 기      능 : 회원 아이디 연동 정보 update
	*
	* @param userNo
	* @param accountNo
	* @param portalSite
	* @return Integer
	*/
	public int updateAccountNo(int userNo, String accountNo, String portalSite) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		return userDao.updateAccount(userNo,accountNo,portalSite);
	}
	
	/**
	* 날      짜 : 2018. 6. 18.
	* 메소드명 : selectAccountNo
	* 작성자명 : 아윤근
	* 기      능 : 회원 네이버 연동 되어있는지 확인 
	*
	* @param accountNo
	* @param field
	* @return User
	*/
	public User selectAccountNo(String accountNo,String field) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		return userDao.selectAccountNo(accountNo,field);
	}
	
	/**
	* 날      짜 : 2018. 6. 22.
	* 메소드명 : updateRole
	* 작성자명 : 아윤근
	* 기      능 : 계정 연동시 권한 부여
	*
	* @param userNo
	* @return Integer
	*/
	public int updateRole(int userNo) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		return userDao.updateRole(userNo);
	}
	
	/**
	* 날      짜 : 2018. 6. 26.
	* 메소드명 : pointCharge
	* 작성자명 : 박주원
	* 기      능 : 유저 포인트 충전
	*
	* @param point
	* @param userNo
	* @return Integer
	*/
	public int pointCharge(int point, int userNo) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		int result = userDao.pointCharge(point, userNo);
		
		return result;
	}
	
	/**
	* 날      짜 : 2018. 6. 26.
	* 메소드명 : updateUserInfo
	* 작성자명 : 박주원
	* 기      능 : 회원 정보 수정
	*
	* @param user
	*/
	public void updateUserInfo(User user) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		userDao.updateUser(user);
	}
	
	/**
	* 날      짜 : 2018. 6. 26.
	* 메소드명 : updateUserPr
	* 작성자명 : 박주원
	* 기      능 : 회원 자기소개 수정
	*
	* @param user
	*/
	public void updateUserPr(User user) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		userDao.updateUserPr(user);
	}
	
	/**
	* 날      짜 : 2018. 6. 26.
	* 메소드명 : updateUserPic
	* 작성자명 : 박주원
	* 기      능 : 회원 프로필 사진 변경
	*
	* @param user
	*/
	public void updateUserPic(User user) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		userDao.updateUserPic(user);
	}
	
	/**
	* 날      짜 : 2018. 7. 6.
	* 메소드명 : bestUploader
	* 작성자명 : 정도혁
	* 기      능 : 최근 7일간 최다 업로더 4명
	*
	* @return List<User>
	*/
	public List<User> bestUploader(){
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		List<User> list = userDao.bestUploader();
		return list;
	}
	
	/**
	* 날      짜 : 2018. 7. 6.
	* 메소드명 : mostFollowingUser
	* 작성자명 : 정도혁
	* 기      능 : 팔로워가 많은 유저 리스트
	*
	* @return List<User>
	*/
	public List<User> mostFollowingUser(){
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		List<User> list = userDao.mostFollowingUser();
		return list;
	}
	
}

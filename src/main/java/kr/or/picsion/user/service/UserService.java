package kr.or.picsion.user.service;

import java.util.ArrayList;
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
	
	public void register(User user) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		userDao.registerUser(user);
		userDao.insertProfile(user.getUserNo());
		userDao.insertAccount(user.getUserNo());
	}
	
	/**
	 * 날      짜 : 2018. 6. 18.
	 * 메소드명 : login
	 * 작성자명 : 
	 *
	 * @param user
	 * @return
	*/
	public User login(User user) {
		
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		User loginUser = userDao.selectUser("userId", user.getUserId());
		
		if(loginUser == null || !user.getPwd().equals(loginUser.getPwd())) {
			loginUser = null;
		}
		
		return loginUser;
	}
	
	public List<User> userList(){
		
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		List<User> userList = userDao.userList();
		return userList;
	}
	
	//팔로잉하고 있는 사람의 최신 사진리스트 가져오기
	public List<Picture> listpic(int userNo) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		List<Picture> followingPic = userDao.followingUserPictureList(userNo);
		return followingPic;
	}
	

	//팔로잉하고 있는 사람의 최신 사진의 주인리스트 가져오기
	public List<User> listpicown(int userNo) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		List<User> followingPicOwner = userDao.followingUserPictureOwnerList(userNo);
		return followingPicOwner;
	}
	
	//userNo로 회원 정보 가져오기
	public User userInfo(int userNo) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		User userInfo = userDao.selectUser("u.userNo",userNo);
		return userInfo;
	}
	
	
		
		
	//회원의 팔로워 리스트
	public List<User> followerUserList(int userNo){
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		List<User> followList = userDao.followerUserList(userNo);
		return followList;
	}
		
	//회원의 팔로잉 리스트
	public List<User> followingUserList(int userNo){
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		List<User> followingList = userDao.followingUserList(userNo);
		return followingList;
	}
	
	//회원이 팔로잉하고 있는지 확인
	public int followingConfirm(int userNo, int followingUserNo) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		int result = userDao.followingConfirm(userNo, followingUserNo);
		return result;
	}
	
	//팔로잉 취소
	public void deleteFollow(int userNo, int followingUserNo) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		userDao.deleteFollow(userNo, followingUserNo);
	}
	
	//팔로잉 insert
	public void insertFollow(int userNo, int followingUserNo) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		userDao.insertFollow(userNo, followingUserNo);
	}
	
	
	//회원의 북마크 리스트
	public List<Picture> bookmarkPicList(int userNo){
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		
		List<Picture> bookmarkList = new ArrayList<Picture>();
		bookmarkList=userDao.bookmarkPicList(userNo);
		
		return bookmarkList;
	}
	
	//회원 탈퇴
	public int userDel(int userNo) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		int result = userDao.deleteUser(userNo);
		return result;
	}
	
	//회원 아이디로 검색
	public User searchUserId(String userId) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		User user = userDao.selectUser("userId", userId);
		return user;
	}
	
	//회원 아이디 연동 정보 update
	public int updateAccountNo(int userNo, String accountNo, String portalSite) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		return userDao.updateAccount(userNo,accountNo,portalSite);
	}
	
	//회원 네이버 연동 되어있는지 확인
	public User selectAccountNo(String accountNo,String field) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		return userDao.selectAccountNo(accountNo,field);
	}
	

}

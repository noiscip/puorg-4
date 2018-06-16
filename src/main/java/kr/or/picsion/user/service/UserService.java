package kr.or.picsion.user.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
		System.out.println("유저 넘버 : " + user.getUserNo());
		userDao.insertProfile(user.getUserNo());
		
	}
	
	public User login(User user) {
		
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		User loginUser = userDao.selectUser(user.getUserId());
		
		if(loginUser == null || !user.getPwd().equals(loginUser.getPwd())) {
			loginUser = null;
		}else {
			//사용자 프로필 테이블 검색해서 set
			User prUser = userDao.selectProfile(loginUser.getUserNo());
			if(prUser != null) {
				loginUser.setPrContent(prUser.getPrContent());
				loginUser.setPrPicture(prUser.getPrPicture());
			}
			User acUser = userDao.selectAccountUserNo(loginUser.getUserNo());
			if(acUser != null) {
				loginUser.setAccountLinkId(acUser.getAccountLinkId());
				System.out.println(acUser.getAccountLinkId());
			}
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
		System.out.println(followingPic);
		return followingPic;
	}
	

	//팔로잉하고 있는 사람의 최신 사진의 주인리스트 가져오기
	public List<User> listpicown(int userNo) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		List<User> followingPicOwner = userDao.followingUserPictureOwnerList(userNo);
		System.out.println(followingPicOwner);
		return followingPicOwner;
	}
	
	//userNo로 회원 정보 가져오기
	public User userInfo(int userNo) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		
		User userInfo = userDao.selectUserNo(userNo);
		User userProfile = userDao.selectProfile(userNo);
		User userAccountLinkId = userDao.selectAccountUserNo(userNo);
		
		userInfo.setPrContent(userProfile.getPrContent());
		userInfo.setPrPicture(userProfile.getPrPicture());
		if(userAccountLinkId != null) {
			userInfo.setAccountLinkId(userAccountLinkId.getAccountLinkId());
		}
		return userInfo;
	}
		
		
	//회원의 팔로워 리스트
	public List<User> followerUserList(int userNo){
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		
		List<User> followList = new ArrayList<User>();
		followList = userDao.followerUserList(userNo);
		
		return followList;
	}
		
	//회원의 팔로잉 리스트
	public List<User> followingUserList(int userNo){
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		
		List<User> followingList = new ArrayList<User>();
		followingList = userDao.followingUserList(userNo);
		
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
		User user = userDao.selectUser(userId);
		return user;
	}
	
	//회원 네이버 아이디 연동 정보 insert
	public int insertAccountLinked(int userNo,String accountNo) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		return userDao.insertAccountLinked(userNo,accountNo);
	}
	
	//회원 네이버 연동 되어있는지 확인
	public User selectAccountLinked(String accountNo) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		User user = userDao.selectAccountNo(accountNo);
		
		return user;
	}
	
}

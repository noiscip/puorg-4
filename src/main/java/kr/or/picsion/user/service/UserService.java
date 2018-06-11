package kr.or.picsion.user.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.picsion.user.dao.UserDao;
import kr.or.picsion.user.dto.User;

@Service
public class UserService {

	@Autowired
	private SqlSession sqlSession;

	
	public void register(User user) {
		
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		userDao.registerUser(user);
	}
	
	public User login(User user) {
		
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		User selectUser = userDao.selectUser(user.getUserId());
		
		if(selectUser == null || !user.getPwd().equals(selectUser.getPwd())) {
			selectUser = null;
		}else {
			//사용자 프로필 테이블 검색해서 set
			User u = userDao.selectProfile(selectUser.getUserNo());
			selectUser.setPrContent(u.getPrContent());
			selectUser.setPrPicture(u.getPrPicture());
		}
		
		return selectUser;
	}
	
	public List<User> userList(){
		
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		List<User> userList = userDao.userList();
		return userList;
	}
	
	
	//userNo로 회원 정보 가져오기
	public User userInfo(int userNo) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		
		User userInfo = userDao.selectUserNo(userNo);
		User userProfile = userDao.selectProfile(userNo);
		
		userInfo.setPrContent(userProfile.getPrContent());
		userInfo.setPrPicture(userProfile.getPrPicture());
		
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
}
